-- Department table
CREATE TABLE departments (
    department_id INT PRIMARY KEY,
    department_name VARCHAR(100)
);


INSERT INTO departments (department_id, department_name)
VALUES
(1, 'Sales'),
(2, 'Research & Development'),
(3, 'Human Resources');

-- JOIN
SELECT
    e.EmployeeNumber,
    e.JobRole,
    e.MonthlyIncome,
    d.department_name
FROM employees e
INNER JOIN departments d
    ON e.Department = d.department_name;
    
 
 -- Employees earning above average salary
 SELECT
    EmployeeNumber,
    JobRole,
    MonthlyIncome
FROM employees
WHERE MonthlyIncome > (
    SELECT AVG(MonthlyIncome)
    FROM employees
)
ORDER BY MonthlyIncome DESC;

-- Department-wise salary ranking
WITH department_salary AS (
    SELECT
        Department,
        EmployeeNumber,
        JobRole,
        MonthlyIncome
    FROM employees
)
SELECT
    Department,
    EmployeeNumber,
    JobRole,
    MonthlyIncome
FROM department_salary
ORDER BY Department, MonthlyIncome DESC;

-- Rank employees by salary
SELECT
    EmployeeNumber,
    Department,
    JobRole,
    MonthlyIncome,
    RANK() OVER (
        ORDER BY MonthlyIncome DESC
    ) AS salary_rank
FROM employees;

-- Rank employees within each department 

SELECT
    EmployeeNumber,
    Department,
    JobRole,
    MonthlyIncome,
    RANK() OVER (
        PARTITION BY Department
        ORDER BY MonthlyIncome DESC
    ) AS department_salary_rank
FROM employees;

-- Highest-paid employee in each department 
WITH ranked_employees AS (
    SELECT
        EmployeeNumber,
        Department,
        JobRole,
        MonthlyIncome,
        RANK() OVER (
            PARTITION BY Department
            ORDER BY MonthlyIncome DESC
        ) AS salary_rank
    FROM employees
)
SELECT
    EmployeeNumber,
    Department,
    JobRole,
    MonthlyIncome
FROM ranked_employees
WHERE salary_rank = 1;

-- Employees earning more than their department average
SELECT
    EmployeeNumber,
    Department,
    JobRole,
    MonthlyIncome
FROM employees e
WHERE MonthlyIncome > (
    SELECT AVG(e2.MonthlyIncome)
    FROM employees e2
    WHERE e2.Department = e.Department
)
ORDER BY Department, MonthlyIncome DESC;

-- Attrition rate by department
SELECT
    Department,
    COUNT(*) AS total_employees,
    SUM(
        CASE
            WHEN Attrition = 'Yes' THEN 1
            ELSE 0
        END
    ) AS employees_left,
    ROUND(
        SUM(
            CASE
                WHEN Attrition = 'Yes' THEN 1
                ELSE 0
            END
        ) * 100.0 / COUNT(*),
        2
    ) AS attrition_rate
FROM employees
GROUP BY Department
ORDER BY attrition_rate DESC;

-- Overtime employees with high attrition risk
SELECT
    OverTime,
    JobRole,
    COUNT(*) AS total_employees,
    SUM(
        CASE
            WHEN Attrition = 'Yes' THEN 1
            ELSE 0
        END
    ) AS employees_left
FROM employees
GROUP BY OverTime, JobRole
ORDER BY employees_left DESC;


-- Create a reusable VIEW
CREATE VIEW employee_salary_analysis AS
SELECT
    EmployeeNumber,
    Department,
    JobRole,
    MonthlyIncome,
    JobLevel,
    TotalWorkingYears,
    YearsAtCompany
FROM employees;

SELECT *
FROM employee_salary_analysis;