USE [SQL Data Exploration Crime India]
GO

WITH Age_Grouping AS(
    SELECT CAST(ctv.[Victim Age] AS int) AS Age,
    CASE
        WHEN CAST(ctv.[Victim Age] AS int)<18 THEN 'Minor'
        WHEN CAST(ctv.[Victim Age] AS int) BETWEEN 18 AND 60 THEN 'Adult'
        ELSE 'Senior'
    END AS Age_Group
    FROM Crime_Incidents AS ci
    JOIN Crime_Timeline_Victims AS ctv
        ON ci.[Report Number]=ctv.[Report Number]
)
SELECT
    Age_Group,
    COUNT(Age_Group) AS Total_People,
    CAST(
        (COUNT(*) * 100.0) / SUM(COUNT(*)) OVER() 
        AS DECIMAL(5, 2)
        ) AS Percentage_Of_Total_People
FROM Age_Grouping
GROUP BY Age_Group