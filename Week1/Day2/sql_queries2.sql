-- ORDER BY QUERIES


-- 31. Select all employees ordered by salary ascending.
SELECT * FROM Employee
ORDER BY salary ASC;

-- 32. Select all employees ordered by age descending.
SELECT * FROM Employee
ORDER BY age DESC;

-- 33. Select employees ordered by hire date ascending.
SELECT * FROM Employee
ORDER BY hire_date ASC;

-- 34. Select employees ordered by department and salary.
SELECT * FROM Employee
ORDER BY department_id, salary;

-- 35. Select departments ordered by total salary.
SELECT department_id,
SUM(salary) AS total_salary
FROM Employee
GROUP BY department_id
ORDER BY total_salary DESC;


-- JOIN QUERIES


-- 36. Select employee names along with their department names.
SELECT e.name AS employee_name,
d.name AS department_name
FROM Employee e
JOIN Department d
ON e.department_id = d.department_id;

-- 37. Select project names along with the department names they belong to.
SELECT p.name AS project_name,
d.name AS department_name
FROM Project p
JOIN Department d
ON p.department_id = d.department_id;

-- 38. Select employee names and their corresponding project names.
SELECT e.name AS employee_name,
p.name AS project_name
FROM Employee e
JOIN Project p
ON e.department_id = p.department_id;

-- 39. Select employees and their departments, including those without a department.
SELECT e.name AS employee_name,
d.name AS department_name
FROM Employee e
LEFT JOIN Department d
ON e.department_id = d.department_id;

-- 40. Select all departments and their employees, including departments without employees.
SELECT d.name AS department_name,
e.name AS employee_name
FROM Department d
LEFT JOIN Employee e
ON d.department_id = e.department_id;

-- 41. Select employees who are not assigned to any project.
SELECT e.name
FROM Employee e
LEFT JOIN Project p
ON e.department_id = p.department_id
WHERE p.project_id IS NULL;

-- 42. Select projects and the number of projects per department.
SELECT d.name AS department_name,
COUNT(p.project_id) AS total_projects
FROM Department d
LEFT JOIN Project p
ON d.department_id = p.department_id
GROUP BY d.name;

-- 43. Select the departments that have no employees.
SELECT d.name
FROM Department d
LEFT JOIN Employee e
ON d.department_id = e.department_id
WHERE e.emp_id IS NULL;

-- 44. Select employee names who share the same department with 'John Doe'.
SELECT name
FROM Employee
WHERE department_id = (
    SELECT department_id
    FROM Employee
    WHERE name = 'John Doe'
);

-- 45. Select the department name with the highest average salary.
SELECT d.name,
AVG(e.salary) AS avg_salary
FROM Employee e
JOIN Department d
ON e.department_id = d.department_id
GROUP BY d.name
ORDER BY avg_salary DESC
LIMIT 1;



-- NESTED AND CORRELATED QUERIES


-- 46. Select the employee with the highest salary.
SELECT *
FROM Employee
WHERE salary = (
    SELECT MAX(salary)
    FROM Employee
);

-- 47. Select employees whose salary is above the average salary.
SELECT *
FROM Employee
WHERE salary > (
    SELECT AVG(salary)
    FROM Employee
);

-- 48. Select the second highest salary from the Employee table.
SELECT MAX(salary) AS second_highest_salary
FROM Employee
WHERE salary < (
    SELECT MAX(salary)
    FROM Employee
);

-- 49. Select the department with the most employees.
SELECT department_id,
COUNT(*) AS employee_count
FROM Employee
GROUP BY department_id
ORDER BY employee_count DESC
LIMIT 1;

-- 50. Select employees who earn more than the average salary of their department.
SELECT e.name,
e.salary,
e.department_id
FROM Employee e
WHERE salary > (
    SELECT AVG(salary)
    FROM Employee
    WHERE department_id = e.department_id
);



-- COMBINED MODERATE DIFFICULTY QUERIES


-- 51. Select employees older than all employees in HR department.
SELECT *
FROM Employee
WHERE age > ALL (
    SELECT age
    FROM Employee e
    JOIN Department d
    ON e.department_id = d.department_id
    WHERE d.name = 'HR'
);

-- 52. Select departments where average salary is greater than 55000.
SELECT d.name,
AVG(e.salary) AS avg_salary
FROM Employee e
JOIN Department d
ON e.department_id = d.department_id
GROUP BY d.name
HAVING AVG(e.salary) > 55000;

-- 53. Select employees hired on the same date as Jane Smith.
SELECT *
FROM Employee
WHERE hire_date = (
    SELECT hire_date
    FROM Employee
    WHERE name = 'Jane Smith'
);

-- 54. Select total salary of employees hired in the year 2020.
SELECT SUM(salary) AS total_salary
FROM Employee
WHERE YEAR(hire_date) = 2020;

-- 55. Select average salary of employees in each department ordered descending.
SELECT d.name,
AVG(e.salary) AS avg_salary
FROM Employee e
JOIN Department d
ON e.department_id = d.department_id
GROUP BY d.name
ORDER BY avg_salary DESC;

-- 56. Select departments with more than 1 employee and average salary > 55000.
SELECT d.name,
COUNT(e.emp_id) AS total_employees,
AVG(e.salary) AS avg_salary
FROM Employee e
JOIN Department d
ON e.department_id = d.department_id
GROUP BY d.name
HAVING COUNT(e.emp_id) > 1
AND AVG(e.salary) > 55000;

-- 57. Select employees hired in last 2 years ordered by hire date.
SELECT *
FROM Employee
WHERE hire_date >= DATE_SUB(CURDATE(), INTERVAL 2 YEAR)
ORDER BY hire_date;

-- 58. Select total employees and average salary for departments with >2 employees.
SELECT department_id,
COUNT(*) AS total_employees,
AVG(salary) AS avg_salary
FROM Employee
GROUP BY department_id
HAVING COUNT(*) > 2;

-- 59. Select name and salary of employees whose salary is above department average.
SELECT e.name,
e.salary
FROM Employee e
WHERE salary > (
    SELECT AVG(salary)
    FROM Employee
    WHERE department_id = e.department_id
);

-- 60. Select employees hired on same date as oldest employee in company.
SELECT name
FROM Employee
WHERE hire_date = (
    SELECT hire_date
    FROM Employee
    ORDER BY age DESC
    LIMIT 1
);

-- 61. Select department name and total projects ordered by number of projects.
SELECT d.name,
COUNT(p.project_id) AS total_projects
FROM Department d
LEFT JOIN Project p
ON d.department_id = p.department_id
GROUP BY d.name
ORDER BY total_projects DESC;

-- 62. Select employee name with highest salary in each department.
SELECT e.name,
e.department_id,
e.salary
FROM Employee e
WHERE salary = (
    SELECT MAX(salary)
    FROM Employee
    WHERE department_id = e.department_id
);

-- 63. Select names and salaries of employees older than department average age.
SELECT e.name,
e.salary
FROM Employee e
WHERE age > (
    SELECT AVG(age)
    FROM Employee
    WHERE department_id = e.department_id
);

-- EXTRA QUERIES TO COMPLETE 65

-- 64. Select departments having more than one project.
SELECT d.name,
COUNT(p.project_id) AS total_projects
FROM Department d
JOIN Project p
ON d.department_id = p.department_id
GROUP BY d.name
HAVING COUNT(p.project_id) > 1;

-- 65. Select employees whose salary is between 50000 and 70000.
SELECT *
FROM Employee
WHERE salary BETWEEN 50000 AND 70000;
