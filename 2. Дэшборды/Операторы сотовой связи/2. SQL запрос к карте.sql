SELECT
  T_d7916801.Q62xkg2Dvymk AS "Q62xkg2Dvymk",
  T_d7916801.sSJpn6burTFG AS "sSJpn6burTFG",
  T_d7916801.WxxL2JSO1KpV AS "WxxL2JSO1KpV",
  T_d7916801.M1wJ90BQHe64 AS "M1wJ90BQHe64",
  T_d7916801.I4oLs7HGq24y AS "I4oLs7HGq24y"
FROM
  (
    SELECT
      sgroup AS Q62xkg2Dvymk,
      scategorymediumname AS sSJpn6burTFG,
      nresourceid AS WxxL2JSO1KpV,
      nbacklayerresourceid AS M1wJ90BQHe64,
      ssubcategorymediumname AS I4oLs7HGq24y
    FROM
      info.v_dicresourcemap
    WHERE
      sgroup = 'РФ (по федеральным округам)'
      AND scategorymediumname = 'Центральный федеральный округ'
    LIMIT
      10000
  ) AS T_d7916801
OFFSET
  0
