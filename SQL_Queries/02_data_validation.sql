-- Total employees
SELECT COUNT(*) AS total_employees
FROM employees;

-- Unique employees check
SELECT COUNT(DISTINCT EmployeeNumber) AS unique_employees
FROM employees;

-- Departments check
SELECT DISTINCT Department
FROM employees;

-- Attrition check
SELECT
    Attrition,
    COUNT(*) AS employee_count
FROM employees
GROUP BY Attrition;

-- Overtime check
SELECT
    OverTime,
    COUNT(*) AS employee_count
FROM employees
GROUP BY OverTime;


-- Duplicate EmployeeNumber check
SELECT
    EmployeeNumber,
    COUNT(*) AS duplicate_count
FROM employees
GROUP BY EmployeeNumber
HAVING COUNT(*) > 1;