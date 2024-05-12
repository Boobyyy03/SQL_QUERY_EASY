
create table Departments (
	depID varchar(20) primary key,
	name nvarchar(200),
	office nvarchar(100) 

)

create table Employees (
	empcode varchar(20) primary key,
	name nvarchar(50),
	birthdate date,
	depID varchar(20)
)

create table Dependants (
	number int,
	empcode varchar(20),  
	name nvarchar(50),
	birthdate date,
	role nvarchar(30),
	primary key (number  , empcode )
)
alter table Employees 
add foreign key (depID)
references Departments (depID) 

alter table Dependants 
add foreign key (empcode)
references Employees (empcode)

drop table Departments