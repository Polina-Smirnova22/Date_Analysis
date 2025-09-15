SELECT DISTINCT
  T_47dd24ca.C6REiCIedezv AS "C6REiCIedezv",
  T_47dd24ca.g4RpYuNMj6w3 AS "g4RpYuNMj6w3",
  T_47dd24ca.DXgWtns8F7cK AS "DXgWtns8F7cK"
FROM
  (
    SELECT
      "date" AS C6REiCIedezv,
      "count_positive_values" AS g4RpYuNMj6w3,
      '3' AS DXgWtns8F7cK
    FROM
      (
        SELECT
          date,
          count(*) AS count_positive_values
        FROM
          (
            SELECT
              product,
              date,
              CASE
                WHEN (SUM(quantity) / SUM(min_stock_level) - 1) * 100 <= 0 THEN 1
                ELSE 0
              END AS new_value
            FROM
              src.smirnova_zadanie_1_2741000001827
            WHERE
              date <= '2025-04-06T00:00:00'
  -- В исходном запросе используется настраиваемый фильтр [**xxx]. В конечном запросе фильтр отображается в виде перечисления входящих данных.
              AND 'Блокноты|||Ежедневники|||Карандаши|||Кисти художественные|||Краски для рисования|||Маркеры|||Мольберты|||Ручки|||Скетчбуки|||Тетради' LIKE '%' || category || '%'
  GROUP BY
              product,
              date
          ) AS subquery
        WHERE
          new_value = 1
        GROUP BY
          date
      ) N_1a84a390
    LIMIT
      10000
  ) AS T_47dd24ca
ORDER BY
  "C6REiCIedezv" ASC
OFFSET
  0
