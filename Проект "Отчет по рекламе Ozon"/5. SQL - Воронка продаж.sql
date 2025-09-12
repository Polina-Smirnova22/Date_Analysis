SELECT 
    t1.date,
    SUM(t1.views) AS views,
    'Показы' AS type
FROM src.test1_2741000005416 t1
JOIN src.test2_2741000005417 t2 ON t1.campaign_id = t2.campaign_id
GROUP BY t1.date

UNION ALL

SELECT 
    t1.date,
    SUM(t1.clicks) AS clicks,
    'Клики' AS type
FROM src.test1_2741000005416 t1
JOIN src.test2_2741000005417 t2 ON t1.campaign_id = t2.campaign_id
GROUP BY t1.date

UNION ALL

SELECT 
    t1.date,
    SUM(t1.basket) AS basket,
    'Добавлено в корзину' AS type
FROM src.test1_2741000005416 t1
JOIN src.test2_2741000005417 t2 ON t1.campaign_id = t2.campaign_id
GROUP BY t1.date

UNION ALL

SELECT 
    t1.date,
    SUM(t1.orders) AS orders,
    'Заказы' AS type
FROM src.test1_2741000005416 t1
JOIN src.test2_2741000005417 t2 ON t1.campaign_id = t2.campaign_id
GROUP BY t1.date
