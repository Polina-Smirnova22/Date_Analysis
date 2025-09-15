SELECT 
    attendance_date,
    CASE
    WHEN [**tabs] = 'Присутствие' 
    THEN
    SUM(status0_1) / COUNT(status0_1) * 100
    ELSE (COUNT(status0_1) - SUM(status0_1)) / COUNT(status0_1) * 100 
    END AS parametr
FROM 
    src.smirnova_zadanie_2_2741000001934
WHERE
        attendance_date <= [**date1]
        AND
    [**department] LIKE '%' || department || '%'
    AND
    [**otdel] LIKE '%' || subdivision || '%'
        GROUP BY 
attendance_date
    order by  attendance_date asc
