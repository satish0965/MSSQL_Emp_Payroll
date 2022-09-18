--UC1-- Create Database
create database payroll_service;
use payroll_service;

--UC2--Create Table employee_payroll
create table employee_payroll (Id int identity (1,1) primary key,Name varchar(200),Salary bigint ,StartDate date)

--UC3-- Create employee_payroll data
insert into employee_payroll (Name, Salary, StartDate) values
('Satish', 70000.00, '2007-02-03'),
('Amit', 50000.00, '2010-05-04'),
('Pritish', 60000.00, '2009-06-09'),
('Swapnil', 40000.00, '2018-03-05'),
('Morison', 50000.00, '2020-08-02');

--UC4-- Retrieve employee_payroll data
select * from employee_payroll;

--UC5-- Retrieve salary of particular employee and particular date range
select salary from employee_payroll where Name = 'Pritish';
select * from employee_payroll where StartDate between cast ('2018-01-01' as date) and GETDATE();

--UC6-- add Gender to Employee_Payroll Table and Update the Rows to reflect the correct Employee Gender
alter table employee_payroll add Gender char(1);
update employee_payroll set Gender = 'M' where Id in (1,2,3);
update employee_payroll set Gender = 'F' where Id in (4,5);

--UC7-- find sum, average, min, max and number of male and female employees
select sum(Salary) as sumsalary,Gender from employee_payroll group by Gender;
select avg(Salary) as avgsalary,Gender from employee_payroll group by Gender; 
select max(Salary) as maxsalary,Gender from employee_payroll group by Gender; 
select min(Salary) as minsalary,Gender from employee_payroll group by Gender; 
select count(Name) as EmployeeCount,Gender from employee_payroll group by Gender;

--UC8-- add employee phone, department(not null), Address (using default values)
select * from employee_payroll;
alter table employee_payroll add Phone bigint;
update employee_payroll set Phone = 976543210; 
update employee_payroll set Phone = 9638527410 where ID IN (2,4); 
alter table employee_payroll add Address varchar(100) not null default 'Mumbai';
alter table employee_payroll add Department varchar(250) default 'IT';

--UC9-- Extend table to have Basic Pay, Deductions, Taxable Pay, Income Tax, Net Pay.
exec sp_rename 'employee_payroll.salary','Basic_pay','column';
alter table employee_payroll add 
Deductions float not null default 0.00,
Taxable_Pay float not null default 0.00, 
Income_Tax float not null default 0.00,
Net_Pay float not null default 0.00;
update employee_payroll set Net_Pay = (Basic_Pay-Deductions-Taxable_Pay-Income_Tax);
select * from employee_payroll;

--UC10-- Two departments for same employee
insert into employee_payroll (Name, Basic_pay, StartDate, Gender, Phone, Address, Department, Deductions, Taxable_Pay, Income_Tax,Net_pay)
values ('Pritish', 60000.00, '2011-05-05', 'M', 7894561230, 'Mumbai', 'TCS',1000.00, 59000.00, 2000.00);
update employee_payroll set Net_Pay = (Basic_Pay-Deductions-Taxable_Pay-Income_Tax);

-------UC11 - NOrmalization and ER Diagram ----------------

create table Company
(compId INT PRIMARY KEY, compName varchar(20));

SELECT* from Company

create table employee
(empId int PRIMARY KEY,Name varchar(20),compId INT REFERENCES Company(compId) ,Phone varchar(20),Address varchar(200),Gender char);

select* from employee

create Table payroll
(empId INT REFERENCES employee(empId), BasicPay decimal,Deduction decimal, TaxablePay decimal ,IncomeTax decimal,NetPay decimal);

select* from payroll

CREATE TABLE DEPARTMENT(
DeptName VARCHAR(10),
empId INT REFERENCES employee(empId),
deptId int PRIMARY KEY);

select* from DEPARTMENT;

-------------Inserting values into Company table---------------------------------
Insert Into Company Values (1,'Capgemini');
Insert Into Company Values (2,'TCS');
Insert Into Company Values (3,'Infosys');
Insert Into Company Values (4,'Amazon');

SELECT* from Company

-------------Inserting values into employee table---------------------------------
Insert Into employee Values (19,'Ronit',1,'1234567891','Virar,Palghar','M');
Insert Into employee Values (20,'Aakanksha',2,'1234567892','Vasai,Palghar','F');
Insert Into employee Values (24,'Hitanshi',4,'1234567890','Nallasopara,Thane','F');
Insert Into employee Values (23,'Hitansh',3,'1234567898','Vasai,Thane','M');

select* from employee

-------------Inserting values into DEPARTMENT table---------------------------------
Insert Into DEPARTMENT Values ('Developer',19,04);
Insert Into DEPARTMENT Values ('HR',23,08);
Insert Into DEPARTMENT Values ('Sales',24,19);
Insert Into DEPARTMENT Values ('Marketing',20,13);

select* from DEPARTMENT;
-------------Inserting values into payroll table---------------------------------
Insert Into payroll Values (19,30000,1500,240,300,28500);
Insert Into payroll Values (20,35000,1500,240,300,33500);
Insert Into payroll Values (23,40000,1500,240,300,38500);
Insert Into payroll Values (24,45000,1500,240,300,43500);

select* from payroll;



-----------UC12-Ensuring All retrieve queries from UC6 to UC10 with new table---------
------------Retreive_UC_4-Ability to Retrive Values From Employee_payroll Table in dataBase------------------
select company.compId,company.compName,
  Employee.empId,Employee.Name,Employee.Phone,Employee.Address,Employee.Gender,
  Payroll.BasicPay,Payroll.Deduction,Payroll.TaxablePay,Payroll.IncomeTax,Payroll.NetPay,
  department.DeptName,department.deptId 
from Company as company
left Join employee as Employee on company.compId = Employee.compId
left Join payroll as Payroll on Payroll.empId = Employee.empId
left Join DEPARTMENT as department on department.empId = Payroll.empId;
------------Retreive_UC_5-Ability to Retrive Salry of a Particular Employee From Employee_payroll Table in dataBase------------------
select company.compId,company.compName,
  Employee.empId,Employee.Name,Employee.Phone,Employee.Address,Employee.Gender,
  Payroll.BasicPay,Payroll.Deduction,Payroll.TaxablePay,Payroll.IncomeTax,Payroll.NetPay,
  department.DeptName,department.deptId
from Company as company
left Join employee as Employee on company.compId = Employee.compId
left Join payroll as Payroll on Payroll.empId = Employee.empId
left Join DEPARTMENT as department on department.empId = Payroll.empId
where (payroll.BasicPay=30000);

------------UC_7-Ability to Find SUM,Avg,Min,Max,Count From Employee_payroll Table in dataBase------------------


select sum(Payroll.BasicPay)as p
from Company as company
left Join employee as Employee on company.compId = Employee.compId
left Join payroll as Payroll on Payroll.empId = Employee.empId
left Join DEPARTMENT as department on department.empId = Payroll.empId;

select Avg(Payroll.BasicPay)as p
from Company as company
left Join employee as Employee on company.compId = Employee.compId
left Join payroll as Payroll on Payroll.empId = Employee.empId
left Join DEPARTMENT as department on department.empId = Payroll.empId;

select Min(Payroll.BasicPay)as p
from Company as company
left Join employee as Employee on company.compId = Employee.compId
left Join payroll as Payroll on Payroll.empId = Employee.empId
left Join DEPARTMENT as department on department.empId = Payroll.empId;

select Max(Payroll.BasicPay)as p
from Company as company
left Join employee as Employee on company.compId = Employee.compId
left Join payroll as Payroll on Payroll.empId = Employee.empId
left Join DEPARTMENT as department on department.empId = Payroll.empId

select Count(*)as p
from Company as company
left Join employee as Employee on company.compId = Employee.compId
left Join payroll as Payroll on Payroll.empId = Employee.empId
left Join DEPARTMENT as department on department.empId = Payroll.empId
