SELECT
  T_1e0171d6.j4mQYZy1zpNm AS "j4mQYZy1zpNm",
  T_1e0171d6.L72Nxk2tZDoD AS "L72Nxk2tZDoD",
  T_1e0171d6.VolOYmyO6NbW AS "VolOYmyO6NbW",
  T_1e0171d6.ZagZZM7SDz5H AS "ZagZZM7SDz5H",
  T_1e0171d6.GnOwuyTEVcO7 AS "GnOwuyTEVcO7",
  T_1e0171d6.Qu4y4dUVlU38 AS "Qu4y4dUVlU38"
FROM
  (
    SELECT
      "department" AS j4mQYZy1zpNm,
      "subdivision" AS L72Nxk2tZDoD,
      "parameter" AS VolOYmyO6NbW,
      CASE
        WHEN subdivision IS NOT NULL THEN subdivision
        WHEN subdivision IS NULL
        AND department IS NOT NULL THEN department
        ELSE 'Всего'
      END AS ZagZZM7SDz5H,
      "employee" AS GnOwuyTEVcO7,
      (parameter / employee) * 100 AS Qu4y4dUVlU38
    FROM
      (
        WITH
          cte AS (
            SELECT
              department,
              subdivision,
              COUNT(employee_id) AS employee,
              CASE
                WHEN 'Присутствие' = 'Присутствие' THEN SUM(status0_1)
                ELSE COUNT(employee_id) - SUM(status0_1)
              END AS parameter
            FROM
              src.smirnova_zadanie_2_2741000001934
            WHERE
              attendance_date = '2024-02-09T00:00:00'
              AND 'HR|||IT|||Маркетинг|||Продажи' LIKE '%' || department || '%'
              AND 'E-commerce|||Retail|||Аналитики|||Дизайнеры|||Кадры|||Копирайтеры|||Обучение|||Программисты' LIKE '%' || subdivision || '%'
            GROUP BY
              department,
              subdivision
          )
        SELECT
          department,
          subdivision,
          SUM(employee) employee,
          SUM(parameter) parameter
        FROM
          cte
        GROUP BY
          ROLLUP (department, subdivision)
      ) N_65d6c858
    LIMIT
      10000
  ) AS T_1e0171d6
ORDER BY
  "j4mQYZy1zpNm" ASC,
  "L72Nxk2tZDoD" ASC
OFFSET
  0
