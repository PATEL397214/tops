create database H_R ;
use H_R ;


alter table employee add column location varchar(30) ;

alter table employee add column DEPARTMENT_ID varchar(22) ;

select * from employee ;

-- Q1 :  Display all information in the tables EMP and DEPT.

select * from employee;

-- Q2 : Display only the hire date and employee name for each employee. 

select LAST_NAME , HIRE_DATE from employee ;

-- Q3 : Display the ename concatenated with the job ID, separated by a comma and space, and name the column Employee and Title 

select concat(LAST_NAME,' , ',JOBB_ID) as ' Employee_and_Title ' from employee ;

-- Q4 : Display the hire date, name and department number for all clerks.

select HIRE_DATE,LAST_NAME,DEPARTMENT_ID from employee ;

-- Q5 : Create a query to display all the data from the EMP table. Separate each column by a comma. Name the column THE OUTPUT 

select employee.* , ' , ' as "the_output" from employee ;

-- Q6 : Display the names and salaries of all employees with a salary greater than 2000. 

select LAST_NAME,SALARY from employee where SALARY > 2000 ;

-- Q7 : Display the names and dates of employees with the column headers "Name" and "Start Date"

select LAST_NAME as Name ,
       HIRE_DATE as Start_Date from employee ;
       
-- Q8 : Display the names and hire dates of all employees in the order they were hired.   

select LAST_NAME , HIRE_DATE from employee order by HIRE_DATE ;   

-- Q9 :  Display the names and salaries of all employees in reverse salary order. 

select  LAST_NAME, SALARY from employee order by SALARY desc ;

-- Q10 : Display 'ename" and "deptno" who are all earned commission and display salary in reverse order.

select LAST_NAME,DEPARTMENT_ID from employee WHERE COMMISSION_PCT IS NOT NULL
ORDER BY salary DESC;

-- Q11 :  Display the last name and job title of all employees who do not have a manager. 

SELECT LAST_NAME, JOBB_ID
FROM employee
WHERE MANAGER_ID IS NULL;

-- Q12 : Display the last name, job, and salary for all employees whose job is sales representative 
--       or stock clerk and whose salary is not equal to $2,500, $3,500, or $5,000

SELECT LAST_NAME, JOBB_ID, SALARY
FROM employee
WHERE (JOBB_ID = 'sales representative' OR JOBB_ID = 'stock clerk')
AND (SALARY NOT IN (2500, 3500, 5000));

SELECT LAST_NAME, JOBB_ID, SALARY
FROM employee
WHERE (SALARY NOT IN (2500, 3500, 5000));



/* part - 2 */

-- Q1 :  Display the maximum, minimum and average salary and commission earned. 

SELECT 
    MAX(SALARY) AS max_salary,
    MIN(SALARY) AS min_salary,
    AVG(SALARY) AS avg_salary,
    MAX(COMMISSION_PCT) AS max_commission,
    MIN(COMMISSION_PCT) AS min_commission,
    AVG(COMMISSION_PCT) AS avg_commission
FROM employee ;


-- Q2 : Display the department number, total salary payout and total commission payout for each department. 

select DEPARTMENT_ID ,
sum(SALARY) as total_salary_payout ,
sum(COMMISSION_PCT) as total_commission_payout 
from employee 
group by DEPARTMENT_ID ;

-- Q3 : Display the department number and number of employees in each department.

select DEPARTMENT_ID , count(EMPLOYEE_ID) as num_employees from employee
group by DEPARTMENT_ID ;


-- Q4 : Display the department number and total salary of employees in each department.

select DEPARTMENT_ID , sum(SALARY) as total_salary from employee
group by DEPARTMENT_ID ;

-- Q5 : Display the employee's name who doesn't earn a commission. Order the result set without using the column name

select * from employee where COMMISSION_PCT is null order by 1 ;

-- Q6 : Display the employees name, department id and commission. If an Employee doesn't 
--      earn the commission, then display as 'No commission'. Name the columns appropriately.

select LAST_NAME,DEPARTMENT_ID,COMMISSION_PCT ,
case 
when COMMISSION_PCT is null then 'No Commission'
else 'commission' 
end as COMMISSION_PCT 
from employee ;


-- Q7 : Display the employee's name, salary and commission multiplied by 2. If an Employee 
--      doesn't earn the commission, then display as 'No commission. Name the columns appropriately.

SELECT LAST_NAME,SALARY,
CASE
WHEN COMMISSION_PCT IS NOT NULL THEN COMMISSION_PCT * 2
ELSE 'No commission' 
END AS appropriately
FROM employee ;

-- Q8 :  Display the employee's name, department id who have the first name same as another employee in the same department

select  LAST_NAME,DEPARTMENT_ID 
FROM EMPLOYEE
GROUP BY LAST_NAME , DEPARTMENT_ID 
HAVING COUNT(*) > 1;

-- Q9 : Display the sum of salaries of the employees working under each Manager.

select MANAGER_ID , sum(SALARY) as total_salary 
from employee group by MANAGER_ID ;

-- Q10 : Select the Managers id, the count of employees working under and the department ID of the manager.

select MANAGER_ID , count(EMPLOYEE_ID) as emp_count ,DEPARTMENT_ID 
from employee
group by MANAGER_ID,DEPARTMENT_ID ;

-- Q11 : Select the employee name, department id, and the salary. Group the result with the 
--       manager name and the employee last name should have second letter 'a! 


-- Q12 : Display the average of sum of the salaries and group the result with the department id. Order the result with the department id. 

SELECT DEPARTMENT_ID, AVG(total_salary) AS average_salary
FROM (
    SELECT DEPARTMENT_ID, SUM(salary) AS total_salary
    FROM employee
    GROUP BY DEPARTMENT_ID
) AS department_salaries
GROUP BY DEPARTMENT_ID
ORDER BY DEPARTMENT_ID;

/*select DEPARTMENT_ID ,avg(SALARY) as avg_salary from emp_data
group by DEPARTMENT_ID 
order by DEPARTMENT_ID ; */

-- Q13 : Select the maximum salary of each department along with the department id.

SELECT DEPARTMENT_ID, MAX(SALARY) AS max_salary
FROM employee
GROUP BY DEPARTMENT_ID;

-- Q14 : Display the commission, if not null display 10% of salary, if null display a default value 1.

SELECT EMPLOYEE_ID,
CASE
     WHEN COMMISSION_PCT IS NOT NULL THEN salary * 0.10
	 ELSE 1
     END AS commission_result
FROM employee
order by EMPLOYEE_ID;


/* PART - 3 */


-- Q1 : 1. Write a query that displays the employee's last names only from the string's 2-5th position with 
--         the first letter capitalized and all other letters lowercase, Give each column an appropriate label. 


-- Q2 : Write a query that displays the employee's first name and last name along with a " in between for
--  	e.g.: first name : Ram; last name : Kumar then Ram-Kumar. Also displays the month on which the employee has joined.

SELECT
  CONCAT(LAST_NAME, '-', FRIST_NAME) AS full_name,
  MONTH(HIRE_DATE) AS join_month
FROM employee ;

-- Q3 : Write a query to display the employee's last name and if half of the salary is greater than 
--      ten thousand then increase the salary by 10% else by 11.5% along with the bonus amount of 
--      1500 each. Provide each column an appropriate label.

SELECT
    FRIST_NAME ,
    CASE
        WHEN SALARY * 0.5 > 10000 THEN SALARY * 1.1
        ELSE SALARY * 1.115
    END AS "New Salary",
    1500 AS "Bonus Amount"
FROM
    EMPLOYEE ;
 

-- Q4 : Display the employee ID by Appending two zeros after 2nd digit and 'E' in the end, department id, 
--      salary and the manager name all in Upper case, if the Manager name consists of 'z' replace it with '$! 

SELECT 
    CONCAT(
        SUBSTRING(EMPLOYEE_ID, 1, 2), 
        '00',                          
        SUBSTRING(EMPLOYEE_ID, 3),     
        'E'                           
    ) AS modified_employee_id,
    UPPER(DEPARTMENT_ID) AS modified_department_id,
    SALARY,
    REPLACE(UPPER(LAST_NAME), 'Z', '$!') AS modified_manager_name
FROM
    employee ;


-- Q5 : Write a query that displays the employee's last names with the first letter capitalized and all other letters 
--      lowercase, and the length of the names, for all employees whose name starts with J, A, or M. 
--      Give each column an appropriate label. Sort the results by the employees' last names 


SELECT 
    CONCAT(
        UPPER(LEFT(FRIST_NAME, 1)), 
        LOWER(SUBSTRING(FRIST_NAME, 2))
    ) AS "Employee Name",
    LENGTH(FRIST_NAME) AS "Name Length"
FROM 
    employee
WHERE 
    FRIST_name LIKE 'J%' OR
    FRIST_name LIKE 'A%' OR
    FRIST_name LIKE 'M%' 
ORDER BY 
    FRIST_name  ;
    
    
    
-- Q6 :  Create a query to display the last name and salary for all employees. Format the salary to 
--       be 15 characters long, left-padded with $. Label the column SALARY 

SELECT
    FRIST_name ,
    LPAD(CONCAT('$', salary), 15, '$') AS "SALARY"
FROM employee;


-- Q7 :  Display the employee's name if it is a palindrome.

SELECT LAST_NAME
FROM employee
WHERE LAST_NAME = REVERSE(LAST_NAME);

-- Q8 :  Display First names of all employees with initcaps.

 
SELECT CONCAT(UPPER(SUBSTRING(LAST_NAME, 1, 1)), LOWER(SUBSTRING(LAST_NAME, 2))) AS initcaps_LAST_name
FROM EMPLOYEE ;



-- Q9 :  From LOCATIONS table, extract the word between first and second space from the STREET ADDRESS column.
 





-- Q10 :  Extract first letter from First Name column and append it with the Last Name. Also add "@systechusa.com" at the end.
--        Name the column as e-mail address. All characters should be in lower case. Display this along with their First Name.  

SELECT
    CONCAT(
        LOWER(LEFT(LAST_NAME, 1)), 
        LOWER(FRIST_NAME),
        '@systechusa.com'
    ) AS 'e-mail address' ,
    LAST_NAME
FROM
    employee ;
    
-- Q11 :  Display the names and job titles of all employees with the same job as Trenna.

SELECT LAST_NAME, JOBB_ID
FROM employee
WHERE JOBB_ID = (SELECT JOBB_ID FROM employee WHERE LAST_NAME = 'JMALLIN');


-- Q12 : Display the names and department name of all employees working in the same city as Trenna.    


 
-- Q13 : Display the name of the employee whose salary is the lowest.    
    
SELECT LAST_NAME,SALARY
FROM employee
ORDER BY SALARY
LIMIT 1;

-- Q14 : Display the names of all employees except the lowest paid.


SELECT LAST_NAME,SALARY
FROM employee
WHERE SALARY > (
  SELECT MIN(SALARY)
  FROM employee
);




/* Part : 4 */



-- Q1 : Write a query to display the last name, department number, department name for all employees.

select FRIST_NAME,DEPARTMENT_ID,DEPARTMENT_NAME from employee ;


-- Q2 : Create a unique list of all jobs that are in department 4. Include the location of the department in the output. 

SELECT DISTINCT DEPARTMENT_ID
FROM EMPLOYEE ;


-- Q3 : Write a query to display the employee last name,department name,location id and city of all employees who earn commission. 

select LAST_NAME,DEPARTMENT_ID,LOCATION_CITY from employee where COMMISSION_PCT is not null ;


-- Q4 : Display the employee last name and department name of all employees who have an 'a' in their last name. 

SELECT FRIST_NAME, DEPARTMENT_ID
FROM empLOYEE
WHERE FRIST_NAME LIKE 'a%';


-- Q5 :  Write a query to display the last name,job,department number and department name for all employees who work in Ahmedabad . 

select FRIST_NAME,DEPARTMENT_ID FROM EMPLOYEE where LOCATION_CITY = 'AHMEDABAD' ;

-- Q6 : Display the employee last name and employee number along with their manager's last name and manager number.

SELECT EMPLOYEE_ID,FRIST_NAME,MANAGER_ID
FROM employee
where  EMPLOYEE_ID = MANAGER_ID 
order by MANAGER_ID  ;


-- Q7 : Display the employee last name and employee number along with their manager's last 
--        name and manager number (including the employees who have no manager). 


-- Q8 : Create a query that displays employees last name,department number,and all the 
--       employees who work in the same department as a given employee.


select FRIST_NAME, DEPARTMENT_ID from employee 
order by  DEPARTMENT_ID ;


-- Q9 :  Create a query that displays the name,job,department name,salary,grade for all 
--        employees. Derive grade based on salary(>=5000=A, >=3000=B,<3000=C).

SELECT
    LAST_NAME,JOBB_ID,DEPARTMENT_ID,SALARY,

    CASE
        WHEN SALARY >= 5000 THEN 'A'
        WHEN SALARY >= 3000 THEN 'B'
        ELSE 'C'
    END AS Grade
FROM
    employee ;
    
/*   Q10 : Display the names and hire date for all employees who were hired before their 
		   managers along withe their manager names and hire date. Label the columns as Employee 
           name, emp_hire_date,manager name,man_hire_date.   */