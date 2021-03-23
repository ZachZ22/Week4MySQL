/*
This stored procedure will give the peron a %100 raise.
This procedure can be used to quickly give an employee a raise.
*/

DELIMITER $$

drop procedure if exists raise100 $$
CREATE PROCEDURE raise100(
IN empNumber int,
OUT newSalary int
)
BEGIN
DECLARE salaryOne int;
DECLARE updatedSalary int;
SELECT salary
INTO salaryOne
FROM employees.salaries
WHERE emp_no = empNumber
limit 1;
SET   updatedSalary = salaryOne * 2;
SELECT updatedSalary INTO newSalary;
END $$

CALL raise100(10100, @newSalary);
SELECT @newSalary;
/*
This stored procedure will check to see if the employee is still employeed at the company
*/

DELIMITER $$
drop procedure if exists isStillEmployed $$
CREATE PROCEDURE isStillEMployed(
IN empNumber int,
OUT booleanHasLeft int
)
BEGIN
DECLARE emp_no int;
DECLARE endYear int;
SELECT to_date 
INTO endYear
FROM dept_emp 
WHERE  emp_no = empNumber
limit 1;
IF endYear = 9999-01-01 THEN
SET endYear = 0;
ELSE
SET endYear = 1;
END IF;
SELECT endYear INTO booleanHasLeft;
END $$
CALL isStillEmployed(10100, @booleanHasLeft);
SELECT @booleanHasLeft;

/*
This stored procedure will do a quick test to see if the employee is making over $70,000 salary.
This procedure will Need an Input of employees number to identify the employee in question. 
It will then return 0 for less then 70k and 1 for more then 70k
*/
DELIMITER $$
drop procedure if exists salaryAboveSeventyThousand $$
CREATE procedure salaryAboveSeventyThousand(
 
 IN emp_number int,
 OUT testIfSalary varchar(6)
) 
BEGIN
DECLARE SalaryAmount int;
DECLARE testSalary int;
SELECT 
    salary
INTO SalaryAmount
FROM
    employees.salaries
WHERE emp_no = emp_number
limit 1;
IF SalaryAmount <= 70000 THEN
SET testSalary = 0;
ELSE 
SET testSalary = 1;
END IF;
SELECT testSalary INTO testIfSalary;
END $$
CALL salaryAboveSeventyThousand(10100, @testIfSalary);
SELECT @testIfSalary;




/* 
This stored procedure will quickly desplay the title of the employee.
This well be useful for people querying the data base to know what the employee name and title is.
You will use this procedure by inserting an employee number and getting their Name and title.alter
*/

DELIMITER $$
drop procedure if exists displayTitle $$
CREATE PROCEDURE displayTitle(
IN employee_number int,
OUT first_name varchar(30),
OUT last_name varchar(30),
OUT title varchar(30)
)
BEGIN
DECLARE enumber int;
DECLARE firstName varchar(30);
DECLARE lastName varchar(30);
DECLARE titleVar varchar(30);
SELECT employees.emp_no, employees.first_name, employees.last_name, titles.title
 FROM employees 
 INNER JOIN titles 
 ON titles.emp_no = employees.emp_no
 WHERE employees.emp_no = enumber
 INTO @enumber, @firstName, @lastName, @titleVar;
END;
CALL displayTitle(10100, @first_name, @last_name, @title);
SELECT @enumber, @first_name,  @last_name, @title;


/*
First Stored Procedure was written in notepad…….. For the rest I switched over to MySQL workbench.

1.
Last Name starts with A

delimiter ; ++

create procedure employeeLastNameA()
SELECT * FROM employees WHERE last_name LIKE 'a%';
 ++

delimiter ; ++

call employeeLastNameA;
*/

