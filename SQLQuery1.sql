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

