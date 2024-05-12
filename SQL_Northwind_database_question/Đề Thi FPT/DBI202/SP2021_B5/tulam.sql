

create table itemVariants (
	varianID int primary key ,
	detail nvarchar(200),
	color nvarchar(50),
	size nvarchar(30),
	itemID int 
)

create table items (
	itemID int primary key,
	name nvarchar(255),
	price float,
	catID int
)

create table categories(
	catID int primary key ,
	name nvarchar(255)	
)
alter table itemVariants 
add foreign key (iteaID)
references items (itemID)

alter table 
add foreign key (catID) 
references categories (catID)

DROP TABLE items
--question 2 
select *
from Employees 
where salary > 9000

--question 3
select jb.JobID , jb.JobTitle , jb.min_salary 
from Jobs jb 
where jb.min_salary > 5000 and jb.JobTitle like '%Manager%'
order by jb.min_salary desc , jb.JobTitle desc 

--question 4
select emp.EmployeeID , emp.FirstName , emp.LastName, emp.Salary, dep.DepartmentName 
, loc.StateProvince , loc.CountryID 
from Employees emp 
join Departments dep on dep.DepartmentID = emp.DepartmentID
join Locations loc on loc.LocationID = dep.LocationID
where emp.Salary > 3000 and loc.StateProvince like 'Washington' and loc.CountryID like 'US'

--question 5

select loc.LocationID, loc.StreetAddress, loc.City , loc.StateProvince ,
loc.CountryID, count(dep.DepartmentID) AS NumberOfDepartments 
from Locations loc 
left join Departments dep on dep.LocationID = loc.LocationID
group by loc.LocationID, loc.StreetAddress, loc.City , loc.StateProvince ,
loc.CountryID
order by NumberOfDepartments desc , LOC.LocationID desc

-- question 6
with t as (
select j.JobID , j.JobTitle , count(emp.EmployeeID) as NumberOfEmployees 
from Jobs j 
left join Employees emp on emp.JobID = j.JobID 
group by j.JobID , j.JobTitle 
)
select * from t
where NumberOfEmployees = (select MAX(NumberOfEmployees) from t)
	

--QUESTION 7


--question 8
create procedure pr1  
( @countryID varchar(10),
@numberOfDepartments int output ) as
begin 
	select @numberOfDepartments = count(*) 
	from Departments dep join Locations loc on loc.LocationID = dep.LocationID  
	where loc.CountryID = @countryID 
end 

declare @x int 
exec pr1 'US' , @x output 
select @x as NumberOfDepartments 
drop procedure pr1 

-- question 9 
create trigger Tr1 on Employees after insert as
begin 
	select e.EmployeeID , e.FirstName, e.LastName, dep.DepartmentID, dep.DepartmentName
	from inserted e 
	left join Departments dep on dep.ManagerID = e.ManagerID
end 

-- question 10 
delete from Departments 
where not exists (
	select * from Employees 
	where Employees.DepartmentID = Departments.DepartmentID )
	
