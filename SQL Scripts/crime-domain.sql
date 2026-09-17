USE [SQL Data Exploration Crime India]
GO

SELECT [Crime Domain],COUNT([Report Number]) AS Total_Incidents
FROM Crime_Incidents
GROUP BY [Crime Domain]
ORDER BY COUNT([Report Number]) DESC