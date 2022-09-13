--UC1-- Create Database
create database payroll_service;
use payroll_service;

--UC2--Create Table employee_payroll
create table employee_payroll(Id int identity (1,1) primary key,Name varchar(200),Salary bigint ,StartDate date)


