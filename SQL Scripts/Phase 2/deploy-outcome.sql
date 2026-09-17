USE [SQL Data Exploration Crime India]
GO

SELECT City,
    CASE
        WHEN CAST([Police Deployed] AS INT) > 5
            THEN 'HIGH DEPLOYMENT'
        ELSE 'LOW DEPLOYMENT'
    END AS Deployed_Category,
    COUNT(*) AS Total_Cases,
    SUM(CASE WHEN [Case Closed] = 'Yes' THEN 1 ELSE 0 END) AS Closed_Cases,
    CAST((SUM(CASE WHEN [Case Closed] = 'Yes' THEN 1.0 ELSE 0.0 END) / COUNT(*)) * 100 AS DECIMAL(5,2)) AS Closure_Percentage
FROM Crime_Incidents
GROUP BY City,
    CASE
        WHEN CAST([Police Deployed] AS INT) > 5
            THEN 'HIGH DEPLOYMENT'
        ELSE 'LOW DEPLOYMENT'
    END
ORDER BY Closure_Percentage DESC
