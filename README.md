# SQL Data Exploration: Crime in India

A production-grade T-SQL exploratory data analysis project performing end-to-end crime data exploration on Indian crime datasets using **SQL Server 2022** in Docker. Progresses from basic aggregations to advanced window functions, CTEs, temp tables, and production-ready views.

---

## Project Structure

```
SQL Data Exploration Crime India/
├── data/
│   ├── raw/
│   │   └── crime_dataset_india.xlsx
│   └── processed/
│       ├── Crime_Incidents.xlsx
│       └── Crime_Timeline_Victims.xlsx
├── SQL Scripts/
│   ├── Phase 1/
│   │   ├── total-incidents.sql
│   │   ├── geographic-distribution.sql
│   │   ├── crime-domain.sql
│   │   └── common-offenses.sql
│   ├── Phase 2/
│   │   ├── city-closure-rates.sql
│   │   ├── domain-resol.sql
│   │   ├── resource-allocate.sql
│   │   └── deploy-outcome.sql
│   ├── Phase 3/
│   │   ├── incidents-trends.sql
│   │   ├── lag-analysis.sql
│   │   └── cummulative-totals.sql
│   ├── Phase 4/
│   │   ├── age-group.sql
│   │   ├── gender-distribution.sql
│   │   └── high-risk.sql
│   └── Phase 5/
│       ├── hotspot-identify.sql
│       ├── police-allocation.sql
│       └── prod-dashboard.sql
├── scripts/
│   └── run.sh
├── LICENSE
└── README.md
```

---

## Database Schema

- **Database**: `SQL Data Exploration Crime India`
- **Fact Table**: `Crime_Incidents` (Report Number, City, Crime Domain, Crime Description, Police Deployed, Case Closed)
- **Detail Table**: `Crime_Timeline_Victims` (Report Number, Date Reported, Date of Occurrence, Victim Demographics)
- **Join Key**: `[Report Number]`

---

## Phase 1: High-Level Overview & Basic Aggregations

Establish baseline statistics and understand the overall dataset. Covers total incident counts, geographic distribution across cities, crime domain breakdowns, and identification of the most frequently reported offense types.

**Analytical Questions:**

1. What is the total count of reported crime incidents across all cities nationwide?
2. Which cities report the highest and lowest total number of crime incidents?
3. What are the top crime domains by total incident volume?
4. What are the top 5 most frequently reported specific crime descriptions across India?

**SQL Scripts:**
- `Phase 1/total-incidents.sql`
- `Phase 1/geographic-distribution.sql`
- `Phase 1/crime-domain.sql`
- `Phase 1/common-offenses.sql`

---

## Phase 2: Case Closure & Police Efficiency

Analyze resolution rates and resource allocation performance. Measures city-level case closure percentages, compares domain-level resolution rates, evaluates police deployment metrics, and compares deployment volume against case outcomes.

**Analytical Questions:**

5. What percentage of total reported cases have been successfully closed in each city?
6. Which crime domains exhibit the highest and lowest case closure percentages?
7. What is the average and maximum number of police personnel deployed per crime domain?
8. Do cases with high police deployment (> 5 officers) yield a significantly higher closure rate compared to low-deployment cases?

**SQL Scripts:**
- `Phase 2/city-closure-rates.sql`
- `Phase 2/domain-resol.sql`
- `Phase 2/resource-allocate.sql`
- `Phase 2/deploy-outcome.sql`

---

## Phase 3: Temporal & Time-Series Analysis

Track crime trends over time and compute rolling cumulative metrics. Includes month-over-month and year-over-year incident trends, reporting delay analysis between date of occurrence and date reported, and running cumulative totals by city.

**Analytical Questions:**

9. How do reported crime incidents trend on a month-over-month or year-over-year basis based on `Date Reported`?
10. What is the average delay (in days) between the `Date of Occurrence` and the `Date Reported` across different cities?
11. What is the running total (rolling cumulative sum) of crime incidents by city ordered chronologically?

**SQL Scripts:**
- `Phase 3/incidents-trends.sql`
- `Phase 3/lag-analysis.sql`
- `Phase 3/cummulative-totals.sql`

---

## Phase 4: Victim Demographics & Segmentations

Profile high-risk demographic segments across joined fact and detail tables using CTEs and complex joins. Examines age group risk distribution, gender representation across crime domains, and identifies high-risk demographic intersections.

**Analytical Questions:**

12. What proportion of victims fall into distinct age brackets (Minors `<18`, Adults `18-60`, Seniors `>60`)?
13. How does victim gender distribution vary across different crime domains?
14. Which specific combination of City, Victim Age Group, and Crime Domain accounts for the highest concentration of victims?

**SQL Scripts:**
- `Phase 4/age-group.sql`
- `Phase 4/gender-distribution.sql`
- `Phase 4/high-risk.sql`

---

## Phase 5: Advanced Portfolio Insights

Build modular summary structures and reusable views for dashboard consumption. Identifies top unresolved hotspot cities, calculates police-to-incident allocation ratios, and creates a production-ready summary view for BI tools.

**Analytical Questions:**

15. Which top 3 cities account for the majority of unresolved/open cases?
16. What is the ratio of total deployed officers to total incidents for each city?
17. Can we construct a reusable SQL View outputting `City`, `Total_Incidents`, `Cases_Closed`, `Closure_Percentage`, and `Avg_Police_Deployed` for BI consumption?

**SQL Scripts:**
- `Phase 5/hotspot-identify.sql`
- `Phase 5/police-allocation.sql`
- `Phase 5/prod-dashboard.sql`

---

## Tech Stack & Environment

- **Database Engine**: Microsoft SQL Server 2022
- **Containerization**: Docker & Docker Compose
- **Host OS**: CachyOS (Arch Linux)
- **Scripting**: Bash (`scripts/run.sh`)
- **Tooling**: `sqlcmd`, Zed / Nano editor

---

## How to Run

1. Start SQL Server container:
   ```bash
   docker start sqlserver
   ```

2. Execute automated query runner:
   ```bash
   ./scripts/run.sh
   ```

3. Select any script to run queries against the database.

---

## License

MIT
