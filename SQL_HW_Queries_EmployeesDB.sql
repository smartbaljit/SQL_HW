
DROP TABLE IF EXISTS titles;
DROP TABLE IF EXISTS salaries;
DROP TABLE IF EXISTS dept_manager;
DROP TABLE IF EXISTS dept_emp;
DROP TABLE IF EXISTS departments;
DROP TABLE IF EXISTS employees;



CREATE TABLE Employees (
	emp_no INTEGER PRIMARY KEY NOT NULL,
	birth_date DATE NOT NULL,
	first_name VARCHAR(40) NOT NULL,
	last_name VARCHAR(40) NOT NULL,
	gender VARCHAR(10),
	hire_date DATE NOT NULL
);

SELECT * FROM employees;

CREATE TABLE departments(
	dept_no VARCHAR(30) PRIMARY KEY NOT NULL, 	
	dept_name VARCHAR(40) NOT NULL
);

SELECT * FROM departments;

CREATE TABLE dept_emp (
	emp_no INTEGER,
	dept_no	VARCHAR(30),
	from_date DATE NOT NULL,	
	to_date DATE NOT NULL,
	PRIMARY KEY (emp_no, dept_no),
	FOREIGN KEY (emp_no) REFERENCES employees(emp_no),
	FOREIGN KEY (dept_no) REFERENCES departments(dept_no)
);

SELECT * FROM dept_emp;

CREATE TABLE dept_manager(
	dept_no	VARCHAR(30),	
	emp_no INTEGER,
	from_date DATE,	
	to_date DATE,
	PRIMARY KEY (emp_no, dept_no),
	FOREIGN KEY (emp_no) REFERENCES employees(emp_no),
	FOREIGN KEY (dept_no) REFERENCES departments(dept_no)
);

SELECT * FROM dept_manager;

CREATE TABLE salaries(
	emp_no INTEGER,
	salary FLOAT NOT NULL,
	from_date DATE,
	to_date DATE,
	primary key(emp_no),	
	FOREIGN KEY (emp_no) REFERENCES employees(emp_no)
);

SELECT * FROM salaries;


CREATE TABLE titles(
	emp_no INTEGER,
	title VARCHAR(50) NOT NULL,
	from_date DATE,
	to_date DATE,
	FOREIGN KEY (emp_no) REFERENCES employees(emp_no)
);

SELECT * FROM titles;
----------------------------------------------------------------------------------------------

--1. List the following details of each employee:
--employee number, last name, first name, gender, and salary

SELECT a.emp_no, a.first_name, a.last_name, a.gender, b.salary 
FROM employees AS a INNER JOIN salaries AS b 
ON a.emp_no=b.emp_no
ORDER BY a.emp_no;

----------------------------------------------------------------------------------------------

--2. List employees who were hired in 1986.

SELECT * FROM employees
WHERE hire_date >= '01/01/1986' AND hire_date < '01/01/1987';

-----------------------------------------------------------------------------------------------

--3. List the manager of each department with the following information: 
--department number, department name, the manager's employee number, last name, first name, 
--and start and end employment dates.


SELECT a.dept_no, a.dept_name, b.emp_no, c.first_name, c.last_name, b.from_date, b.to_date
FROM departments AS a 
INNER JOIN dept_manager AS b ON a.dept_no=b.dept_no
INNER JOIN employees AS c ON b.emp_no=c.emp_no;

-----------------------------------------------------------------------------------------------

--4. List the department of each employee with the following information: 
--employee number, last name, first name, and department name.

SELECT a.emp_no, a.last_name, a.first_name, b.dept_name
FROM employees AS a 
INNER JOIN dept_emp AS c  ON a.emp_no=c.emp_no 
INNER JOIN departments AS b ON  b.dept_no=c.dept_no
ORDER BY a.emp_no;


------------------------------------------------------------------------------------------------

--5. List all employees whose first name is "Hercules" and last names begin with "B."

SELECT * FROM employees 
WHERE first_name ='Hercules' AND last_name like 'B%'

------------------------------------------------------------------------------------------------

--6. List all employees in the Sales department, 
--including their employee number, last name, first name, and department name.

SELECT a.emp_no, a.first_name, a.last_name, c.dept_name
FROM employees AS a 
INNER JOIN dept_emp AS b on a.emp_no=b.emp_no 
INNER JOIN departments AS c ON b.dept_no=c.dept_no
where c.dept_name='Sales'
;

------------------------------------------------------------------------------------------------

--7. List all employees in the Sales and Development departments,
--including their employee number, last name, first name, and department name.

SELECT a.emp_no, a.first_name, a.last_name, c.dept_name
FROM employees AS a 
INNER JOIN dept_emp AS b on a.emp_no=b.emp_no 
INNER JOIN departments AS c ON b.dept_no=c.dept_no
where c.dept_name='Sales' OR c.dept_name='Development'
;

------------------------------------------------------------------------------------------------

--8. In descending order, list the frequency count of employee last names, 
--i.e., how many employees share each last name.

SELECT last_name, COUNT(last_name) AS Emp_Count FROM employees
GROUP BY last_name
ORDER BY Emp_Count DESC
;


--Bonus
--average salary by title

SELECT b.title, AVG(a.salary) AS "Average Salary" FROM salaries AS a
INNER JOIN titles AS b
ON a.emp_no=b.emp_no
GROUP BY b.title

