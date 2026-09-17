USE [SQL Data Exploration Crime India]
GO

SELECT City,COUNT([Report Number]) AS Total_Incidents
FROM Crime_Incidents
GROUP BY City
ORDER BY COUNT([Report Number]) DESC