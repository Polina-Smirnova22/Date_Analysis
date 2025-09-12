SELECT 
    t1.id,
    t1.campaign_id,
    t1.title,
    t1.manager,
    t2.date,
    t2.views,
    t2.clicks,
    t2.spent,
    t2.basket,
    t2.orders,
    t2.orders_money,
    ROUND((t2.spent / t2.orders_money) * 100, 2) AS ДРР,
    ROUND(t2.spent / t2.orders, 2) AS CPO,
    ROUND((t2.spent / t2.views) * 1000, 2) AS CPM,
    ROUND(t2.spent / t2.clicks, 2) AS CPC,
    ROUND((t2.orders_money - t2.spent) / t2.spent, 2) AS ROMI
FROM test1 t1
JOIN test2 t2 ON t1.campaign_id = t2.campaign_id
ORDER BY t1.id ASC;
