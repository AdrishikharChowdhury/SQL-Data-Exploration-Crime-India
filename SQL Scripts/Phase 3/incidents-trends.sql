USE [SQL Data Exploration Crime India]
GO

SELECT CONVERT(VARCHAR(10),DATETRUNC(month,TRY_CONVERT(DATETIME2, ctv.[Date Reported], 103)), 120) AS Reported_Timeline,
    COUNT(ctv.[Report Number]) AS Total_Incidents
FROM [Crime_Timeline_Victims] AS ctv
GROUP BY 
CONVERT(VARCHAR(10),DATETRUNC(month,TRY_CONVERT(DATETIME2, ctv.[Date Reported], 103)), 120)
ORDER BY Reported_Timeline
