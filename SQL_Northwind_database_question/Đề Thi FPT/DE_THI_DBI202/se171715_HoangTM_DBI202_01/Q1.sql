
create table tblStudents (
	stid nchar(7) primary key,
	name nvarchar(25),
	bitrthday date,
	phone nvarchar(15)
)

create table Result_tblStudents_tblSubjects(
	stid nchar(7),
	subid nchar(6),
	score01 float,
	score02 float,
	primary key (stid , subid)
)

create table tblSubjects (
	subid nchar(6) primary key ,
	subname nvarchar(50),
	unit int
)

alter table  Result_tblStudents_tblSubjects 
add foreign key (stid)
references tblStudents (stid)

alter table  Result_tblStudents_tblSubjects
add foreign key (subid)
references  tblSubjects (subid)


