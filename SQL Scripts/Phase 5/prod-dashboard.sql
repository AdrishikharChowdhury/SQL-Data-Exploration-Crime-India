USE [SQL Data Exploration Crime India];
GO

DROP VIEW IF EXISTS dbo.vw_Prod_Dashboard;
GO

CREATE VIEW dbo.vw_Prod_Dashboard AS
WITH Summary_Table AS (
    SELECT ci.City AS Incident_Cities,
        COUNT(ci.[Report Number]) AS Total_Incidents,
        SUM(CASE WHEN ci.[Case Closed] = 'Yes' THEN 1 ELSE 0 END) AS Closed_Cases,
        CAST((SUM(CASE WHEN ci.[Case Closed] = 'Yes' THEN 1.0 ELSE 0.0 END) / NULLIF(COUNT(*),0)) * 100 AS DECIMAL(5,2)) AS Closure_Percentage,
        CAST(AVG(TRY_CAST(ci.[Police Deployed] AS int)) AS DECIMAL(10,2)) AS Average_Police_Deployed
    FROM Crime_Incidents AS ci
    JOIN Crime_Timeline_Victims AS ctv
    ON ci.[Report Number] = ctv.[Report Number]
    GROUP BY ci.City
)
SELECT *
FROM Summary_Table