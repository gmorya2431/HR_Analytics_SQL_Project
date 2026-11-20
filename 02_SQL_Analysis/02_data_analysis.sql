show tables;
select count(*) as total_rows
from departments;
select count(*) as total_rows
from jobs;
select count(*) as total_rows
from employees;
select count(*) as total_rows
from leaves;
select count(*) as total_rows
from performance_reviews;
select count(*) as total_rows
from salary_history;
SELECT 'departments' AS table_name, COUNT(*) AS total_records
FROM departments
UNION ALL
SELECT 'jobs', COUNT(*) FROM jobs
UNION ALL
SELECT 'employees', COUNT(*) FROM employees
UNION ALL
SELECT 'leaves', COUNT(*) FROM leaves
UNION ALL
SELECT 'performance_reviews', COUNT(*) FROM performance_reviews
UNION ALL
SELECT 'salary_history', COUNT(*) FROM salary_history;

SELECT
    COUNT(*) AS total_jobs,
    SUM(department_id IS NULL) AS missing_department_id
FROM jobs;
SELECT
    COUNT(*) AS total_employees,
    SUM(phone IS NULL) AS missing_phone,
    SUM(manager_id IS NULL) AS missing_manager,
    SUM(termination_date IS NULL) AS missing_termination_date
FROM employees;
SELECT
    COUNT(*) AS total_leaves,
    SUM(employee_id IS NULL) AS missing_employee_id
FROM leaves;
SELECT
    COUNT(*) AS total_reviews,
    SUM(employee_id IS NULL) AS missing_employee_id
FROM performance_reviews;
SELECT
    COUNT(*) AS total_records,
    SUM(employee_id IS NULL) AS missing_employee_id
FROM salary_history;
SELECT employee_id, COUNT(*)
FROM employees
GROUP BY employee_id
HAVING COUNT(*) > 1;
SELECT employee_id, COUNT(*) AS duplicate_count
FROM employees
GROUP BY employee_id
HAVING COUNT(*) > 1;
SELECT j.job_id, j.department_id
FROM jobs j
LEFT JOIN departments d
    ON j.department_id = d.department_id
WHERE j.department_id IS NOT NULL
  AND d.department_id IS NULL;
SELECT e.employee_id, e.department_id
FROM employees e
LEFT JOIN departments d
    ON e.department_id = d.department_id
WHERE e.department_id IS NOT NULL
  AND d.department_id IS NULL;
  SELECT e.employee_id, e.job_id
FROM employees e
LEFT JOIN jobs j
    ON e.job_id = j.job_id
WHERE e.job_id IS NOT NULL
  AND j.job_id IS NULL;
  SELECT l.leave_id, l.employee_id
FROM leaves l
LEFT JOIN employees e
    ON l.employee_id = e.employee_id
WHERE e.employee_id IS NULL;
SELECT p.review_id, p.employee_id
FROM performance_reviews p
LEFT JOIN employees e
    ON p.employee_id = e.employee_id
WHERE e.employee_id IS NULL;
SELECT s.record_id, s.employee_id
FROM salary_history s
LEFT JOIN employees e
    ON s.employee_id = e.employee_id
WHERE e.employee_id IS NULL;
ALTER TABLE jobs
ADD CONSTRAINT fk_jobs_department
FOREIGN KEY (department_id)
REFERENCES departments(department_id);
ALTER TABLE employees
ADD CONSTRAINT fk_employees_department
FOREIGN KEY (department_id)
REFERENCES departments(department_id);
ALTER TABLE employees
ADD CONSTRAINT fk_employees_job
FOREIGN KEY (job_id)
REFERENCES jobs(job_id);
ALTER TABLE leaves
ADD CONSTRAINT fk_leaves_employee
FOREIGN KEY (employee_id)
REFERENCES employees(employee_id);
ALTER TABLE performance_reviews
ADD CONSTRAINT fk_reviews_employee
FOREIGN KEY (employee_id)
REFERENCES employees(employee_id);
ALTER TABLE salary_history
ADD CONSTRAINT fk_salary_employee
FOREIGN KEY (employee_id)
REFERENCES employees(employee_id);
SELECT
    TABLE_NAME,
    CONSTRAINT_NAME,
    REFERENCED_TABLE_NAME
FROM information_schema.KEY_COLUMN_USAGE
WHERE TABLE_SCHEMA = 'hr_analysis'
AND REFERENCED_TABLE_NAME IS NOT NULL;

SELECT
    d.department_name,
    COUNT(e.employee_id) AS total_employees,
    ROUND(AVG(e.salary), 2) AS average_salary,
    MAX(e.salary) AS highest_salary,
    MIN(e.salary) AS lowest_salary
FROM departments d
LEFT JOIN employees e
    ON d.department_id = e.department_id
GROUP BY
    d.department_id,
    d.department_name
ORDER BY total_employees DESC;

SELECT
    e.employee_id,
    CONCAT(e.first_name, ' ', e.last_name) AS employee_name,
    d.department_name,
    j.job_title,
    e.salary,
    j.min_salary,
    j.max_salary,
    CASE
        WHEN e.salary < j.min_salary
            THEN 'Below Salary Range'
        WHEN e.salary > j.max_salary
            THEN 'Above Salary Range'
        ELSE 'Within Salary Range'
    END AS salary_status
FROM employees e
JOIN jobs j
    ON e.job_id = j.job_id
JOIN departments d
    ON e.department_id = d.department_id
WHERE e.salary < j.min_salary
   OR e.salary > j.max_salary
ORDER BY e.salary DESC;

SELECT
    d.department_name,
    COUNT(e.employee_id) AS employee_count,
    MIN(e.salary) AS minimum_salary,
    ROUND(AVG(e.salary), 2) AS average_salary,
    MAX(e.salary) AS maximum_salary
FROM employees e
JOIN departments d
    ON e.department_id = d.department_id
GROUP BY d.department_name
ORDER BY average_salary DESC;

USE hr_analysis;

SELECT
    d.department_name,
    COUNT(DISTINCT e.employee_id) AS total_employees_reviewed,
    COUNT(p.review_id) AS total_reviews,
    ROUND(AVG(p.rating), 2) AS average_rating,
    MAX(p.rating) AS highest_rating,
    MIN(p.rating) AS lowest_rating
FROM employees e
JOIN departments d
    ON e.department_id = d.department_id
JOIN performance_reviews p
    ON e.employee_id = p.employee_id
GROUP BY d.department_name
ORDER BY average_rating DESC;
WITH employee_performance AS (
    SELECT
        e.employee_id,
        CONCAT(e.first_name, ' ', e.last_name) AS employee_name,
        d.department_name,
        COUNT(p.review_id) AS total_reviews,
        ROUND(AVG(p.rating), 2) AS average_rating
    FROM employees e
    JOIN performance_reviews p
        ON e.employee_id = p.employee_id
    JOIN departments d
        ON e.department_id = d.department_id
    GROUP BY
        e.employee_id,
        e.first_name,
        e.last_name,
        d.department_name
    HAVING COUNT(p.review_id) >= 2
),
ranked_employees AS (
    SELECT *,
        ROW_NUMBER() OVER (
            ORDER BY average_rating DESC,
                     total_reviews DESC,
                     employee_id
        ) AS employee_rank
    FROM employee_performance
)
SELECT *
FROM ranked_employees
WHERE employee_rank <= 10
ORDER BY employee_rank;
SELECT
    status,
    COUNT(*) AS total_requests,
    SUM(days) AS total_leave_days,
    ROUND(AVG(days), 2) AS average_leave_days
FROM leaves
GROUP BY status
ORDER BY total_requests DESC;
SELECT
    leave_type,
    COUNT(*) AS total_requests,
    SUM(days) AS total_leave_days,
    ROUND(AVG(days), 2) AS average_days
FROM leaves
GROUP BY leave_type
ORDER BY total_requests DESC;

SELECT
    d.department_name,
    COUNT(l.leave_id) AS total_leave_requests,
    COUNT(DISTINCT l.employee_id) AS employees_taking_leave,
    SUM(l.days) AS total_leave_days,
    ROUND(AVG(l.days), 2) AS average_leave_days
FROM leaves l
JOIN employees e
    ON l.employee_id = e.employee_id
JOIN departments d
    ON e.department_id = d.department_id
GROUP BY d.department_name
ORDER BY total_leave_days DESC;

SELECT
    d.department_name,
    COUNT(DISTINCT e.employee_id) AS total_employees,
    COUNT(DISTINCT l.employee_id) AS employees_taking_leave,
    COALESCE(SUM(l.days), 0) AS total_leave_days,
    ROUND(
        COALESCE(SUM(l.days), 0) /
        NULLIF(COUNT(DISTINCT e.employee_id), 0), 2
    ) AS leave_days_per_employee
FROM departments d
LEFT JOIN employees e
    ON d.department_id = e.department_id
LEFT JOIN leaves l
    ON e.employee_id = l.employee_id
GROUP BY d.department_id, d.department_name
ORDER BY leave_days_per_employee DESC;
WITH salary_comparison AS (
    SELECT
        employee_id,
        effective_date,
        salary,
        LAG(salary) OVER (
            PARTITION BY employee_id
            ORDER BY effective_date
        ) AS previous_salary
    FROM salary_history
)
SELECT
    employee_id,
    effective_date,
    previous_salary,
    salary AS current_salary,
    salary - previous_salary AS salary_change,
    ROUND(
        ((salary - previous_salary) / NULLIF(previous_salary, 0)) * 100,
        2
    ) AS salary_increase_percentage
FROM salary_comparison
WHERE previous_salary IS NOT NULL
ORDER BY salary_increase_percentage DESC;
WITH salary_growth AS (
    SELECT
        employee_id,
        effective_date,
        salary,
        ROW_NUMBER() OVER (
            PARTITION BY employee_id
            ORDER BY effective_date ASC
        ) AS first_record,
        ROW_NUMBER() OVER (
            PARTITION BY employee_id
            ORDER BY effective_date DESC
        ) AS latest_record
    FROM salary_history
),
employee_growth AS (
    SELECT
        a.employee_id,
        a.salary AS starting_salary,
        b.salary AS latest_salary
    FROM salary_growth a
    JOIN salary_growth b
        ON a.employee_id = b.employee_id
    WHERE a.first_record = 1
      AND b.latest_record = 1
)
SELECT
    employee_id,
    starting_salary,
    latest_salary,
    latest_salary - starting_salary AS total_increase,
    ROUND(
        (latest_salary - starting_salary) /
        NULLIF(starting_salary, 0) * 100,
        2
    ) AS growth_percentage
FROM employee_growth
ORDER BY growth_percentage DESC
LIMIT 10;
SELECT
    d.department_name,
    COUNT(e.employee_id) AS total_employees,
    SUM(
        CASE
            WHEN e.employment_status = 'Terminated'
            THEN 1 ELSE 0
        END
    ) AS terminated_employees,
    ROUND(
        SUM(
            CASE
                WHEN e.employment_status = 'Terminated'
                THEN 1 ELSE 0
            END
        ) * 100.0 / COUNT(e.employee_id),
        2
    ) AS attrition_rate
FROM employees e
JOIN departments d
    ON e.department_id = d.department_id
GROUP BY d.department_name
ORDER BY attrition_rate DESC;
SELECT
    employment_status,
    COUNT(*) AS total_employees
FROM employees
GROUP BY employment_status;
SELECT
    COUNT(*) AS total_employees,
    COUNT(termination_date) AS employees_with_termination_date,
    COUNT(*) - COUNT(termination_date) AS employees_without_termination_date
FROM employees;
SELECT
    d.department_name,
    COUNT(e.employee_id) AS total_employees,
    SUM(
        CASE
            WHEN e.employment_status = 'Resigned'
            THEN 1 ELSE 0
        END
    ) AS resigned_employees,
    ROUND(
        SUM(
            CASE
                WHEN e.employment_status = 'Resigned'
                THEN 1 ELSE 0
            END
        ) * 100.0 / COUNT(e.employee_id),
        2
    ) AS attrition_rate
FROM employees e
JOIN departments d
    ON e.department_id = d.department_id
GROUP BY d.department_name
ORDER BY attrition_rate DESC;
SELECT
    d.department_name,
    COUNT(e.employee_id) AS total_employees,
    ROUND(
        AVG(
            DATEDIFF(
                COALESCE(e.termination_date, CURDATE()),
                e.hire_date
            ) / 365.25
        ), 2
    ) AS average_tenure_years
FROM employees e
JOIN departments d
    ON e.department_id = d.department_id
GROUP BY d.department_name
ORDER BY average_tenure_years DESC;
SELECT
    YEAR(hire_date) AS hiring_year,
    COUNT(employee_id) AS employees_hired
FROM employees
GROUP BY YEAR(hire_date)
ORDER BY hiring_year;
SELECT
    d.department_name,
    YEAR(e.hire_date) AS hiring_year,
    COUNT(e.employee_id) AS employees_hired
FROM employees e
JOIN departments d
    ON e.department_id = d.department_id
GROUP BY
    d.department_name,
    YEAR(e.hire_date)
ORDER BY
    hiring_year,
    employees_hired DESC;
    WITH yearly_hiring AS (
    SELECT
        YEAR(hire_date) AS hiring_year,
        COUNT(employee_id) AS employees_hired
    FROM employees
    GROUP BY YEAR(hire_date)
),
hiring_growth AS (
    SELECT
        hiring_year,
        employees_hired,
        LAG(employees_hired) OVER (
            ORDER BY hiring_year
        ) AS previous_year_hires
    FROM yearly_hiring
)
SELECT
    hiring_year,
    employees_hired,
    previous_year_hires,
    employees_hired - previous_year_hires AS hiring_change,
    ROUND(
        (employees_hired - previous_year_hires) * 100.0 /
        NULLIF(previous_year_hires, 0),
        2
    ) AS growth_percentage
FROM hiring_growth
ORDER BY hiring_year;
SELECT
    gender,
    COUNT(*) AS total_employees,
    ROUND(
        COUNT(*) * 100.0 /
        (SELECT COUNT(*) FROM employees),
        2
    ) AS percentage
FROM employees
GROUP BY gender
ORDER BY total_employees DESC;
SELECT
    d.department_name,
    e.gender,
    COUNT(*) AS total_employees
FROM employees e
JOIN departments d
    ON e.department_id = d.department_id
GROUP BY
    d.department_name,
    e.gender
ORDER BY
    d.department_name,
    total_employees DESC;
    SELECT
    CASE
        WHEN TIMESTAMPDIFF(YEAR, date_of_birth, CURDATE()) < 25
            THEN 'Below 25'
        WHEN TIMESTAMPDIFF(YEAR, date_of_birth, CURDATE()) BETWEEN 25 AND 34
            THEN '25-34'
        WHEN TIMESTAMPDIFF(YEAR, date_of_birth, CURDATE()) BETWEEN 35 AND 44
            THEN '35-44'
        WHEN TIMESTAMPDIFF(YEAR, date_of_birth, CURDATE()) BETWEEN 45 AND 54
            THEN '45-54'
        ELSE '55+'
    END AS age_group,
    COUNT(*) AS total_employees,
    ROUND(
        COUNT(*) * 100.0 / (SELECT COUNT(*) FROM employees),
        2
    ) AS percentage
FROM employees
GROUP BY age_group
ORDER BY
    CASE age_group
        WHEN 'Below 25' THEN 1
        WHEN '25-34' THEN 2
        WHEN '35-44' THEN 3
        WHEN '45-54' THEN 4
        ELSE 5
    END;
    SELECT
    d.department_name,
    COUNT(e.employee_id) AS total_employees,
    ROUND(
        AVG(
            TIMESTAMPDIFF(
                YEAR,
                e.date_of_birth,
                CURDATE()
            )
        ),
        1
    ) AS average_age,
    MIN(
        TIMESTAMPDIFF(YEAR, e.date_of_birth, CURDATE())
    ) AS youngest_employee,
    MAX(
        TIMESTAMPDIFF(YEAR, e.date_of_birth, CURDATE())
    ) AS oldest_employee
FROM employees e
JOIN departments d
    ON e.department_id = d.department_id
GROUP BY d.department_name
ORDER BY average_age DESC;
SELECT
    e.employee_id,
    CONCAT(e.first_name, ' ', e.last_name) AS employee_name,
    d.department_name,
    j.job_title,
    e.salary
FROM employees e
JOIN departments d
    ON e.department_id = d.department_id
JOIN jobs j
    ON e.job_id = j.job_id
ORDER BY e.salary DESC
LIMIT 10;
SELECT 'departments' AS table_name, COUNT(*) AS total_records
FROM departments

UNION ALL

SELECT 'jobs', COUNT(*) FROM jobs

UNION ALL

SELECT 'employees', COUNT(*) FROM employees

UNION ALL

SELECT 'leaves', COUNT(*) FROM leaves

UNION ALL

SELECT 'performance_reviews', COUNT(*) FROM performance_reviews

UNION ALL

SELECT 'salary_history', COUNT(*) FROM salary_history;