-- Employees by Department
SELECT
    Department,
    COUNT(*) AS employee_count
FROM employees
GROUP BY Department
ORDER BY employee_count DESC;

-- Average Monthly Income by Department
SELECT
    Department,
    ROUND(AVG(MonthlyIncome), 2) AS average_monthly_income
FROM employees
GROUP BY Department
ORDER BY average_monthly_income DESC;

-- Employees by Job Role
SELECT
    JobRole,
    COUNT(*) AS employee_count
FROM employees
GROUP BY JobRole
ORDER BY employee_count DESC;

-- Attrition Analysis
SELECT
    Attrition,
    COUNT(*) AS employee_count
FROM employees
GROUP BY Attrition;

-- Attrition Rate
SELECT
    ROUND(
        SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END)
        * 100.0 / COUNT(*),
        2
    ) AS attrition_rate_percentage
FROM employees;

-- Attrition by Department
SELECT
    Department,
    COUNT(*) AS total_employees,
    SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) AS employees_left
FROM employees
GROUP BY Department
ORDER BY employees_left DESC;

-- Overtime vs Attrition
SELECT
    OverTime,
    COUNT(*) AS total_employees,
    SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) AS employees_left
FROM employees
GROUP BY OverTime;

-- Average Salary by Job Role
SELECT
    JobRole,
    ROUND(AVG(MonthlyIncome), 2) AS average_salary
FROM employees
GROUP BY JobRole
ORDER BY average_salary DESC;

-- Employees with High Income
SELECT
    EmployeeNumber,
    Age,
    Department,
    JobRole,
    MonthlyIncome
FROM employees
WHERE MonthlyIncome > 10000
ORDER BY MonthlyIncome DESC;