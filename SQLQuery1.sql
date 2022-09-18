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

