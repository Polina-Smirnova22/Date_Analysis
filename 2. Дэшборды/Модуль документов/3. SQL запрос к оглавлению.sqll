SELECT
  T_614fc4de.EEq018cw49G6 AS "EEq018cw49G6",
  T_614fc4de.Iisyrr93sHFN AS "Iisyrr93sHFN",
  T_614fc4de.qLU5Dc7nZ81x AS "qLU5Dc7nZ81x",
  T_614fc4de.WTG51issiCoq AS "WTG51issiCoq",
  T_614fc4de.UeYf1xbYHwfQ AS "UeYf1xbYHwfQ",
  T_614fc4de.MB8D0tcVX3cC AS "MB8D0tcVX3cC",
  T_614fc4de.PuVlsVXP5K0m AS "PuVlsVXP5K0m",
  T_614fc4de.rVXGfMwQk3NL AS "rVXGfMwQk3NL"
FROM
  (
    SELECT
      "level_1" AS EEq018cw49G6,
      "level_2" AS Iisyrr93sHFN,
      CASE
        WHEN level_2 IS NOT NULL THEN level_2
        WHEN level_2 IS NULL
        AND level_1 IS NOT NULL THEN level_1
      END AS qLU5Dc7nZ81x,
      CASE
        WHEN level_2 IS NOT NULL THEN CASE
          WHEN report_count IS NOT NULL THEN CONCAT(level_2, ' (', report_count, ')')
          ELSE level_2
        END
        WHEN level_2 IS NULL
        AND level_1 IS NOT NULL THEN CASE
          WHEN report_count IS NOT NULL THEN CONCAT(level_1, ' (', report_count, ')')
          ELSE level_1
        END
      END AS WTG51issiCoq,
      "sort" AS UeYf1xbYHwfQ,
      CASE
        WHEN level_2 = 'Нормативы ВПОДК (факторы вли-я)' THEN 0
        ELSE ROW_NUMBER() OVER (
          ORDER BY
            sort
        )
      END AS MB8D0tcVX3cC,
      CASE
        WHEN 'Все' = 'Все' THEN (
          (
            ROW_NUMBER() OVER (
              ORDER BY
                sort
            )
          ) = '3'
        )::INT
        ELSE 0
      END AS PuVlsVXP5K0m,
      "report_count" AS rVXGfMwQk3NL
    FROM
      (
        WITH
          cte_report_count AS (
            WITH
              cte AS (
                WITH
                  cte AS (
                    WITH
                      cte AS (
                        WITH
                          cte AS (
                            WITH
                              cte AS (
                                WITH
                                  cte AS (
                                    WITH
                                      cte AS (
                                        WITH
                                          cte AS (
                                            WITH
                                              cte AS (
                                                SELECT
                                                  g.sname AS name_folder,
                                                  g.nparentid AS parent,
                                                  g.nid AS nid,
                                                  r.nid AS name_doc,
                                                  CASE
                                                    WHEN SUBSTRING(r.sname, 1, 10) SIMILAR TO '([[:digit:]]){4}-((0[1-9]|1[0-2]))-(0[1-9]|[12][0-9]|3[01])' THEN SUBSTRING(
                                                      r.sname
                                                      FROM
                                                        15 FOR char_length(r.sname) - position('.' IN REVERSE(r.sname)) - 14
                                                    )
                                                    ELSE 'Ошибка в дате'
                                                  END AS name_report,
                                                  CASE
                                                    WHEN SUBSTRING(r.sname, 1, 10) SIMILAR TO '([[:digit:]]){4}-((0[1-9]|1[0-2]))-(0[1-9]|[12][0-9]|3[01])' THEN SUBSTRING(
                                                      r.sname
                                                      FROM
                                                        12 FOR 2
                                                    )
                                                    ELSE '5'
                                                  END AS version,
                                                  CASE
                                                    WHEN SUBSTRING(r.sname, 1, 10) SIMILAR TO '([[:digit:]]){4}-((0[1-9]|1[0-2]))-(0[1-9]|[12][0-9]|3[01])' THEN TO_DATE(SUBSTRING(r.sname, 1, 10), 'YYYY-MM-DD')
                                                    ELSE TO_DATE('2030-01-01', 'YYYY-MM-DD')
                                                  END AS ddate
                                                FROM
                                                  rb.report r
                                                  JOIN rb.group g ON r.ngroupid = g.nid
                                              )
                                            SELECT
                                              c.name_folder AS name_folder,
                                              c.parent AS parent,
                                              c.nid AS nid,
                                              c.name_doc AS name_doc,
                                              c.name_report AS name_report,
                                              c.version AS version,
                                              c.ddate AS ddate,
                                              g.sname AS level_3,
                                              1 as count
                                            FROM
                                              cte c
                                              JOIN rb.group g ON c.parent = g.nid
                                          )
                                        SELECT
                                          c.name_folder AS name_folder,
                                          c.parent AS parent,
                                          c.nid AS nid,
                                          c.name_doc AS name_doc,
                                          c.name_report AS name_report,
                                          c.version AS version,
                                          c.ddate AS ddate,
                                          c.level_3 AS level_3,
                                          g.nparentid AS parent_2,
                                          sum(c.count) OVER (
                                            PARTITION BY
                                              g.nparentid,
                                              c.level_3,
                                              c.name_folder,
                                              c.name_report
                                          ) as count_files
                                        FROM
                                          cte c
                                          JOIN rb.group g ON c.parent = g.nid
                                          --GROUP BY c.name_folder, c.parent, c.nid, c.name_doc, c.name_report, c.version, c.ddate, c.level_3, g.nparentid
                                      )
                                    SELECT
                                      c.name_folder AS name_folder,
                                      c.parent AS parent,
                                      c.nid AS nid,
                                      c.name_doc AS name_doc,
                                      c.name_report AS name_report,
                                      c.version AS version,
                                      c.ddate AS ddate,
                                      c.level_3 AS level_3,
                                      c.parent_2 AS parent_2,
                                      g.sname AS level_2,
                                      c.count_files as count_files
                                      --,case when c.count_files >= 1 then count(c.name_folder) OVER (PARTITION BY g.sname, /*c.parent_2,*/ c.level_3) end count_report
,
                                      case
                                        when c.count_files >= 1 then 1
                                      end count_report
                                    FROM
                                      cte c
                                      JOIN rb.group g ON c.parent_2 = g.nid
                                    WHERE
                                      level_3 IN (
                                        'Ежедневно',
                                        'Еженедельно',
                                        'Ежемесячно',
                                        'Ежеквартально'
                                      )
                                      AND (
                                        level_3 = CASE
                                          WHEN 'Все' = 'Все' THEN level_3
                                          ELSE 'Все'
                                        END
                                      )
                                      AND version = '01'
                                  )
                                SELECT
                                  c.name_folder AS name_folder,
                                  c.parent AS parent,
                                  c.nid AS nid,
                                  c.name_doc AS name_doc,
                                  c.name_report AS name_report,
                                  c.version AS version,
                                  c.ddate AS ddate,
                                  c.level_3 AS level_3,
                                  c.parent_2 AS parent_2,
                                  c.level_2 AS level_2,
                                  g.nparentid AS parent_3,
                                  c.count_files as count_files,
                                  c.count_report as count_report
                                  --,sum(c.count_report) OVER (PARTITION BY g.nparentid, c.level_2, c.level_3, c.name_folder) as count_report_level_2
                                FROM
                                  cte c
                                  JOIN rb.group g ON c.parent_2 = g.nid
                              )
                            SELECT
                              c.name_folder AS name_folder,
                              c.parent AS parent,
                              c.nid AS nid,
                              c.name_doc AS name_doc,
                              c.name_report AS name_report,
                              c.version AS version,
                              c.ddate AS ddate,
                              c.level_3 AS level_3,
                              c.parent_2 AS parent_2,
                              c.level_2 AS level_2,
                              c.parent_3 AS parent_3,
                              g.sname AS level_1,
                              c.count_files as count_files,
                              c.count_report as count_report
                              --,c.count_report_level_2 as count_report_level_2
                            FROM
                              cte c
                              JOIN rb.group g ON c.parent_3 = g.nid
                          )
                        SELECT
                          c.name_folder AS name_folder,
                          c.parent AS parent,
                          c.nid AS nid,
                          c.name_doc AS name_doc,
                          c.name_report AS name_report,
                          c.version AS version,
                          c.ddate AS ddate,
                          c.level_3 AS level_3,
                          c.parent_2 AS parent_2,
                          c.level_2 AS level_2,
                          c.parent_3 AS parent_3,
                          c.level_1 AS level_1,
                          g.nparentid AS parent_4,
                          c.count_files as count_files,
                          c.count_report as count_report
                          --,c.count_report_level_2 as count_report_level_2
                        FROM
                          cte c
                          JOIN rb.group g ON c.parent_3 = g.nid
                      )
                    SELECT
                      c.name_folder AS name_folder,
                      c.parent AS parent,
                      c.nid AS nid,
                      c.name_doc AS name_doc,
                      c.name_report AS name_report,
                      c.version AS version,
                      c.ddate AS ddate,
                      c.level_3 AS level_3,
                      c.parent_2 AS parent_2,
                      c.level_2 AS level_2,
                      c.parent_3 AS parent_3,
                      c.level_1 AS level_1,
                      c.parent_4 AS parent_4,
                      g.sname AS business_block,
                      c.count_files as count_files,
                      c.count_report as count_report
                      --,c.count_report_level_2 as count_report_level_2
                    FROM
                      cte c
                      JOIN rb.group g ON c.parent_4 = g.nid
                  )
                SELECT
                  c.name_folder AS name_folder,
                  c.name_report AS name_report,
                  c.version AS version,
                  c.ddate AS ddate,
                  c.level_3 AS level_3,
                  c.level_2 AS level_2,
                  c.level_1 AS level_1,
                  C.name_doc AS name_doc,
                  c.business_block AS business_block,
                  s.name AS name,
                  s.number AS number,
                  s.role AS role,
                  s.url AS url,
                  s.name_short AS name_short,
                  s.dashboard AS dashboard,
                  c.count_files as count_files,
                  c.count_report as count_report
                  --,c.count_report_level_2 as count_report_level_2
,
                  ROW_NUMBER() OVER (
                    PARTITION BY
                      c.name_folder,
                      c.level_3,
                      c.level_2,
                      c.level_1,
                      c.business_block
                    ORDER BY
                      ddate DESC
                  ) AS rn
                FROM
                  cte c
                  JOIN src.psb_fin_blok_struktura_2741000004604 s ON CONCAT(
                    c.business_block,
                    c.level_1,
                    c.level_2,
                    c.level_3,
                    c.name_folder
                  ) = CONCAT(
                    s.business_block,
                    s.level_1,
                    s.level_2,
                    s.level_3,
                    s.level_4
                  )
                WHERE
                  c.business_block IN ('ОФД', 'Проверка')
              )
            SELECT
              count(name_folder) as report_count,
              level_2,
              level_1
            FROM
              cte
            WHERE
              rn = 1
              /*AND
              CASE
              WHEN 'ON' = 'OFF'
              THEN ddate = '2025-06-20'
              ELSE ddate <= '2025-06-20'
              END
              AND name_folder in ('Проба','Отчет 2','Еженедельный отчет по размещению_привлечению','Отчет 1','Дэшборды Навигатор','ПСБ тест 2306','Тест')
              AND 
              CASE WHEN 'Все' <> 'Все' THEN level_2 IN ('NIM объем (конкуренты, реакция на изменение КС, клиенты)','РСБУ ежемесячный','Сегментная отчетность: ДЗО ОПУ','Материалы','Отчет для ПМ','Сегментная отчетность: территории','РСБУ (источник внутренние отчеты получ.по МБК)','Драйверы CIR, статьи расходов, показатели на сотрудника','Нормативы ВПОДК (факторы вли-я)','Еженедельная отчетность (ставки)','Лимиты казны (3)','МСФО (УСИ,ДСПР)','КБ отраслевые риски','Еженедельная отчетность (баланс)','Процентный риск (2)','Клиенты / Средний чек / ROE маржа / Риски / Масс / Клиенты (1)','Материалы КУАП / МСФО','Концентрация','Сегментная отчетность: сегмент, канал, продукт','Буфер ликвидности ан. (структура)','Рыночный риск (1)','Капитал','Ликвидность','NIM % (конкуренты, реакция на изменение КС, клиенты)') ELSE 
              level_2 IN ('Нормативы ВПОДК (факторы вли-я)') END*/
              AND CASE
                WHEN 'Все' = 'Все' THEN name_folder in (name_folder)
                ELSE name_folder in ('Все')
              END
              AND name_folder = name_report
            group by
              rollup (level_1, level_2)
            having
              level_1 is not null
          ),
          cte_main as (
            SELECT
              level_1,
              level_2,
              MIN(sort) AS sort
            FROM
              src.psb_fin_blok_struktura_2741000004604
            GROUP BY
              ROLLUP (level_1, level_2)
            HAVING
              NOT (
                level_1 IS NULL
                AND level_2 IS NULL
              )
          )
        SELECT
          cte_main.level_1,
          cte_main.level_2,
          cte_main.sort,
          cte_report_count.level_1 as level_1_count,
          cte_report_count.level_2 as level_2_count,
          cte_report_count.report_count
        FROM
          cte_main
          LEFT JOIN cte_report_count ON concat(cte_main.level_1, cte_main.level_2) = concat(
            cte_report_count.level_1,
            cte_report_count.level_2
          )
      ) N_c3bbdb50
    LIMIT
      10000
  ) AS T_614fc4de
ORDER BY
  "UeYf1xbYHwfQ" ASC
OFFSET
  0
