
--Employee Management System

--create table

CREATE TABLE employees (
    employee_id    NUMBER(6)    NOT NULL,
    first_name     VARCHAR2(20),
    last_name      VARCHAR2(25) NOT NULL,
    email          VARCHAR2(25) NOT NULL,
    phone_number   VARCHAR2(20),
    hire_date      DATE          NOT NULL,
    job_id         VARCHAR2(10) NOT NULL,
    salary         NUMBER(8,2),
    commission_pct NUMBER(2,2),
    manager_id     NUMBER(6),
    department_id  NUMBER(4),
    CONSTRAINT pk_employee_id PRIMARY KEY (employee_id)
);

CREATE TABLE departments (
    department_id   NUMBER(4)    NOT NULL,
    department_name VARCHAR2(30) NOT NULL,
    manager_id      NUMBER(6),
    location_id     NUMBER(4),
    CONSTRAINT pk_department_id PRIMARY KEY (department_id)
);

CREATE TABLE countries (
    country_id   CHAR(2)       NOT NULL,
    country_name VARCHAR2(40),
    region_id    NUMBER,
    CONSTRAINT pk_country_id PRIMARY KEY (country_id)
);

CREATE TABLE locations (
    location_id     NUMBER(4)    NOT NULL,
    street_address  VARCHAR2(40),
    postal_code     VARCHAR2(12),
    city            VARCHAR2(30) NOT NULL,
    state_province  VARCHAR2(25),
    country_id      CHAR(2),
    CONSTRAINT pk_location_id PRIMARY KEY (location_id),
    CONSTRAINT fk_country_id FOREIGN KEY (country_id) REFERENCES countries(country_id)
);

CREATE TABLE regions (
    region_id   NUMBER       NOT NULL,
    region_name VARCHAR2(25),
    CONSTRAINT pk_region_id PRIMARY KEY (region_id)
);

CREATE TABLE jobs (
    job_id     VARCHAR2(10) NOT NULL,
    job_title  VARCHAR2(35) NOT NULL,
    min_salary NUMBER(6),
    max_salary NUMBER(6),
    CONSTRAINT pk_job_id PRIMARY KEY (job_id)
);

CREATE TABLE job_history (
    employee_id   NUMBER(6)    NOT NULL,
    start_date    DATE         NOT NULL,
    end_date      DATE         NOT NULL,
    job_id        VARCHAR2(10) NOT NULL,
    department_id NUMBER(4),
    CONSTRAINT pk_job_history PRIMARY KEY (employee_id, start_date),
    CONSTRAINT fk_job_id FOREIGN KEY (job_id) REFERENCES jobs(job_id),
    CONSTRAINT fk_department_id FOREIGN KEY (department_id) REFERENCES departments(department_id)
);

-- queries:

select * from employees;                                                        --select query

SELECT * FROM Departments;

SELECT * FROM COUNTRIES ;

SELECT * FROM LOCATIONS;

SELECT * FROM REGIONS;

SELECT * FROM JOBS;

SELECT * FROM JOB_HISTORY;

select first_name,last_name from employees;                                     --column level restristions

select * from employees where first_name like 'S_r%';                           --as key word

select * from employees where salary > 20000;                                   --greater than

select * from employees where salary < 12000;                                   --less than

select * from employees where salary >= 17000;                                  --greater than or equal

select * from employees where salary <= 17000;                                  --less than or equal

select * from employees where salary <> 24000;                                  --not equal <> or !=

select * from employees where last_name like 'R%';                              --like % and _                        

select * from regions where region_id  between 3 and 4;                         --betetween ..and

select * from regions where region_id not between 3 and 4;                      -- not between ...and

select * from employees where manager_id is  null;                              --is null=(null)

select * from employees where manager_id is not null;                           --not null

select * from employees where salary  in(24000,17000,4800);                     -- in

select * from employees where salary not in(24000,17000,4800);                  --not in

select * from employees where first_name like 'S%' and salary = 24000;          --AND

select * from employees where first_name like 'S%' or salary = 24000;           --OR

--Alter Table

alter table employees add salary number(70);                                    --add

alter table employees modify id int;                                            --data type change

alter table employees rename column department_id to d_id;                      --rename in column level

alter table employees drop column lacation;                                     --delete in column level

rename employees to emp;                                                        --rename in table level

drop table employees;                                                           --drop in table level

Delete from employees;                                                          --delete in table level

Truncate table employees;                                                       --Truncate

Update Employees set First_Name='Karthik' where  First_Name='Steven';           --Update

--Clauses

select * from employees where department_id = 90;                               --where      

SELECT department_id,COUNT(department_id) FROM employees GROUP BY department_id;--Group by
    
select 
    department_id, 
    COUNT(department_id)
from 
    employees 
GROUP BY 
     department_id HAVING department_id<34;                                     --Having

select * from employees order by salary asc;                                    --Order by (a-z)

select * from employees order by salary desc;                                   --Order by (z to a)

--Single Row Functions

--1.Case Manipulation  

SELECT UPPER('How are you?') FROM DUAL;                                         --UPPER

SELECT * FROM Employees WHERE  LOWER(first_name) = 'steven';                    --LOWER

Select First_name, Initcap(first_name) From Employees;                          --INITCAP

--2.Character Manipulation

SELECT First_name, LENGTH(First_name) FROM Employees;                           --LENGTH

SELECT First_name, SUBSTR(First_name,1,3) FROM Employees;                       --SUBSTR

SELECT First_name, INSTR(First_name,'a') FROM Employees;                        --INSTR

SELECT First_name, REPLACE(First_name,'a','e') FROM Employees;                  --REPLACE

SELECT TRANSLATE('Welcome to oracle session c','lc','XY') FROM Dual;            --TRANSLATE

SELECT LPAD('2500',10,'*') FROM Dual;                                           --LPAD

SELECT RPAD('2500',10,'*') FROM Dual;                                           --RPAD

SELECT LTRIM('000000000001230000000',0) FROM Dual;                              --LTRIM

SELECT RTRIM('000000000001230000000',0) FROM Dual;                              --RTRIM

SELECT First_name, INITCAP(REVERSE(lower(First_name))) FROM Employees;          --REVERSE

--3.Number function

SELECT ROUND(234.346,2),Round(234.344,2) FROM Dual;                             --ROUND

SELECT TRUNC(456.423,-1) FROM Dual;                                             --TRUNC

SELECT POWER(6,5) FROM Dual;                                                    --POWER

SELECT MOD(-25,4) FROM Dual;                                                    -- MOD

--4.Date Function

SELECT MONTHS_BETWEEN( SYSDATE , '21-JAN-89') FROM Dual;                        -- MONTHS_BETWEEN

SELECT ADD_MONTHS('28-FEB-11',1) FROM Dual;                                     --ADD_MONTHS

SELECT NEXT_DAY('05-JUN-13','WEDNESDAY') FROM Dual;                             --NEXT_DAY

SELECT LAST_DAY('21-FEB-12') FROM Dual;                                         --LAST_DAY

--5.Type Conversions

SELECT 5 + TO_NUMBER ('15') FROM Dual;                                          --TO_NUMBER

SELECT 
      Employee_id, First_name, Hire_date,  
      TO_CHAR(Hire_date,'MON/DD/YY')
FROM 
      Employees;                                                                --TO_CHAR

SELECT Employee_id, First_name, Last_name, Salary, Hire_date
FROM   Employees
WHERE  Hire_date = TO_DATE('JUN-17-1987','MON-DD-YYYY');                        --TO_DATE

--6.General Function

SELECT NVL (TO_CHAR (Commission_pct),'NO') FROM Employees;                      -- NVL

SELECT Commission_pct, NVL2 (TO_CHAR(Commission_pct), 'no', 0) FROM Employees;  -- NVL2 

SELECT COALESCE (NULL, NULL, NULL, NULL, NULL,46) FROM Dual;                    --COALESCE

--DECODE : Function

SELECT 
  DISTINCT(Department_id),
  DECODE (Department_id, 10,'IT', 20,'BPO', 30,'KPO', 40,'ADMIN', 50,'HR','Unknown') 
FROM Employees;

--CASE : Expression

SELECT DISTINCT (Department_id),
CASE 
     WHEN Department_id = 10 THEN 'IT'
     WHEN Department_id IN (20, 30) THEN 'BPO'
     WHEN Department_id BETWEEN 40 AND 70 THEN 'KPO'
ELSE 'XXX'
     END 
AS "Department_Name"
FROM Employees;

--Multi Row Functions or Aggeregate Functions 

select MIN(department_id) from Employees;

select MAX(department_id) from Employees;

select SUM(salary) from Employees;

select AVG(salary) from Employees;

select COUNT(salary) from Employees;

--Joins

SELECT
    e1.employee_id,
    e1.first_name,
    e1.manager_id,
    e2.first_name manager_name
FROM
         employees e1
    INNER JOIN employees e2 ON e1.manager_id = e2.employee_id;

SELECT
    *
FROM
    employees   e
    LEFT OUTER JOIN departments d ON e.department_id = d.department_id
WHERE
    d.department_id > 60;

SELECT
    *
FROM
    employees   e
    RIGHT OUTER JOIN departments d ON e.department_id = d.department_id;

SELECT
    *
FROM
    employees   e
    FULL OUTER JOIN departments d ON e.department_id = d.department_id;

--SubQuery

SELECT
    first_name,
    salary
FROM
    employees
WHERE
    salary > (SELECT salary FROM employees WHERE first_name = 'Neena');

--View

CREATE VIEW E1 AS
    SELECT
        First_Name,
        Last_Name,
        Employee_Id,
        Salary
    FROM
        Employees;


CREATE VIEW E2 AS
    SELECT 
           E.First_Name, E.Last_Name, 
    From  
         Employees E, Departments D, Locations L
    Where
        E.Employee_id = D.Department_Id
    And
        D.Location_Id = L.Location_Id ;  

--Index

Create Index 
     ID on Employees(Employee_Id,Manager_Id);
    
--Sequence

Create SEQUENCE SEQ1
INCREMENT BY 1
START WITH 1
MAXVALUE 5;
