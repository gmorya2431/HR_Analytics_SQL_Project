-- =========================================================
-- HR Analytics SQL Project
-- Database schema
-- Database: hr_analysis
-- =========================================================

CREATE DATABASE IF NOT EXISTS hr_analysis;
USE hr_analysis;

-- 1. Departments
CREATE TABLE departments (
    department_id INT NOT NULL,
    department_name VARCHAR(50) DEFAULT NULL,
    location VARCHAR(50) DEFAULT NULL,
    annual_budget DECIMAL(12,2) DEFAULT NULL,
    PRIMARY KEY (department_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- 2. Jobs
CREATE TABLE jobs (
    job_id INT NOT NULL,
    job_title VARCHAR(60) DEFAULT NULL,
    department_id INT DEFAULT NULL,
    min_salary INT DEFAULT NULL,
    max_salary INT DEFAULT NULL,
    PRIMARY KEY (job_id),
    KEY fk_jobs_department (department_id),
    CONSTRAINT fk_jobs_department
        FOREIGN KEY (department_id) REFERENCES departments (department_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- 3. Employees
CREATE TABLE employees (
    employee_id INT NOT NULL,
    first_name VARCHAR(50) DEFAULT NULL,
    last_name VARCHAR(50) DEFAULT NULL,
    gender VARCHAR(10) DEFAULT NULL,
    date_of_birth DATE DEFAULT NULL,
    email VARCHAR(100) DEFAULT NULL,
    phone VARCHAR(15) DEFAULT NULL,
    hire_date DATE DEFAULT NULL,
    job_id INT DEFAULT NULL,
    department_id INT DEFAULT NULL,
    manager_id INT DEFAULT NULL,
    salary INT DEFAULT NULL,
    city VARCHAR(50) DEFAULT NULL,
    state VARCHAR(50) DEFAULT NULL,
    employment_status VARCHAR(20) DEFAULT NULL,
    termination_date DATE DEFAULT NULL,
    PRIMARY KEY (employee_id),
    KEY fk_employees_department (department_id),
    KEY fk_employees_job (job_id),
    CONSTRAINT fk_employees_department
        FOREIGN KEY (department_id) REFERENCES departments (department_id),
    CONSTRAINT fk_employees_job
        FOREIGN KEY (job_id) REFERENCES jobs (job_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- 4. Leaves
CREATE TABLE leaves (
    leave_id INT NOT NULL,
    employee_id INT DEFAULT NULL,
    leave_type VARCHAR(30) DEFAULT NULL,
    start_date DATE DEFAULT NULL,
    end_date DATE DEFAULT NULL,
    days INT DEFAULT NULL,
    status VARCHAR(20) DEFAULT NULL,
    PRIMARY KEY (leave_id),
    KEY fk_leaves_employee (employee_id),
    CONSTRAINT fk_leaves_employee
        FOREIGN KEY (employee_id) REFERENCES employees (employee_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- 5. Performance Reviews
CREATE TABLE performance_reviews (
    review_id INT NOT NULL,
    employee_id INT DEFAULT NULL,
    review_year INT DEFAULT NULL,
    rating INT DEFAULT NULL,
    reviewer_id INT DEFAULT NULL,
    PRIMARY KEY (review_id),
    KEY fk_reviews_employee (employee_id),
    CONSTRAINT fk_reviews_employee
        FOREIGN KEY (employee_id) REFERENCES employees (employee_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- 6. Salary History
CREATE TABLE salary_history (
    record_id INT NOT NULL,
    employee_id INT DEFAULT NULL,
    effective_date DATE DEFAULT NULL,
    salary INT DEFAULT NULL,
    PRIMARY KEY (record_id),
    KEY fk_salary_employee (employee_id),
    CONSTRAINT fk_salary_employee
        FOREIGN KEY (employee_id) REFERENCES employees (employee_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Note: This script creates the database schema only.
-- Import the CSV data separately after running this script.
