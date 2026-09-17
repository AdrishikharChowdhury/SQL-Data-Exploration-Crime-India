USE [SQL Data Exploration Crime India]
GO

SELECT [Crime Domain],
    MAX(CAST([Police Deployed] AS INT)) AS Max_Police_Deployed,
    CAST(AVG(CAST([Police Deployed] AS FLOAT)) AS DECIMAL(5,2)) AS AVG_Police_Deployed
FROM Crime_Incidents
GROUP BY [Crime Domain]
ORDER BY AVG_Police_Deployed DESC