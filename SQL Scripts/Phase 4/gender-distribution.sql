USE [SQL Data Exploration Crime India]
GO

WITH Gender_Distribution AS (
    SELECT 
        ci.[Crime Domain] AS Crime_Domain,
        CASE
            WHEN ctv.[Victim Gender] = 'M' THEN 'Male'
            WHEN ctv.[Victim Gender] = 'F' THEN 'Female'
            ELSE 'Others'
        END AS Gender_Group
    FROM Crime_Incidents AS ci
    JOIN Crime_Timeline_Victims AS ctv
    ON ci.[Report Number]=ctv.[Report Number]
)
SELECT Crime_Domain,
    Gender_Group,
    COUNT(Gender_Group) AS Total_People,
    CAST(
        (COUNT(*) * 100.0) / SUM(COUNT(*)) OVER(PARTITION BY Crime_Domain) 
        AS DECIMAL(5, 2)
        ) AS Percentage_Of_Genders
FROM Gender_Distribution
GROUP BY Crime_Domain,Gender_Group
ORDER BY Percentage_Of_Genders DESC