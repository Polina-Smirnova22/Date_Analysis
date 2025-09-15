SELECT 
    department,
    SUM(status0_1) / COUNT(status) * 100 AS avg_status_per_day,
    DATE_TRUNC('month', attendance_date) AS month,
    COUNT(*) AS record_count,
    CASE
    WHEN [**tabs] = 'Присутствие' 
    THEN SUM(status0_1) / COUNT(status) * 100
    ELSE (COUNT(status) - SUM(status0_1)) / COUNT(status) * 100
END AS parametr

FROM 
src.smirnova_zadanie_2_2741000001934
    
WHERE
    [**department] LIKE '%' || department || '%'
    AND
    [**otdel] LIKE '%' || subdivision || '%'
GROUP BY 
    department, DATE_TRUNC('month', attendance_date)
ORDER BY 
     avg_status_per_day ASC
