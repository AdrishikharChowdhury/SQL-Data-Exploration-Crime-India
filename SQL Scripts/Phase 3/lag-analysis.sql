USE [SQL Data Exploration Crime India]
GO

WITH Crime_Timeline_Analysis AS (
    SELECT
        ci.[Crime Domain] AS Crime_Domain,
        TRY_CAST(ctv.[Date of Occurrence] AS DATETIME2) AS Occurrence_Dates,
        TRY_CAST(ctv.[Date Reported] AS DATETIME2) AS Reported_Dates
    FROM Crime_Incidents AS ci
    JOIN Crime_Timeline_Victims AS ctv
        ON ci.[Report Number]=ctv.[Report Number]
)
SELECT Crime_Domain,
   COUNT(*) AS Total_Crimes,
    AVG(DATEDIFF(hour, Occurrence_Dates,Reported_Dates)) AS Avg_Lag_Hours,
    MAX(DATEDIFF(hour, Occurrence_Dates,Reported_Dates)) AS Max_Lag_Hours,
    MIN(DATEDIFF(hour, Occurrence_Dates,Reported_Dates)) AS Min_Lag_Hours
FROM Crime_Timeline_Analysis
WHERE Reported_Dates IS NOT NULL AND 
Occurrence_Dates IS NOT NULL AND 
DATEDIFF(hour, Occurrence_Dates, Reported_Dates) >= 0
GROUP BY Crime_Domain
ORDER BY Avg_Lag_Hours DESC
