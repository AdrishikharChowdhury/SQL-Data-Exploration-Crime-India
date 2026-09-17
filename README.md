# 🚓 SQL Data Exploration: Crime in India

A production-grade T-SQL exploratory data analysis portfolio project built with **SQL Server 2022** on **Docker (Linux / CachyOS)**. This project follows the modular data exploration methodology popularized by **Alex the Analyst**, progressing from high-level aggregations to complex joins, CTEs, window functions, temp tables, and production views.

---

## 📌 Database Schema & Overview

* **Database Name**: `[SQL Data Exploration Crime India]`
* **Fact Table**: `Crime_Incidents` (Incident IDs, City, Domain, Description, Police Deployed, Case Closed)
* **Detail Table**: `Crime_Timeline_Victims` (Report Numbers, Dates Reported/Occurred, Victim Demographics)
* **Primary Key / Join Key**: `[Report Number]`

---

## 🎯 Portfolio Analytical Questions (Phases 1–5)

### 🔹 Phase 1: High-Level Overview & Basic Aggregations
*Objective: Understand overall dataset volume, geographic distribution, and baseline statistics.*

1. **Total Incident Volume**
   * *Question:* What is the total count of reported crime incidents across all cities nationwide?
   * *SQL Focus:* `COUNT([Report Number])`

2. **Geographic Distribution**
   * *Question:* Which cities report the highest and lowest total number of crime incidents?
   * *SQL Focus:* `GROUP BY City`, `ORDER BY Total_Incidents DESC`

3. **Crime Domain Breakdown**
   * *Question:* What are the top crime domains (e.g., cybercrime, violent crime, property crime) by total incident volume?
   * *SQL Focus:* `GROUP BY [Crime Domain]`

4. **Most Common Offenses**
   * *Question:* What are the top 5 most frequently reported specific crime descriptions across India?
   * *SQL Focus:* `SELECT TOP 5`, `GROUP BY [Crime Description]`

---

### 🔹 Phase 2: Case Closure & Police Efficiency
*Objective: Analyze resolution rates and resource allocation performance.*

5. **City Closure Rates (%)**
   * *Question:* What percentage of total reported cases have been successfully closed (`[Case Closed] = 'Yes'`) in each city?
   * *SQL Focus:* Conditional aggregation using `SUM(CASE WHEN ... THEN 1 ELSE 0 END)`, type casting (`* 100.0`), decimal formatting.

6. **Domain Resolution Comparison**
   * *Question:* Which crime domains exhibit the highest and lowest case closure percentages?
   * *SQL Focus:* Domain-level case closure ratios.

7. **Resource Allocation Metrics**
   * *Question:* What is the average and maximum number of police personnel deployed (`Police Deployed`) per crime domain?
   * *SQL Focus:* `AVG()`, `MAX()`, `GROUP BY [Crime Domain]`

8. **Deployment vs. Outcome**
   * *Question:* Do cases with high police deployment (> 5 officers) yield a significantly higher closure rate compared to low-deployment cases?
   * *SQL Focus:* Binned `CASE` statement groups, comparative aggregation.

---

### 🔹 Phase 3: Temporal & Time-Series Analysis
*Objective: Track crime trends over time and compute rolling cumulative metrics.*

9. **Incident Trends Over Time**
   * *Question:* How do reported crime incidents trend on a month-over-month or year-over-year basis based on `Date Reported`?
   * *SQL Focus:* `DATEPART()`, `DATETRUNC()`, temporal grouping.

10. **Reporting Delay / Lag Analysis**
    * *Question:* What is the average delay (in days) between the `Date of Occurrence` and the `Date Reported` across different cities?
    * *SQL Focus:* `DATEDIFF(day, [Date of Occurrence], [Date Reported])`

11. **Cumulative Rolling Totals**
    * *Question:* What is the running total (rolling cumulative sum) of crime incidents by city ordered chronologically?
    * *SQL Focus:* Window functions (`SUM() OVER (PARTITION BY City ORDER BY [Date Reported])`)

---

### 🔹 Phase 4: Victim Demographics & Segmentations (CTEs & Joins)
*Objective: Profile high-risk demographic segments across joined fact and detail tables.*

12. **Age Group Risk Profiling**
    * *Question:* What proportion of victims fall into distinct age brackets (Minors `<18`, Adults `18-60`, Seniors `>60`)?
    * *SQL Focus:* Relational `JOIN`, `CASE` age binning, percentage windowing.

13. **Gender Distribution by Crime Type**
    * *Question:* How does victim gender distribution vary across different crime domains?
    * *SQL Focus:* `JOIN`, multi-column `GROUP BY`, pivot-style aggregations.

14. **High-Risk Demographic Intersections**
    * *Question:* Which specific combination of City, Victim Age Group, and Crime Domain accounts for the highest concentration of victims?
    * *SQL Focus:* Common Table Expressions (CTEs), multi-dimensional ranking.

---

### 🔹 Phase 5: Advanced Portfolio Insights (Temp Tables & Views)
*Objective: Build modular summary structures and reusable views for Tableau/Power BI dashboards.*

15. **Unresolved Hotspot Identification**
    * *Question:* Which top 3 cities account for the majority of unresolved/open cases?
    * *SQL Focus:* Temp Tables (`#UnresolvedHotspots`), CTE filtering.

16. **Police Allocation Ratio**
    * *Question:* What is the ratio of total deployed officers to total incidents for each city?
    * *SQL Focus:* Complex mathematical ratios, analytical ranking.

17. **Production Dashboard Summary View**
    * *Question:* Can we construct a reusable SQL View outputting `City`, `Total_Incidents`, `Cases_Closed`, `Closure_Percentage`, and `Avg_Police_Deployed` for BI consumption?
    * *SQL Focus:* `CREATE VIEW dbo.vw_CityCrimeSummary AS ...`

---

## 🛠️ Tech Stack & Environment

* **Database Engine**: Microsoft SQL Server 2022
* **Containerization**: Docker & Docker Compose
* **Host OS**: CachyOS (Arch Linux)
* **Scripting**: Bash (`scripts/run.sh`)
* **Tooling**: `sqlcmd`, Zed / Nano editor

---

## 🚀 How to Run

1. **Start SQL Server Container**:
   ```bash
   docker start sqlserver
   ```
2. **Execute Automated Query Runner**:
   ```bash
   ./scripts/run.sh
   ```
3. Select script `2` (`02_Crime_Data_Exploration.sql`) to run all analytical queries against `[SQL Data Exploration Crime India]`.
