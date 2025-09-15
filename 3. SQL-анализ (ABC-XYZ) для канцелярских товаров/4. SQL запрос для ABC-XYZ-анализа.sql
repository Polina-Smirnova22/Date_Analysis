
WITH abc AS
    (WITH cte AS 
        (SELECT b.category, a.category_id,
        COALESCE(SUM(a.august),0) AS orders
        FROM src.abs_analiz_zakazi_2741000005436 a LEFT JOIN src.abs_analiz_kategorii_2741000005437 b ON a.category_id = b.category_id
        GROUP BY b.category, a.category_id)
    SELECT *,
    CASE 
    WHEN SUM(orders) OVER(ORDER BY orders DESC) / SUM(orders) OVER(ORDER BY orders DESC ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) <= 0.8 THEN 'A'
    WHEN SUM(orders) OVER(ORDER BY orders DESC) / SUM(orders) OVER(ORDER BY orders DESC ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) <= 0.95 THEN 'B'
    ELSE 'C'
    END AS abc_group
    FROM cte
    ORDER BY abc_group, orders DESC) ,

 xyz AS 
    (WITH cte AS 
    (SELECT category_id, january AS orders, 'Январь' AS month
    FROM src.abs_analiz_zakazi_2741000005436

    UNION ALL

    SELECT category_id, february AS orders, 'Февраль' AS month
    FROM src.abs_analiz_zakazi_2741000005436

    UNION ALL

    SELECT category_id, march AS orders, 'Март' AS month
    FROM src.abs_analiz_zakazi_2741000005436

    UNION ALL

    SELECT category_id, april AS orders, 'Апрель' AS month
    FROM src.abs_analiz_zakazi_2741000005436

    UNION ALL

    SELECT category_id, may AS orders, 'Май' AS month
    FROM src.abs_analiz_zakazi_2741000005436

    UNION ALL

    SELECT category_id, june AS orders, 'Июнь' AS month
    FROM src.abs_analiz_zakazi_2741000005436

    UNION ALL

    SELECT category_id, july AS orders, 'Июль' AS month
    FROM src.abs_analiz_zakazi_2741000005436

    UNION ALL

    SELECT category_id, august AS orders, 'Август' AS month
    FROM src.abs_analiz_zakazi_2741000005436)


SELECT category_id, 
CASE 
    WHEN STDDEV_POP(orders) / NULLIF(AVG(orders),0) * 100 <= 10 THEN 'X'
    WHEN STDDEV_POP(orders) / NULLIF(AVG(orders),0) * 100 <= 25 THEN 'Y'
    ELSE 'Z'
END AS xyz_group
FROM cte
GROUP BY category_id
ORDER BY category_id)

SELECT abc.category, CONCAT(abc.abc_group, xyz.xyz_group) AS final_group
FROM abc LEFT JOIN xyz ON abc.category_id = xyz.category_id
ORDER BY final_group
