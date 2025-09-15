SELECT
  T_e074f5c3.PSSHRBF65PHF AS "PSSHRBF65PHF",
  T_e074f5c3.jcTpyAYmLTct AS "jcTpyAYmLTct",
  T_e074f5c3.BwIQnTBl8CWo AS "BwIQnTBl8CWo",
  T_e074f5c3.GLWdXD92BMLP AS "GLWdXD92BMLP",
  T_e074f5c3.FbOHXa7J7Ui2 AS "FbOHXa7J7Ui2",
  T_e074f5c3.btfM1rYUJxNY AS "btfM1rYUJxNY",
  T_e074f5c3.pqBZIqvAG1Ix AS "pqBZIqvAG1Ix",
  T_e074f5c3.s68nvlktK10K AS "s68nvlktK10K"
FROM
  (
    SELECT
      "category" AS PSSHRBF65PHF,
      "product" AS jcTpyAYmLTct,
      "sum" AS BwIQnTBl8CWo,
      CASE
        WHEN product IS NOT NULL THEN product
        WHEN product IS NULL
        AND category IS NOT NULL THEN category
        ELSE 'Всего'
      END AS GLWdXD92BMLP,
      "turnover" AS FbOHXa7J7Ui2,
      turnover - 90 AS btfM1rYUJxNY,
      (turnover / 90 -1) * 100 AS pqBZIqvAG1Ix,
      "min_stock" AS s68nvlktK10K
    FROM
      (
        SELECT
          category,
          product,
          SUM(quantity),
          AVG(turnover) AS turnover,
          SUM(min_stock_level) AS min_stock
        FROM
          src.smirnova_zadanie_1_2741000001827
        WHERE
          date = '2025-04-06T00:00:00'
        GROUP BY
          ROLLUP (category, product)
      ) N_d785fbee
    LIMIT
      10000
  ) AS T_e074f5c3
ORDER BY
  "PSSHRBF65PHF" ASC,
  "jcTpyAYmLTct" ASC
OFFSET
  0
