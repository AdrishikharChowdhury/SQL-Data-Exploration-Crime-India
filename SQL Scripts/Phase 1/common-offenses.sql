USE [SQL Data Exploration Crime India]
GO

SELECT TOP 5 [Crime Description],COUNT([Report Number]) AS Total_Incidents
FROM Crime_Incidents
GROUP BY [Crime Description]
ORDER BY Total_Incidents DESC