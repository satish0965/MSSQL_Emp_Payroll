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


