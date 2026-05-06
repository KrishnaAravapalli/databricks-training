create database week1;
use week1;

-- Create Department table
CREATE TABLE Department (
    department_id INT PRIMARY KEY,
    name VARCHAR(50) NOT NULL
);

-- Create Employee table
CREATE TABLE Employee (
    emp_id INT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    age INT,
    salary DECIMAL(10, 2),
    department_id INT,
    hire_date DATE,
    FOREIGN KEY (department_id) REFERENCES Department(department_id)
);

-- Create Project table
CREATE TABLE Project (
    project_id INT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    department_id INT,
    FOREIGN KEY (department_id) REFERENCES Department(department_id)
);

-- Insert data into Department table
INSERT INTO Department (department_id, name) VALUES
(1, 'IT'),
(2, 'HR'),
(3, 'Finance'),
(4, 'Marketing');

-- Insert data into Employee table
INSERT INTO Employee (emp_id, name, age, salary, department_id, hire_date) VALUES
(1, 'John Doe', 28, 50000.00, 1, '2020-01-15'),
(2, 'Jane Smith', 34, 60000.00, 2, '2019-07-23'),
(3, 'Bob Brown', 45, 80000.00, 1, '2018-02-12'),
(4, 'Alice Blue', 25, 45000.00, 3, '2021-03-22'),
(5, 'Charlie P.', 29, 50000.00, 2, '2019-12-01'),
(6, 'David Green', 38, 70000.00, 4, '2022-05-18'),
(7, 'Eve Black', 40, 55000.00, 3, '2021-08-30');

-- Insert data into Project table
INSERT INTO Project (project_id, name, department_id) VALUES
(1, 'Project Alpha', 1),
(2, 'Project Beta', 2),
(3, 'Project Gamma', 1),
(4, 'Project Delta', 3),
(5, 'Project Epsilon', 4),
(6, 'Project Zeta', 4),
(7, 'Project Eta', 3);


-- Insert additional data into Department table (if needed)
-- No additional departments needed for this data set

-- Insert additional data into Employee table to test edge cases for joins and nested queries
INSERT INTO Employee (emp_id, name, age, salary, department_id, hire_date) VALUES
(8, 'Frank White', 32, 48000.00, NULL, '2021-07-10'),  -- Employee without a department
(9, 'Grace Kelly', 27, 65000.00, 1, '2018-11-13'),
(10, 'Hannah Lee', 30, 53000.00, 4, '2020-02-25');

-- Insert additional data into Project table to test edge cases for joins
INSERT INTO Project (project_id, name, department_id) VALUES
(8, 'Project Theta', 1),
(9, 'Project Iota', NULL);  -- Project without a department


-- BASIC QUERIES


-- 1. Select all columns from the Employee table.
SELECT * FROM Employee;

-- 2. Select only the name and salary columns from the Employee table.
SELECT name, salary FROM Employee;

-- 3. Select employees who are older than 30.
SELECT * FROM Employee
WHERE age > 30;

-- 4. Select the names of all departments.
SELECT name FROM Department;

-- 5. Select employees who work in the IT department.
SELECT e.*
FROM Employee e
JOIN Department d
ON e.department_id = d.department_id
WHERE d.name = 'IT';



-- STRING MATCHING QUERIES


-- 6. Select employees whose names start with 'J'.
SELECT * FROM Employee
WHERE name LIKE 'J%';

-- 7. Select employees whose names end with 't'.
SELECT * FROM Employee
WHERE name LIKE '%t';

-- 8. Select employees whose name contains 'o'.
SELECT * FROM Employee
WHERE name LIKE '%o%';

-- 9. Select employees whose names are exactly 4 characters long.
SELECT * FROM Employee
WHERE LENGTH(name) = 4;

-- 10. Select employees whose names have 'a' as the second character.
SELECT * FROM Employee
WHERE name LIKE '_a%';


-- DATE QUERIES


-- 11. Select employees hired in the year 2020.
SELECT * FROM Employee
WHERE YEAR(hire_date) = 2020;

-- 12. Select employees hired in January of any year.
SELECT * FROM Employee
WHERE MONTH(hire_date) = 1;

-- 13. Select employees hired before 2019.
SELECT * FROM Employee
WHERE hire_date < '2019-01-01';

-- 14. Select employees hired on or after March 1, 2021.
SELECT * FROM Employee
WHERE hire_date >= '2021-03-01';

-- 15. Select employees hired in the last 2 years.
SELECT * FROM Employee
WHERE hire_date >= DATE_SUB(CURDATE(), INTERVAL 2 YEAR);



-- AGGREGATE QUERIES


-- 16. Select the total salary of all employees.
SELECT SUM(salary) AS total_salary
FROM Employee;

-- 17. Select the average salary of employees.
SELECT AVG(salary) AS average_salary
FROM Employee;

-- 18. Select the maximum salary in the Employee table.
SELECT MAX(salary) AS maximum_salary
FROM Employee;

-- 19. Select the number of employees in each department.
SELECT department_id, COUNT(*) AS employee_count
FROM Employee
GROUP BY department_id;

-- 20. Select the average salary of employees in each department.
SELECT department_id, AVG(salary) AS average_salary
FROM Employee
GROUP BY department_id;



-- GROUP BY QUERIES


-- 21. Select the total salary for each department.
SELECT department_id, SUM(salary) AS total_salary
FROM Employee
GROUP BY department_id;

-- 22. Select the average age of employees in each department.
SELECT department_id, AVG(age) AS average_age
FROM Employee
GROUP BY department_id;

-- 23. Select the number of employees hired in each year.
SELECT YEAR(hire_date) AS hire_year,
COUNT(*) AS employee_count
FROM Employee
GROUP BY YEAR(hire_date);

-- 24. Select the highest salary in each department.
SELECT department_id,
MAX(salary) AS highest_salary
FROM Employee
GROUP BY department_id;

-- 25. Ask the department with the highest average salary.
SELECT department_id,
AVG(salary) AS average_salary
FROM Employee
GROUP BY department_id
ORDER BY average_salary DESC
LIMIT 1;


-- HAVING QUERIES


-- 26. Select departments with more than 2 employees.
SELECT department_id,
COUNT(*) AS employee_count
FROM Employee
GROUP BY department_id
HAVING COUNT(*) > 2;

-- 27. Select departments with an average salary greater than 55000.
SELECT department_id,
AVG(salary) AS average_salary
FROM Employee
GROUP BY department_id
HAVING AVG(salary) > 55000;

-- 28. Select years with more than 1 employee hired.
SELECT YEAR(hire_date) AS hire_year,
COUNT(*) AS employee_count
FROM Employee
GROUP BY YEAR(hire_date)
HAVING COUNT(*) > 1;

-- 29. Select departments with a total salary expense less than 100000.
SELECT department_id,
SUM(salary) AS total_salary
FROM Employee
GROUP BY department_id
HAVING SUM(salary) < 100000;

-- 30. Select departments with the maximum salary above 75000.
SELECT department_id,
MAX(salary) AS max_salary
FROM Employee
GROUP BY department_id
HAVING MAX(salary) > 75000;



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


