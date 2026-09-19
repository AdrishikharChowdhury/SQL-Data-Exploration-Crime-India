USE [SQL Data Exploration Crime India]
GO

WITH Cumulative_Analysis AS (
    SELECT
        ci.City AS Occurrence_City,
        DATETRUNC(
        month,
        COALESCE(
            TRY_CAST(ctv.[Date Reported] AS DATETIME2),
            TRY_CONVERT(DATETIME2,ctv.[Date Reported],103),
            TRY_CONVERT(DATETIME2,ctv.[Date Reported],105)
            )) AS Reported_Dates,
        COUNT(ci.[Report Number]) AS Monthly_Reports
    FROM Crime_Incidents AS ci
    JOIN Crime_Timeline_Victims AS ctv
        ON ci.[Report Number]=ctv.[Report Number]
    WHERE COALESCE(
        TRY_CAST(ctv.[Date Reported] AS DATETIME2),
        TRY_CONVERT(DATETIME2,ctv.[Date Reported],103),
        TRY_CONVERT(DATETIME2,ctv.[Date Reported],105)
        ) IS NOT NULL
    GROUP BY ci.City,
    DATETRUNC(
    month,
    COALESCE(
        TRY_CAST(ctv.[Date Reported] AS DATETIME2),
        TRY_CONVERT(DATETIME2,ctv.[Date Reported],103),
        TRY_CONVERT(DATETIME2,ctv.[Date Reported],105)
    ))
)
SELECT Occurrence_City,
    CONVERT(VARCHAR(10), Reported_Dates,120) AS Reported_Month,
    Monthly_Reports,
    SUM(Monthly_Reports) OVER (
    PARTITION BY Occurrence_City 
    ORDER BY Reported_Dates
    ) AS Cumulative_Incidents
FROM Cumulative_Analysis
ORDER BY
    Occurrence_City,
    Reported_Dates