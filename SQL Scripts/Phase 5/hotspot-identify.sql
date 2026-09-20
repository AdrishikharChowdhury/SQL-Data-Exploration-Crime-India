USE [SQL Data Exploration Crime India]
GO

DROP TABLE IF EXISTS #Hotspot_Identification

SELECT ci.City AS Incident_Cities,
    ci.[Crime Domain] AS Crime_Domain,
    COUNT(ci.[Report Number]) AS Unresolved_Reports,
    CAST(AVG(COUNT(ci.[Report Number])*1.0) OVER (PARTITION BY ci.City) AS DECIMAL(10,2)) AS Avg_Unresolved_Reports
INTO #Hotspot_Identification
FROM Crime_Incidents AS ci
JOIN Crime_Timeline_Victims AS ctv
ON ci.[Report Number]=ctv.[Report Number]
WHERE ci.[Date Case Closed] IS NULL
GROUP BY ci.City, ci.[Crime Domain];

SELECT 
    Incident_Cities,
    Crime_Domain,
    Unresolved_Reports,
    Avg_Unresolved_Reports,
    CASE 
        WHEN Unresolved_Reports>=(Avg_Unresolved_Reports*1.25) THEN 'Critical Hotspot'
        WHEN Unresolved_Reports > Avg_Unresolved_Reports THEN 'Elevated Hotspot'
        ELSE 'Moderate/Low Hotspot'
    END AS Hotspot_Level
FROM #Hotspot_Identification
ORDER BY Incident_Cities ASC,
Avg_Unresolved_Reports DESC
