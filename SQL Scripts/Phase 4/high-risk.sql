USE [SQL Data Exploration Crime India]
GO

WITH High_Risk_Analysis AS (
    SELECT ci.City AS Incident_Cities,
        TRY_CAST(ctv.[Victim Age] AS int) AS Age,
        ci.[Crime Domain] AS Crime_Domain,
        CASE
            WHEN TRY_CAST(ctv.[Victim Age] AS int)<18 THEN 'Minor'
            WHEN TRY_CAST(ctv.[Victim Age] AS int) BETWEEN 18 AND 60 THEN 'Adult'
            ELSE 'Senior'
        END AS Age_Group
    FROM Crime_Incidents AS ci
    JOIN Crime_Timeline_Victims AS ctv
        ON ci.[Report Number]=ctv.[Report Number]
)
SELECT Incident_Cities,Age_Group,Crime_Domain,
COUNT(Age_Group) AS Total_People,
CAST(
    (COUNT(*) * 100.0) / SUM(COUNT(*)) OVER(PARTITION BY Crime_Domain) 
    AS DECIMAL(5, 2)
    ) AS Percentage_Of_Total_People
FROM High_Risk_Analysis
GROUP BY Age_Group,Incident_Cities,Crime_Domain
ORDER BY Percentage_Of_Total_People DESC