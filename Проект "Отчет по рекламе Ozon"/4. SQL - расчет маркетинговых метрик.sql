SELECT 
    t2.id,
    t2.campaign_id,
    t2.title,
    t2.manager,
    t1.date,
    t1.views,
    t1.clicks,
    t1.spent,
    t1.basket,
    t1.orders,
    t1.orders_money,
    ROUND((t2.spent / t2.orders_money) * 100, 2) AS ДРР,
    ROUND(t2.spent / t2.orders, 2) AS CPO,
    ROUND((t2.spent / t2.views) * 1000, 2) AS CPM,
    ROUND(t2.spent / t2.clicks, 2) AS CPC,
    ROUND((t2.orders_money - t2.spent) / t2.spent, 2) AS ROMI
FROM src.test1_2741000005416 t1
JOIN src.test2_2741000005417 t2 ON t1.campaign_id = t2.campaign_id
ORDER BY t1.id ASC;
