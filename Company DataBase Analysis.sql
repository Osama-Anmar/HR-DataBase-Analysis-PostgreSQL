/* 1. Select From */

SELECT * FROM salaries
LIMIT 10;

/* 2. ORDER BY */
/* Find The Hire Date Of Each Employee*/
SELECT first_name, last_name, hire_date FROM employees
ORDER BY hire_date DESC;

/* 3. DELETE */
/* Remove Duplicated Values From Salries Table*/
DELETE FROM salaries S1
    USING   salaries S2
WHERE   S1.from_date < S2.from_date  
    AND S1.emp_no  = S2.emp_no;

/* Remove Duplicated Values From Department Employee Table*/
DELETE FROM dept_emp E1
    USING   dept_emp E2
WHERE   E1.to_date > E2.to_date  
    AND E1.emp_no  = E2.emp_no;
	
/* Remove Duplicated Values From Department Titles Table*/
DELETE FROM titles T1
    USING   titles T2
WHERE   T1.from_date < T2.from_date
    AND T1.emp_no  = T2.emp_no;

/* Remove Duplicated Values From Department Manager Table*/
DELETE FROM dept_manager M1
    USING   dept_manager M2
WHERE   M1.from_date < M2.from_date
    AND M1.dept_no  = M2.dept_no;
	

/* 4. DROP */
/* Remove Columns From Salaries Table*/
ALTER TABLE salaries
DROP COLUMN from_date,
DROP COLUMN to_date;

/* Remove Columns From Department Employee Table*/
ALTER TABLE dept_emp
DROP COLUMN from_date,
DROP COLUMN to_date;

/* Remove to_date Columns From Department Manager Table*/
ALTER TABLE dept_manager
DROP COLUMN to_date;

/* Remove to_date Columns From Titles Table*/
ALTER TABLE titles
DROP COLUMN to_date;


/* 5. DISTINCT */
/* Find The Unique First Name*/
SELECT DISTINCT first_name FROM employees
ORDER BY first_name;

/* 6. COUNT */
/* Find The Count Of Salary*/
SELECT COUNT(salary) FROM salaries;

/* 7. WHERE */
/* Display Employee ID With Salary More Than 50000*/
SELECT emp_no, salary FROM salaries
WHERE salary > 50000

ORDER BY emp_no ASC
LIMIT 20;

/* Display Employee ID With Salary More Than 60000*/
SELECT * FROM salaries 
WHERE salary > 60000
ORDER BY salary ASC
LIMIT 20;

/* Display Department ID Whose Department Name Sales */
SELECT * FROM departments 
WHERE dept_name = 'Sales';

/* Display All Employee Information Whose Gender Female And First Name Bezalel */
SELECT * FROM employees 
WHERE gender = 'F'
AND first_name = 'Bezalel'
LIMIT 20;

/* Display All Employee Information Whose Gender Female And First Name Bezalel Or Anneke */
SELECT * FROM employees 
WHERE gender = 'F'
AND first_name = 'Bezalel'
OR first_name = 'Anneke'
LIMIT 20;

/* 8. BETWEEN */
/* Display The Salary Between 1986-06-26 AND 1999-02-08 And Salary More Than 80000*/
SELECT * FROM salaries
WHERE from_date BETWEEN '1986-06-26' AND '1999-02-08'
AND salary > 80000
LIMIT 25;

/* 9. LIKE */
/* Display Employees Whose First Name Start With G, Last Name Start With F, Gender Male And Birth Date Bigger Than 1960-01-01*/
SELECT * FROM employees 
WHERE first_name LIKE 'G%' AND last_name LIKE 'F%' 
AND gender = 'M' AND birth_date > '1960-01-01'
LIMIT 20;

/* Display Employees Whose First Name Contain d, Last Name Contain t, Gender Male And Birth Date Bigger Than 1960-01-01*/
SELECT * FROM employees 
WHERE first_name LIKE '%d%' AND last_name LIKE '%t%' 
AND gender = 'M' AND birth_date > '1960-01-01'
LIMIT 20;

/* 10. ILIKE */
/* Display Employees Whose First Name Contain u Or U, Last Name Contain b Or B, Gender Male And Birth Date Bigger Than 1960-01-01*/
SELECT * FROM employees 
WHERE first_name ILIKE 'u%' AND last_name ILIKE 'b%' 
AND gender = 'M' AND birth_date > '1960-01-01'
LIMIT 20;

/* 11. NOT LIKE */
/* Display Employees Whose First Name Does Not Contain c, Last Name Does Not Contain m, Gender Male And Birth Date Bigger Than 1960-01-01*/
SELECT * FROM employees 
WHERE first_name NOT LIKE '%c%' AND last_name NOT LIKE '%m%' 
AND gender = 'M' AND birth_date > '1960-01-01'
LIMIT 20;

/* 12. AS */
/* Set Title To Select Column*/
SELECT emp_no, title AS employee_position, from_date, to_date
FROM titles;

/* Set Title To birth_date Column Whose First Name Or Last Name Contain o And Gender Is Male*/
SELECT birth_date AS birthday, first_name, last_name, gender
FROM employees
WHERE (first_name LIKE '%o' OR last_name LIKE '%o')
AND gender = 'M'
ORDER BY first_name DESC
LIMIT 20;


/* 13. Aggregation */
/* Display Sum, Maximum, Minumum, And Average Of Salary*/
SELECT SUM(salary) AS sum_of_salary, AVG(salary) AS average_of_salary,
MIN(salary) AS minimum_salary, MAX(salary) AS maximum_salary
FROM salaries
WHERE from_date = '1986-06-26' AND to_date = '1987-06-26';

/* 14. SUBSTRING */
/* Display 3 Letter From First Name Start From Position 3*/
SELECT first_name, SUBSTRING(first_name FROM 3 FOR 3) FROM employees
LIMIT 20;

/* 15. EXTRACT */
/* Extarct Year From Date*/
SELECT EXTRACT(YEAR FROM TIMESTAMP '2016-12-31 13:30:15');

/* 16. TO_CHAR */
/* Convert BirthDate From Date To Text Type*/
SELECT first_name, last_name, birth_date,
TO_CHAR(birth_date, 'DD-MON-YYYY') AS birthday
FROM employees
ORDER BY birth_date DESC;

/* 17. CASE */
/* Split The Salary Into 3 Categories*/
SELECT salary, emp_no,
CASE 
WHEN salary < 60000 THEN 'High Salary'
WHEN salary BETWEEN 50000 AND 20000  THEN  'Medium Salary'
ELSE 'Low Salary'
END
FROM salaries
ORDER BY salary DESC;

/* 18. REPLACE */
/* Cahnge Empoloyee Position From Technique Leader To Technique */
SELECT title, emp_no,
REPLACE (title, 'Technique Leader', 'Technique') AS new_title
FROM titles
WHERE title = 'Technique Leader';

/* 19. INNER JOIN */
/* Disply The Salary Of Each Empoylee*/
SELECT first_name, last_name, salaries.salary FROM employees
INNER JOIN salaries
ON employees.emp_no = salaries.emp_no
WHERE last_name = 'Sigstam' AND first_name = 'Karsten'
;

/* Disply The Manager Of Each Department*/
SELECT employees.first_name, employees.last_name, departments.dept_name, from_date FROM dept_manager
INNER JOIN departments
ON dept_manager.dept_no = departments.dept_no
INNER JOIN employees
ON dept_manager.emp_no = employees.emp_no
;

/* 20. FULL OUTER JOIN */
/* Disply The Salary Of Each Empoylee*/
SELECT first_name, last_name, salaries.salary FROM employees
FULL OUTER JOIN salaries 
ON employees.emp_no = salaries.emp_no;

/* 21. LEFT OUTER JOIN */
/* Disply The Salary Of Each Empoylee*/
SELECT first_name, last_name, salaries.salary FROM employees
LEFT OUTER JOIN salaries 
ON employees.emp_no = salaries.emp_no;

/* 22. RIGHT OUTER JOIN */
/* Disply The Salary Of Each Empoylee*/
SELECT first_name, last_name, salaries.salary FROM employees
RIGHT OUTER JOIN salaries 
ON employees.emp_no = salaries.emp_no;

/* 23. Multiple INNER JOIN*/
/* Disply The Salary Of Each Empoylee And His Position And His Department*/
SELECT first_name, last_name, salaries.salary, departments.dept_name AS department_name, titles.title AS employee_position FROM employees
INNER JOIN dept_emp 
ON dept_emp.emp_no = employees.emp_no
INNER JOIN departments
ON departments.dept_no = dept_emp.dept_no
INNER JOIN salaries
ON employees.emp_no = salaries.emp_no
INNER JOIN titles
ON employees.emp_no = titles.emp_no;

/* 24. Multiple FULL OUTER JOIN*/
/* Disply The Salary Of Each Empoylee And His Position And His Department*/
SELECT first_name, last_name, salaries.salary, departments.dept_name AS department_name, titles.title AS employee_position FROM employees
FULL OUTER JOIN dept_emp 
ON dept_emp.emp_no = employees.emp_no
FULL OUTER JOIN departments
ON departments.dept_no = dept_emp.dept_no
FULL OUTER JOIN salaries
ON employees.emp_no = salaries.emp_no
FULL OUTER JOIN titles
ON employees.emp_no = titles.emp_no;

/* 25. Multiple RIGHT OUTER JOIN*/
/* Disply The Salary Of Each Empoylee And His Position And His Department*/
SELECT first_name, last_name, salaries.salary, departments.dept_name AS department_name, titles.title AS employee_position FROM employees
RIGHT OUTER JOIN dept_emp 
ON dept_emp.emp_no = employees.emp_no
RIGHT OUTER JOIN departments
ON departments.dept_no = dept_emp.dept_no
RIGHT OUTER JOIN salaries
ON employees.emp_no = salaries.emp_no
RIGHT OUTER JOIN titles
ON employees.emp_no = titles.emp_no;

/* 26. Multiple LEFT OUTER JOIN*/
/* Disply The Salary Of Each Empoylee And His Position And His Department*/
SELECT first_name, last_name, salaries.salary, departments.dept_name AS department_name, titles.title AS employee_position FROM employees
LEFT OUTER JOIN dept_emp 
ON dept_emp.emp_no = employees.emp_no
LEFT OUTER JOIN departments
ON departments.dept_no = dept_emp.dept_no
LEFT OUTER JOIN salaries
ON employees.emp_no = salaries.emp_no
LEFT OUTER JOIN titles
ON employees.emp_no = titles.emp_no
;

/* 27. SUBQUERIES */
/* Disply The Employees Whose Thier Salary More Than Average Salary*/
SELECT first_name, last_name, salaries.salary FROM employees
INNER JOIN salaries
ON employees.emp_no = salaries.emp_no
WHERE salary > (SELECT AVG(salary) FROM salaries)
LIMIT 20;


/* Disply The Employees Whose Thier Salary More Than Average Salary And Thier Position And Thier Department*/
SELECT first_name, last_name, salaries.salary, departments.dept_name AS department_name, titles.title AS employee_position FROM employees
INNER JOIN dept_emp 
ON dept_emp.emp_no = employees.emp_no
INNER JOIN departments
ON departments.dept_no = dept_emp.dept_no
INNER JOIN salaries
ON employees.emp_no = salaries.emp_no
INNER JOIN titles
ON employees.emp_no = titles.emp_no
WHERE salary > (SELECT AVG(salary) FROM salaries);

/* Disply The Employees Whose Thier Salary Less Than Average Salary And Thier Position And Thier Department*/
SELECT first_name, last_name, salaries.salary, departments.dept_name AS department_name, titles.title AS employee_position FROM employees
INNER JOIN dept_emp 
ON dept_emp.emp_no = employees.emp_no
INNER JOIN departments
ON departments.dept_no = dept_emp.dept_no
INNER JOIN salaries
ON employees.emp_no = salaries.emp_no
INNER JOIN titles
ON employees.emp_no = titles.emp_no
WHERE salary < (SELECT AVG(salary) FROM salaries);

/* 28.Correlated Subqueries*/
/* Find The Employees Whose Salaries Are Higher Than Average*/
SELECT first_name, last_name, salaries.salary FROM employees
INNER JOIN salaries
ON employees.emp_no = salaries.emp_no
WHERE salary > (SELECT AVG(salary) FROM salaries WHERE employees.hire_date = employees.hire_date)
LIMIT 20;

/* 29.View*/
CREATE VIEW salaries_less_than_average
AS
SELECT first_name, last_name, salaries.salary, departments.dept_name AS department_name, titles.title AS employee_position FROM employees
INNER JOIN dept_emp 
ON dept_emp.emp_no = employees.emp_no
INNER JOIN departments
ON departments.dept_no = dept_emp.dept_no
INNER JOIN salaries
ON employees.emp_no = salaries.emp_no
INNER JOIN titles
ON employees.emp_no = titles.emp_no
WHERE salary < (SELECT AVG(salary) FROM salaries)
AND first_name LIKE 'C%'
;
SELECT * FROM salaries_less_than_average;

/* 30.GROUP BY*/
/* Find Total Salary Of Each Department*/
SELECT SUM(salaries.salary) AS sum_of_salary, departments.dept_name FROM dept_emp
INNER JOIN salaries
ON salaries.emp_no = dept_emp.emp_no
INNER JOIN departments
ON departments.dept_no = dept_emp.dept_no
GROUP BY departments.dept_name
ORDER BY sum_of_salary DESC;

/* Find Total Salary Of Each Position*/
SELECT SUM(salaries.salary) AS sum_of_salary, titles.title AS employee_position FROM dept_emp
INNER JOIN salaries
ON salaries.emp_no = dept_emp.emp_no
INNER JOIN titles
ON titles.emp_no = dept_emp.emp_no
GROUP BY titles.title
ORDER BY sum_of_salary DESC;

/* Find Average Salary OF Each Department*/
SELECT ROUND(AVG(salaries.salary)) AS average_of_salary, departments.dept_name FROM dept_emp
INNER JOIN salaries
ON salaries.emp_no = dept_emp.emp_no
INNER JOIN departments
ON departments.dept_no = dept_emp.dept_no
GROUP BY departments.dept_name
ORDER BY average_of_salary DESC;

/* Find Average Salary OF Each Position*/
SELECT ROUND(AVG(salaries.salary)) AS average_of_salary, titles.title AS employee_position FROM dept_emp
INNER JOIN salaries
ON salaries.emp_no = dept_emp.emp_no
INNER JOIN titles
ON titles.emp_no = dept_emp.emp_no
GROUP BY titles.title
ORDER BY average_of_salary ASC;

/* Find Number Of Eployees In Each Position*/
SELECT COUNT(employees.emp_no) AS empolyees_count, titles.title AS employee_position FROM dept_emp
INNER JOIN employees
ON employees.emp_no = dept_emp.emp_no
INNER JOIN titles
ON titles.emp_no = dept_emp.emp_no
GROUP BY titles.title
ORDER BY empolyees_count DESC ;

/* Find Number Of Eployees In Each Department*/
SELECT COUNT(employees.emp_no) AS empolyees_count, departments.dept_name AS departmnet_name FROM dept_emp
INNER JOIN employees
ON employees.emp_no = dept_emp.emp_no
INNER JOIN departments
ON departments.dept_no = dept_emp.dept_no
GROUP BY departments.dept_name
ORDER BY empolyees_count DESC ;


/* Find Number Of Eployees In Each Posiotion Of Each Department*/
SELECT COUNT(employees.emp_no) AS empolyees_count, departments.dept_name AS department_name, titles.title AS employee_position FROM dept_emp
INNER JOIN employees
ON employees.emp_no = dept_emp.emp_no
INNER JOIN departments
ON departments.dept_no = dept_emp.dept_no
INNER JOIN titles
ON titles.emp_no = dept_emp.emp_no
GROUP BY departments.dept_name, titles.title
ORDER BY departments.dept_name DESC ;

/* 31.CONCAT*/
/* Merge First Name And Last Into One Column*/
SELECT CONCAT (first_name, ' ', last_name) AS employe_full_name FROM employees;

/* 32.HAVING*/
/* Display Which Department Has More Than 10000 Employee And What Is The Position Of Each Count Of Employee*/
SELECT COUNT(employees.emp_no) AS empolyees_count, departments.dept_name AS department_name, titles.title AS employee_position FROM dept_emp
INNER JOIN employees
ON employees.emp_no = dept_emp.emp_no
INNER JOIN departments
ON departments.dept_no = dept_emp.dept_no
INNER JOIN titles
ON titles.emp_no = dept_emp.emp_no
GROUP BY departments.dept_name, titles.title
HAVING COUNT(employees.emp_no) > 10000
ORDER BY departments.dept_name ASC ;