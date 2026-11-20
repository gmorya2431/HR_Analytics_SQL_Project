# 📊 HR Analytics SQL Project | MySQL

## 📌 Project Overview

This project focuses on analyzing Human Resources data using **MySQL** to uncover meaningful insights related to employee attrition, salary distribution, performance, leave utilization, hiring trends, and workforce demographics.

The objective is to transform raw HR data into actionable business insights that can support better HR decision-making and workforce planning.

## 🎯 Project Objectives

- Analyze employee distribution across departments.
- Identify employee attrition patterns.
- Evaluate salary distribution and salary growth.
- Analyze employee performance ratings.
- Understand leave utilization across departments.
- Identify hiring trends and workforce demographics.
- Generate actionable HR business recommendations.

## 🗂️ Dataset Overview

The project contains 6 relational tables with a total of **10,477 records**.

| Table Name | Records |
|---|---:|
| departments | 10 |
| jobs | 19 |
| employees | 1,054 |
| leaves | 4,234 |
| performance_reviews | 2,853 |
| salary_history | 2,307 |
| **Total** | **10,477** |

## 🛠️ Tools & Technologies

- **Database:** MySQL
- **IDE:** MySQL Workbench
- **Language:** SQL
- **Version Control:** GitHub

## 💡 SQL Skills Demonstrated

- Data Cleaning and Validation
- Primary Keys and Foreign Keys
- INNER JOIN and LEFT JOIN
- Aggregate Functions (COUNT, SUM, AVG, MAX, MIN)
- GROUP BY and ORDER BY
- Subqueries
- Common Table Expressions (CTEs)
- Window Functions (LAG)
- CASE Statements
- Date and Time Functions
- NULL Value Handling
- Business Data Analysis

## 📈 Business Questions Answered

1. What is the total number of employees in each department?
2. Which departments have the highest and lowest average salaries?
3. What is the overall employee attrition rate?
4. Which department has the highest attrition percentage?
5. Which employees have the highest performance ratings?
6. Which departments have the highest leave utilization?
7. Which employees experienced the highest salary growth?
8. What are the yearly hiring trends?
9. Which departments have the highest average employee tenure?
10. What is the gender distribution across departments?
11. What is the age distribution of the workforce?
12. Who are the highest-paid employees?

## 🔍 Key Business Insights

### 1. Employee Attrition

- Total employees: 1,054
- Resigned employees: 96
- Overall attrition rate: **9.11%**
- Highest attrition department: **Operations (14.02%)**
- Engineering recorded the highest number of resignations (28).

**Recommendation:** Investigate employee retention challenges in Operations and Engineering.

### 2. Salary Analysis

- Executive department has the highest average salary of 588,500.
- Engineering has an average salary of 95,269.47.
- Sales has an average salary of 70,590.06.
- Customer Support has an average salary of 46,527.95.

**Recommendation:** Review salary structures and compensation differences across departments.

### 3. Employee Performance

- Operations recorded the highest average performance rating of 3.46.
- IT Support followed with 3.45.
- Finance recorded an average rating of 3.29.

**Recommendation:** Identify performance improvement opportunities and share successful practices across departments.

### 4. Leave Analysis

- Engineering recorded 5,868 total leave days.
- Customer Support recorded 4,062 total leave days.
- Customer Support had the highest leave days per employee at 25.23.

**Recommendation:** Review workload distribution and employee well-being in departments with higher leave utilization.

*Note: Leave analysis includes all leave statuses, not only approved leaves.*

### 5. Salary Growth

- Employee 1424 recorded salary growth of 50.00%.
- Employee 1775 recorded salary growth of 50.00%.
- Employee 1024 recorded a total salary increase of 53,000.

**Recommendation:** Use salary history to understand compensation progression and identify significant salary changes.

### 6. Hiring Trends

- 2016 recorded the largest year-over-year hiring increase of 606.67%.
- 2024 recorded 105 hires.
- 2025 recorded 90 hires.
- 2026 recorded 80 hires.

**Recommendation:** Monitor hiring trends to support workforce planning. The 2026 data may represent an incomplete year.

### 7. Workforce Demographics

**Gender Distribution**
- Male: 545 (51.71%)
- Female: 509 (48.29%)

**Age Distribution**
- Below 25: 1.80%
- 25–34: 23.06%
- 35–44: 36.15%
- 45–54: 31.97%
- 55+: 7.02%

**Recommendation:** Use workforce demographic insights to support long-term talent and succession planning.

## 📁 Project Structure

```text
HR_Analytics_SQL_Project/
│
├── 01_Database/
│   └── 01_schema.sql
│
├── 02_SQL_Analysis/
│   └── 02_data_analysis.sql
│
├── 03_Documentation/
│   └── business_insights.md
│
└── README.md
```

## 🚀 How to Run This Project

1. Install MySQL and MySQL Workbench.
2. Clone or download this repository.
3. Execute `01_Database/01_schema.sql` to create the database and tables.
4. Import the six dataset CSV files into their respective tables.
5. Execute `02_SQL_Analysis/02_data_analysis.sql`.
6. Review the business insights in `03_Documentation/business_insights.md`.

**Note:** The schema script creates the database structure. Dataset CSV files need to be imported separately before running the analysis queries.

## 📌 Conclusion

This project demonstrates practical SQL skills in relational database management, data validation, joins, aggregations, window functions, and business analysis.

The findings provide useful insights into employee attrition, compensation, performance, leave patterns, hiring activities, and workforce demographics.

---

**Project Name:** HR Analytics SQL Project  
**Domain:** Human Resources Analytics  
**Database:** MySQL  
**Level:** Intermediate  
**Author:** Garima Morya
