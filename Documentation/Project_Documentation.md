# Project Documentation

## Travel Expense Analytics & Budget Optimization

### 1. Project Overview

This project analyzes government travel expense data to identify
spending patterns, high-cost transactions, data quality issues, and
budget optimization opportunities.

The project combines Python, SQL, Excel/Spreadsheet analysis, and Power
BI to perform data cleaning, exploratory analysis, validation,
visualization, and scenario-based budget optimization.

------------------------------------------------------------------------

## 2. Problem Statement

Government travel expense data can contain large numbers of transactions
across departments, destinations, dates, and expense categories.
Analyzing this data helps identify spending patterns, unusual
transactions, data quality issues, and opportunities for better budget
planning.

------------------------------------------------------------------------

## 3. Objectives

-   Analyze travel expense trends over time.
-   Identify major expense categories.
-   Analyze spending by department and destination.
-   Detect missing values, negative values, outliers, and anomalies.
-   Validate reported totals against calculated expense totals.
-   Identify high-cost travel transactions.
-   Develop scenario-based budget optimization recommendations.
-   Present insights through interactive Power BI dashboards.

------------------------------------------------------------------------

## 4. Dataset Description

The dataset contains approximately 152,900 government travel expense
records.

Key fields include:

-   Reference number
-   Department / organization
-   Traveler name
-   Travel purpose
-   Start date and end date
-   Destination
-   Airfare
-   Other transport
-   Lodging
-   Meals
-   Other expenses
-   Total expense

------------------------------------------------------------------------

## 5. Data Cleaning Process

Python and Pandas were used to prepare the data for analysis.

The cleaning process included:

-   Removing unnecessary whitespace from text fields.
-   Converting start and end dates into datetime format.
-   Converting expense fields into numeric format.
-   Creating `Travel_Days`.
-   Creating `Calculated_Total` from expense components.
-   Calculating `Total_Difference` between reported and calculated
    totals.
-   Creating `Data_Quality_Status` to identify records requiring review.

The original raw dataset was preserved separately from the cleaned
analysis data.

------------------------------------------------------------------------

## 6. Data Quality Analysis

The project checked for:

-   Missing values
-   Negative expense values
-   Duplicate records
-   Reported total versus calculated total mismatches
-   Potential scale inconsistencies
-   Statistical outliers

The analysis identified records requiring review rather than
automatically deleting or changing potentially unusual transactions.

Three records were identified for possible scale inconsistency based on
a large ratio between reported total and calculated total.

------------------------------------------------------------------------

## 7. Exploratory Data Analysis

The following analyses were performed using Python:

### 7.1 Expense Distribution

The distribution of total travel expenses was analyzed to understand
typical spending levels and identify extreme values.

### 7.2 Year-wise Expense Analysis

Travel expenses were grouped by travel year to identify changes in
spending over time.

### 7.3 Department Analysis

Department-level spending was analyzed to identify organizations with
higher total travel expenses.

### 7.4 Destination Analysis

Destination-level spending was analyzed to identify destinations
associated with higher travel expenses.

### 7.5 Expense Category Analysis

The major expense categories were compared.

Airfare was the largest category, contributing approximately 59.62% of
category spending.

------------------------------------------------------------------------

## 8. Outlier & Anomaly Analysis

### 8.1 IQR-based Outlier Detection

The Interquartile Range (IQR) method was used to identify statistical
outliers in total travel expenses.

The analysis identified 13,491 records as statistical outliers using the
IQR rule.

### 8.2 Negative Expense Analysis

Negative values were checked across the major expense columns and total
expense field.

### 8.3 Scale Inconsistency Analysis

Reported totals were compared with calculated totals to identify
unusually large differences that may require validation.

------------------------------------------------------------------------

## 9. Correlation Analysis

### 9.1 Travel Days vs Total Expense

The relationship between travel duration and total expense was examined
using correlation analysis.

For valid travel durations, the correlation was approximately 0.07,
indicating a weak linear relationship.

### 9.2 Expense Correlation

A correlation heatmap was used to examine relationships among airfare,
other transport, lodging, meals, other expenses, and total expense.

------------------------------------------------------------------------

## 10. SQL Analysis

MySQL was used to perform structured analysis on the travel expense
data.

SQL analysis included:

-   Data overview and basic statistics
-   Data quality checks
-   Year-wise travel expense analysis
-   Department-wise spending
-   Destination-wise spending
-   Expense category analysis
-   High-cost transaction analysis
-   Total versus calculated total validation
-   Scale inconsistency detection
-   Budget optimization scenarios
-   Category-wise budget optimization
-   Department-wise budget optimization

------------------------------------------------------------------------

## 11. Budget Optimization Methodology

Budget optimization was performed using validated expense records.

A record was considered for the optimization analysis when:

-   Total expense was available.
-   Calculated total was available.
-   Total expense was greater than zero.
-   Reported total and calculated total differed by no more than 0.01.

The validated dataset contained 148,935 records with an actual validated
spend of approximately 320.64M.

Three optimization scenarios were evaluated:

  Scenario     Potential Savings   Recommended Budget
  ---------- ------------------- --------------------
  5%                      16.03M              304.60M
  10%                     32.06M              288.57M
  15%                     48.10M              272.54M

These values represent analytical scenarios for budget planning and are
not actual realized savings.

------------------------------------------------------------------------

## 12. Category-wise Budget Optimization

A 10% optimization scenario was applied to the major expense categories:

-   Airfare
-   Other Transport
-   Lodging
-   Meals
-   Other Expenses

For each category, actual spend, potential savings, and recommended
budget were calculated.

------------------------------------------------------------------------

## 13. Department-wise Budget Optimization

The top departments by validated travel spending were analyzed using a
10% optimization scenario.

For each department, the analysis calculated:

-   Actual spend
-   Potential savings
-   Recommended budget

This provides a department-level view of potential budget optimization
opportunities.

------------------------------------------------------------------------

## 14. Power BI Dashboard

Two Power BI dashboards were developed.

### Executive Dashboard

The Executive Dashboard includes:

-   Total travel expense
-   Total travel records
-   Average travel expense
-   Average travel days
-   Year-wise expense trend
-   Expense category analysis
-   Top departments
-   Top destinations
-   Interactive slicers
-   Key insights and data quality indicators

### Budget Optimization Dashboard

The Budget Optimization Dashboard includes:

-   Actual validated spend
-   Recommended budget
-   Potential savings
-   Optimization target
-   5%, 10%, and 15% scenario selection
-   Category-wise potential savings
-   Department-wise potential savings
-   Selected scenario budget breakdown

------------------------------------------------------------------------

## 15. Key Insights

-   Airfare is the largest expense category at approximately 59.62%.
-   Travel expenses vary significantly across years.
-   Certain departments contribute substantially to overall travel
    spending.
-   Certain destinations are associated with higher travel expenses.
-   The dataset contains missing values, negative values, statistical
    outliers, and records requiring validation.
-   Travel duration has a weak linear relationship with total expense.
-   Scenario-based optimization provides different potential savings
    estimates for budget planning.

------------------------------------------------------------------------

## 16. Project Structure

``` text
Travel-Expense-Analytics-Budget-Optimization/
│
├── Dashboard/
│   ├── Executive Dashboard.png
│   └── Budget Optimization.png
│
├── Documentation/
│   └── Project_Documentation.md
│
├── Excel/
│   └── Travel_Expense_Analysis_GitHub.xlsx
│
├── PowerBI/
│
├── Python/
│   └── Travel_Expense_Analytics_Budget_Optimization.ipynb
│
├── SQL/
│   └── Travel_Expense_Analytics.sql
│
└── README.md
```

------------------------------------------------------------------------

## 17. Tools & Technologies

-   Python
-   Pandas
-   NumPy
-   Matplotlib
-   Seaborn
-   MySQL
-   SQL
-   Excel / WPS Spreadsheet
-   Power BI

------------------------------------------------------------------------

## 18. Conclusion

The project demonstrates an end-to-end data analytics workflow, from raw
data preparation and quality validation to exploratory analysis, SQL
analysis, visualization, and budget optimization.

The combination of Python, SQL, Excel, and Power BI was used to
transform travel expense data into structured insights and
scenario-based budget planning information.
