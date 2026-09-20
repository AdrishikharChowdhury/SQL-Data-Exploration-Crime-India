USE [SQL Data Exploration Crime India]
GO

DROP TABLE IF EXISTS #Police_Allocation

SELECT ci.City AS Incident_Cities,
    COUNT(ci.[Report Number]) AS Total_Reports,
    SUM(TRY_CAST(ci.[Police Deployed] AS int)) AS Total_Police_Deployed
INTO #Police_Allocation
FROM Crime_Incidents AS ci
GROUP BY ci.City;

SELECT 
    Incident_Cities,
    Total_Reports,
    Total_Police_Deployed,
    CAST((Total_Police_Deployed*1.0)/NULLIF(Total_Reports,0) AS DECIMAL(10,2)) AS Deploy_Ratio
FROM #Police_Allocation
