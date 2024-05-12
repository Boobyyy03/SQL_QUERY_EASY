
create table logins (
	username nvarchar(50) primary key,
	password nvarchar(255),
	role nvarchar(100), 
	staffID int 
)

create table staffs (
	staffID int primary key,
	name nvarchar(100)
)

create table Reports (
	ReportNumber int primary key,
	date date ,
	issueReturn nvarchar(200),
	username nvarchar(50)
)
alter table logins 
add foreign key (staffID) 
references staffs (staffID)

alter table Reports 
add foreign key (username)
references logins (username)