

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
add foreign key (itemID)
references items (itemID)

alter table items
add foreign key (catID) 
references categories (catID)

DROP TABLE items 