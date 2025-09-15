SELECT
  T_975a818d.sCQrkkH9OhdE AS "sCQrkkH9OhdE",
  T_975a818d.SeHNGHuGLXR4 AS "SeHNGHuGLXR4",
  T_975a818d.ps8uZFHHRjxw AS "ps8uZFHHRjxw",
  T_975a818d.ksVYbjEkDhyH AS "ksVYbjEkDhyH",
  T_975a818d.vgyD98wxeIYs AS "vgyD98wxeIYs",
  T_975a818d.XGSLJI71d0UK AS "XGSLJI71d0UK",
  T_975a818d.a7OmopYuJzxA AS "a7OmopYuJzxA",
  T_975a818d.cBVdRllQtizT AS "cBVdRllQtizT",
  T_975a818d.fB5JPpBYY4Sm AS "fB5JPpBYY4Sm",
  T_975a818d.p7x6UEZtGdKm AS "p7x6UEZtGdKm",
  T_975a818d.koQxoLjY5OsM AS "koQxoLjY5OsM",
  T_975a818d.x8d0IdPqKydc AS "x8d0IdPqKydc",
  T_975a818d.JnSOVVihDiUT AS "JnSOVVihDiUT",
  T_975a818d.SFPs0kOXXLLl AS "SFPs0kOXXLLl",
  T_975a818d.yveS38u8wyTu AS "yveS38u8wyTu",
  T_975a818d.uP5HOFanDr5P AS "uP5HOFanDr5P",
  T_975a818d.MdinGLzttLGj AS "MdinGLzttLGj",
  T_975a818d.afjHXoAuFBkM AS "afjHXoAuFBkM",
  T_975a818d.HTzyVuooTNCK AS "HTzyVuooTNCK",
  T_975a818d.tHQFYma73fiy AS "tHQFYma73fiy",
  T_975a818d.Ulfkh1wNWqbM AS "Ulfkh1wNWqbM",
  T_975a818d.fyvVjPCRMVCP AS "fyvVjPCRMVCP"
FROM
  (
    SELECT
      CASE level_3
        WHEN 'Ежедневно' THEN 1
        WHEN 'Еженедельно' THEN 2
        WHEN 'Ежемесячно' THEN 3
        WHEN 'Ежеквартально' THEN 4
        ELSE 5
      END AS sCQrkkH9OhdE,
      'Главная' AS SeHNGHuGLXR4,
      "name_folder" AS ps8uZFHHRjxw,
      "name_report" AS ksVYbjEkDhyH,
      "version" AS vgyD98wxeIYs,
      "ddate" AS XGSLJI71d0UK,
      "level_3" AS a7OmopYuJzxA,
      "level_2" AS cBVdRllQtizT,
      "level_1" AS fB5JPpBYY4Sm,
      "name_doc" AS p7x6UEZtGdKm,
      "business_block" AS koQxoLjY5OsM,
      "name" AS x8d0IdPqKydc,
      "number" AS JnSOVVihDiUT,
      "role" AS SFPs0kOXXLLl,
      "url" AS yveS38u8wyTu,
      "name_short" AS uP5HOFanDr5P,
      "dashboard" AS MdinGLzttLGj,
      "count_files" AS afjHXoAuFBkM,
      "count_report" AS HTzyVuooTNCK,
      "count_report_level_3" AS tHQFYma73fiy,
      "count_report_level_2" AS Ulfkh1wNWqbM,
      "count_report_level_1" AS fyvVjPCRMVCP
    FROM
      (
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
          name_folder,
          name_report,
          version,
          ddate,
          level_3,
          level_2,
          level_1,
          name_doc,
          business_block,
          name,
          number,
          role,
          url,
          name_short,
          dashboard,
          count_files,
          count_report,
          sum(count_report) over (
            partition by
              level_1,
              level_2,
              level_3
          ) as count_report_level_3,
          sum(count_report) over (
            partition by
              level_1,
              level_2
          ) as count_report_level_2,
          sum(count_report) over (
            partition by
              level_1
          ) as count_report_level_1
        FROM
          cte
        WHERE
          rn = 1
          AND CASE
            WHEN 'ON' = 'OFF' THEN ddate = '2025-06-20'
            ELSE ddate <= '2025-06-20'
          END
          AND name_folder in (
            'Проба',
            'Отчет 2',
            'Еженедельный отчет по размещению_привлечению',
            'Отчет 1',
            'Дэшборды Навигатор',
            'ПСБ тест 2306',
            'Тест'
          )
          AND CASE
            WHEN 'Все' <> 'Все' THEN level_2 IN (
              'NIM объем (конкуренты, реакция на изменение КС, клиенты)',
              'РСБУ ежемесячный',
              'Сегментная отчетность: ДЗО ОПУ',
              'Материалы',
              'Отчет для ПМ',
              'Сегментная отчетность: территории',
              'РСБУ (источник внутренние отчеты получ.по МБК)',
              'Драйверы CIR, статьи расходов, показатели на сотрудника',
              'Нормативы ВПОДК (факторы вли-я)',
              'Еженедельная отчетность (ставки)',
              'Лимиты казны (3)',
              'МСФО (УСИ,ДСПР)',
              'КБ отраслевые риски',
              'Еженедельная отчетность (баланс)',
              'Процентный риск (2)',
              'Клиенты / Средний чек / ROE маржа / Риски / Масс / Клиенты (1)',
              'Материалы КУАП / МСФО',
              'Концентрация',
              'Сегментная отчетность: сегмент, канал, продукт',
              'Буфер ликвидности ан. (структура)',
              'Рыночный риск (1)',
              'Капитал',
              'Ликвидность',
              'NIM % (конкуренты, реакция на изменение КС, клиенты)'
            )
            ELSE level_2 IN ('Нормативы ВПОДК (факторы вли-я)')
          END
          AND CASE
            WHEN 'Все' = 'Все' THEN name_folder in (name_folder)
            ELSE name_folder in ('Все')
          END
          AND name_folder = name_report
      ) N_05f8b10b
    LIMIT
      10000
  ) AS T_975a818d
ORDER BY
  "koQxoLjY5OsM" ASC,
  "ps8uZFHHRjxw" ASC,
  "a7OmopYuJzxA" ASC,
  "x8d0IdPqKydc" ASC,
  "XGSLJI71d0UK" ASC
OFFSET
  0
