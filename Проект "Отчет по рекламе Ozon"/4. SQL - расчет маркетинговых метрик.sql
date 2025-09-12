SELECT 
    t1.date,
    SUM(t1.views) AS views,
    SUM(t1.clicks) AS clicks,
    SUM(t1.spent_) AS spent,
    SUM(t1.basket) AS basket,
    SUM(t1.orders) AS orders,
    SUM(t1.orders_money_) AS orders_money_,
    ROUND((SUM(t1.spent_) / SUM(t1.orders_money_)) * 100, 2) AS DRR,
    ROUND(SUM(t1.spent_) / SUM(t1.orders), 2) AS CPO,
    ROUND(SUM(t1.spent_) / SUM(t1.views) * 1000, 2) AS CPM,
    ROUND(SUM(t1.spent_) / SUM(t1.clicks), 2) AS CPC,
    ROUND((SUM(t1.orders_money_) - SUM(t1.spent_)) / SUM(t1.spent_), 2) AS ROMI
FROM src.test1_2741000005416 t1
JOIN src.test2_2741000005417 t2 ON t1.campaign_id = t2.campaign_id
GROUP BY t1.date
ORDER BY t1.date DESC
