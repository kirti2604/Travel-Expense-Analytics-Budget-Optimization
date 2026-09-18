/*
============================================================
Travel Expense Analytics & Budget Optimization
============================================================

Project Objective:
Analyze government travel expense data to identify
spending patterns, high-cost transactions, data quality
issues, and budget optimization opportunities.

Tools:
MySQL | SQL

Key Analysis:
- Year-wise travel expense
- Department-wise spending
- Destination-wise spending
- Expense category analysis
- High-cost transactions
- Data quality checks
- Budget optimization analysis
============================================================
*/

USE travel_expense_db;

SELECT DATABASE();

/*
============================================================
1. DATA OVERVIEW
============================================================
*/

-- Total number of travel expense records
SELECT COUNT(*) AS total_records
FROM travel_expenses;

-- Total number of columns can be checked from table structure
DESCRIBE travel_expenses;

-- View sample records
SELECT *
FROM travel_expenses
LIMIT 10;

-- Basic travel expense statistics

SELECT
    ROUND(SUM(total), 2) AS total_travel_expense,
    ROUND(AVG(total), 2) AS average_travel_expense,
    ROUND(MIN(total), 2) AS minimum_travel_expense,
    ROUND(MAX(total), 2) AS maximum_travel_expense
FROM travel_expenses
WHERE total IS NOT NULL;

/*
============================================================
2. DATA QUALITY ANALYSIS
============================================================
*/

-- Check missing total values
SELECT COUNT(*) AS missing_total
FROM travel_expenses
WHERE total IS NULL;

-- Check negative expense values
SELECT
    SUM(CASE WHEN airfare < 0 THEN 1 ELSE 0 END) AS negative_airfare,
    SUM(CASE WHEN other_transport < 0 THEN 1 ELSE 0 END) AS negative_other_transport,
    SUM(CASE WHEN lodging < 0 THEN 1 ELSE 0 END) AS negative_lodging,
    SUM(CASE WHEN meals < 0 THEN 1 ELSE 0 END) AS negative_meals,
    SUM(CASE WHEN other_expenses < 0 THEN 1 ELSE 0 END) AS negative_other_expenses,
    SUM(CASE WHEN total < 0 THEN 1 ELSE 0 END) AS negative_total
FROM travel_expenses;

-- Check exact duplicate records
SELECT
    COUNT(*) - COUNT(
        DISTINCT CONCAT_WS('|',
            ref_number,
            start_date,
            end_date,
            destination_en,
            total
        )
    ) AS duplicate_records
FROM travel_expenses;

-- Missing values in major expense columns

SELECT
    SUM(CASE WHEN airfare IS NULL THEN 1 ELSE 0 END) AS missing_airfare,
    SUM(CASE WHEN other_transport IS NULL THEN 1 ELSE 0 END) AS missing_other_transport,
    SUM(CASE WHEN lodging IS NULL THEN 1 ELSE 0 END) AS missing_lodging,
    SUM(CASE WHEN meals IS NULL THEN 1 ELSE 0 END) AS missing_meals,
    SUM(CASE WHEN other_expenses IS NULL THEN 1 ELSE 0 END) AS missing_other_expenses,
    SUM(CASE WHEN total IS NULL THEN 1 ELSE 0 END) AS missing_total
FROM travel_expenses;

/*
============================================================
3. YEAR-WISE TRAVEL EXPENSE ANALYSIS
============================================================
*/

SELECT
    YEAR(start_date) AS travel_year,
    ROUND(SUM(total), 2) AS total_expense
FROM travel_expenses
WHERE start_date IS NOT NULL
  AND total IS NOT NULL
GROUP BY YEAR(start_date)
ORDER BY travel_year;

-- Year with the highest travel expense

SELECT
    YEAR(start_date) AS travel_year,
    ROUND(SUM(total), 2) AS total_expense
FROM travel_expenses
WHERE start_date IS NOT NULL
  AND total IS NOT NULL
GROUP BY YEAR(start_date)
ORDER BY total_expense DESC
LIMIT 1;

/*
============================================================
4. DEPARTMENT-WISE TRAVEL EXPENSE ANALYSIS
============================================================
*/

-- Total travel expense by department

SELECT
    owner_org AS department,
    ROUND(SUM(total), 2) AS total_expense
FROM travel_expenses
WHERE owner_org IS NOT NULL
  AND owner_org <> ''
  AND total IS NOT NULL
GROUP BY owner_org
ORDER BY total_expense DESC;

-- Top 10 departments by travel expense

SELECT
    owner_org AS department,
    ROUND(SUM(total), 2) AS total_expense
FROM travel_expenses
WHERE owner_org IS NOT NULL
  AND owner_org <> ''
  AND total IS NOT NULL
GROUP BY owner_org
ORDER BY total_expense DESC
LIMIT 10;

/*
============================================================
5. DESTINATION-WISE TRAVEL EXPENSE ANALYSIS
============================================================
*/

-- Total travel expense by destination

SELECT
    destination_en AS destination,
    ROUND(SUM(total), 2) AS total_expense
FROM travel_expenses
WHERE destination_en IS NOT NULL
  AND destination_en <> ''
  AND total IS NOT NULL
GROUP BY destination_en
ORDER BY total_expense DESC;

-- Top 10 destinations by travel expense

SELECT
    destination_en AS destination,
    ROUND(SUM(total), 2) AS total_expense
FROM travel_expenses
WHERE destination_en IS NOT NULL
  AND destination_en <> ''
  AND total IS NOT NULL
GROUP BY destination_en
ORDER BY total_expense DESC
LIMIT 10;

/*
============================================================
6. EXPENSE CATEGORY ANALYSIS
============================================================
*/

-- Total expense by category

SELECT
    'Airfare' AS expense_category,
    ROUND(SUM(airfare), 2) AS total_expense
FROM travel_expenses

UNION ALL

SELECT
    'Other Transport' AS expense_category,
    ROUND(SUM(other_transport), 2) AS total_expense
FROM travel_expenses

UNION ALL

SELECT
    'Lodging' AS expense_category,
    ROUND(SUM(lodging), 2) AS total_expense
FROM travel_expenses

UNION ALL

SELECT
    'Meals' AS expense_category,
    ROUND(SUM(meals), 2) AS total_expense
FROM travel_expenses

UNION ALL

SELECT
    'Other Expenses' AS expense_category,
    ROUND(SUM(other_expenses), 2) AS total_expense
FROM travel_expenses

ORDER BY total_expense DESC;

-- Percentage contribution of each expense category

SELECT
    expense_category,
    total_expense,
    ROUND(
        total_expense * 100 /
        SUM(total_expense) OVER (),
        2
    ) AS percentage
FROM
(
    SELECT 'Airfare' AS expense_category, SUM(airfare) AS total_expense
    FROM travel_expenses

    UNION ALL

    SELECT 'Other Transport', SUM(other_transport)
    FROM travel_expenses

    UNION ALL

    SELECT 'Lodging', SUM(lodging)
    FROM travel_expenses

    UNION ALL

    SELECT 'Meals', SUM(meals)
    FROM travel_expenses

    UNION ALL

    SELECT 'Other Expenses', SUM(other_expenses)
    FROM travel_expenses
) AS category_data
ORDER BY total_expense DESC;

/*
============================================================
7. HIGH-COST TRANSACTION ANALYSIS
============================================================
*/

-- Top 10 most expensive travel records

SELECT
    ref_number,
    name,
    owner_org AS department,
    destination_en AS destination,
    start_date,
    end_date,
    ROUND(total, 2) AS total_expense
FROM travel_expenses
WHERE total IS NOT NULL
ORDER BY total DESC
LIMIT 10;

-- Single highest travel expense record

SELECT
    ref_number,
    name,
    owner_org AS department,
    destination_en AS destination,
    ROUND(total, 2) AS total_expense
FROM travel_expenses
WHERE total IS NOT NULL
ORDER BY total DESC
LIMIT 1;

/*
============================================================
8. TOTAL VS CALCULATED TOTAL ANALYSIS
============================================================
*/

-- Records where reported total differs from calculated total

SELECT
    ref_number,
    ROUND(total, 2) AS reported_total,
    ROUND(Calculated_Total, 2) AS calculated_total,
    ROUND(total - Calculated_Total, 2) AS difference
FROM travel_expenses
WHERE total IS NOT NULL
  AND Calculated_Total IS NOT NULL
  AND ABS(total - Calculated_Total) > 0.01
ORDER BY ABS(total - Calculated_Total) DESC;

-- Identify records with possible scale inconsistencies

SELECT
    ref_number,
    destination_en AS destination,
    ROUND(total, 2) AS reported_total,
    ROUND(Calculated_Total, 2) AS calculated_total,
    ROUND(total / Calculated_Total, 2) AS total_ratio
FROM travel_expenses
WHERE total IS NOT NULL
  AND Calculated_Total IS NOT NULL
  AND Calculated_Total > 0
  AND total / Calculated_Total > 50
ORDER BY total_ratio DESC;

/*
============================================================
9. BUDGET OPTIMIZATION ANALYSIS
============================================================
*/

-- Actual validated spend
-- Only records where reported total matches calculated total

SELECT
    ROUND(SUM(total), 2) AS actual_validated_spend
FROM travel_expenses
WHERE total IS NOT NULL
  AND Calculated_Total IS NOT NULL
  AND total > 0
  AND ABS(total - Calculated_Total) <= 0.01;
  
  -- Budget optimization scenarios

SELECT
    '5% Optimization' AS scenario,
    ROUND(SUM(total), 2) AS actual_spend,
    ROUND(SUM(total) * 0.05, 2) AS potential_savings,
    ROUND(SUM(total) * 0.95, 2) AS recommended_budget
FROM travel_expenses
WHERE total IS NOT NULL
  AND Calculated_Total IS NOT NULL
  AND total > 0
  AND ABS(total - Calculated_Total) <= 0.01

UNION ALL

SELECT
    '10% Optimization',
    ROUND(SUM(total), 2),
    ROUND(SUM(total) * 0.10, 2),
    ROUND(SUM(total) * 0.90, 2)
FROM travel_expenses
WHERE total IS NOT NULL
  AND Calculated_Total IS NOT NULL
  AND total > 0
  AND ABS(total - Calculated_Total) <= 0.01

UNION ALL

SELECT
    '15% Optimization',
    ROUND(SUM(total), 2),
    ROUND(SUM(total) * 0.15, 2),
    ROUND(SUM(total) * 0.85, 2)
FROM travel_expenses
WHERE total IS NOT NULL
  AND Calculated_Total IS NOT NULL
  AND total > 0
  AND ABS(total - Calculated_Total) <= 0.01;
  
  /*
/*
============================================================
10. CATEGORY-WISE BUDGET OPTIMIZATION
============================================================
*/

SELECT
    'Airfare' AS expense_category,
    ROUND(SUM(airfare), 2) AS actual_spend,
    ROUND(SUM(airfare) * 0.10, 2) AS potential_savings,
    ROUND(SUM(airfare) * 0.90, 2) AS recommended_budget
FROM travel_expenses
WHERE total IS NOT NULL
  AND Calculated_Total IS NOT NULL
  AND total > 0
  AND ABS(total - Calculated_Total) <= 0.01

UNION ALL

SELECT
    'Other Transport',
    ROUND(SUM(other_transport), 2),
    ROUND(SUM(other_transport) * 0.10, 2),
    ROUND(SUM(other_transport) * 0.90, 2)
FROM travel_expenses
WHERE total IS NOT NULL
  AND Calculated_Total IS NOT NULL
  AND total > 0
  AND ABS(total - Calculated_Total) <= 0.01

UNION ALL

SELECT
    'Lodging',
    ROUND(SUM(lodging), 2),
    ROUND(SUM(lodging) * 0.10, 2),
    ROUND(SUM(lodging) * 0.90, 2)
FROM travel_expenses
WHERE total IS NOT NULL
  AND Calculated_Total IS NOT NULL
  AND total > 0
  AND ABS(total - Calculated_Total) <= 0.01

UNION ALL

SELECT
    'Meals',
    ROUND(SUM(meals), 2),
    ROUND(SUM(meals) * 0.10, 2),
    ROUND(SUM(meals) * 0.90, 2)
FROM travel_expenses
WHERE total IS NOT NULL
  AND Calculated_Total IS NOT NULL
  AND total > 0
  AND ABS(total - Calculated_Total) <= 0.01

UNION ALL

SELECT
    'Other Expenses',
    ROUND(SUM(other_expenses), 2),
    ROUND(SUM(other_expenses) * 0.10, 2),
    ROUND(SUM(other_expenses) * 0.90, 2)
FROM travel_expenses
WHERE total IS NOT NULL
  AND Calculated_Total IS NOT NULL
  AND total > 0
  AND ABS(total - Calculated_Total) <= 0.01

ORDER BY actual_spend DESC;
/*
============================================================
11. DEPARTMENT-WISE BUDGET OPTIMIZATION
============================================================
*/

SELECT
    owner_org AS department,
    ROUND(SUM(total), 2) AS actual_spend,
    ROUND(SUM(total) * 0.10, 2) AS potential_savings,
    ROUND(SUM(total) * 0.90, 2) AS recommended_budget
FROM travel_expenses
WHERE owner_org IS NOT NULL
  AND owner_org <> ''
  AND total IS NOT NULL
  AND Calculated_Total IS NOT NULL
  AND total > 0
  AND ABS(total - Calculated_Total) <= 0.01
GROUP BY owner_org
ORDER BY actual_spend DESC
LIMIT 10;

/*
============================================================
12. PROJECT SUMMARY
============================================================

Key SQL analysis performed:

1. Data overview and basic statistics
2. Data quality checks
3. Year-wise travel expense analysis
4. Department-wise expense analysis
5. Destination-wise expense analysis
6. Expense category analysis
7. High-cost transaction analysis
8. Total vs calculated total validation
9. Scale inconsistency detection
10. Budget optimization scenarios
11. Category-wise budget optimization
12. Department-wise budget optimization

Budget optimization scenarios:
- 5% optimization
- 10% optimization
- 15% optimization

The analysis helps identify spending patterns, high-cost
transactions, data quality issues, and potential opportunities
for travel expense optimization and budget planning.
============================================================
*/