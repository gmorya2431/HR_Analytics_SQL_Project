# HR Analytics – Business Insights

## 1. Project Overview

This document summarizes the key findings from the HR Analytics project conducted using MySQL.

The analysis covers employee attrition, department-wise salaries, performance reviews, leave patterns, salary growth, hiring trends, and workforce demographics.

**Dataset Summary:**
- Total Employees: 1,054
- Total Departments: 10
- Total Tables: 6
- Total Records: 10,477

## 2. Employee Attrition Analysis

- Total resigned employees: 96
- Overall attrition rate: **9.11%**
- Highest department attrition rate: **Operations (14.02%)**
- Engineering recorded the highest number of resignations, with 28 employees.

**Business Insight:**

Operations has the highest attrition rate, indicating that HR should investigate employee retention, workload, and job satisfaction in this department. Engineering also deserves attention because it has the largest number of resignations.

## 3. Salary Analysis

- Executive department has the highest average salary at 588,500.
- Engineering has an average salary of 95,269.47.
- Sales has an average salary of 70,590.06.
- Customer Support has an average salary of 46,527.95.

**Business Insight:**

Salary levels vary considerably across departments. HR can use salary benchmarking to review compensation structures and identify potential salary inconsistencies.

## 4. Employee Performance Analysis

Department-wise average performance ratings:

| Department | Average Rating |
|---|---:|
| Operations | 3.46 |
| IT Support | 3.45 |
| Customer Support | 3.39 |
| Marketing | 3.39 |
| Human Resources | 3.36 |
| Sales | 3.34 |
| Legal | 3.31 |
| Engineering | 3.30 |
| Finance | 3.29 |
| Executive | 3.00 |

**Business Insight:**

Operations recorded the highest average performance rating of 3.46, while Executive recorded 3.00. HR can use these findings to identify departments that may benefit from additional training and performance support.

## 5. Leave Analysis

- Customer Support recorded 4,062 total leave days.
- Engineering recorded 5,868 total leave days.
- Customer Support had the highest leave days per employee at 25.23.
- Legal had the lowest leave days per employee at 12.14.

**Business Insight:**

Customer Support has the highest average leave days per employee. HR may investigate workload, staffing levels, and employee well-being.

*Note: Leave analysis includes all leave statuses, not only approved leaves.*

## 6. Salary Growth Analysis

The salary history analysis used the SQL `LAG()` window function to compare salary changes over time.

Key findings:
- Employee 1424 recorded salary growth of 50.00%.
- Employee 1775 recorded salary growth of 50.00%.
- Employee 1024 recorded a total salary increase of 53,000.

**Business Insight:**

Salary history analysis helps HR understand employee compensation progression and identify significant salary changes.

## 7. Hiring Trend Analysis

- 2016 recorded the largest year-over-year hiring increase: 91 additional hires (606.67%).
- 2024 recorded 105 hires.
- 2025 recorded 90 hires.
- 2026 recorded 80 hires.

**Business Insight:**

Hiring increased significantly in 2016. The decline in hiring during 2025 and 2026 may be worth investigating. The 2026 data may represent an incomplete year.

## 8. Workforce Demographics

### Gender Distribution

- Male employees: 545 (51.71%)
- Female employees: 509 (48.29%)

### Age Distribution

- Below 25: 1.80%
- 25–34: 23.06%
- 35–44: 36.15%
- 45–54: 31.97%
- 55+: 7.02%

**Business Insight:**

The workforce has a relatively balanced gender distribution. Employees aged 35–54 represent 68.12% of the workforce.

## 9. Overall Recommendations

1. Investigate the high attrition rate in Operations.
2. Review employee retention strategies in Engineering.
3. Evaluate salary structures across departments.
4. Identify training opportunities using performance review results.
5. Monitor leave patterns and employee workload.
6. Track hiring trends to support workforce planning.
7. Review compensation progression using salary history data.

## 10. Conclusion

This project demonstrates how SQL can be used to transform HR data into meaningful business insights.

By analyzing employee attrition, salary patterns, performance, leave utilization, hiring trends, and workforce demographics, organizations can make more informed HR decisions.

**Tools Used:** MySQL and MySQL Workbench  
**Project Domain:** Human Resources Analytics
