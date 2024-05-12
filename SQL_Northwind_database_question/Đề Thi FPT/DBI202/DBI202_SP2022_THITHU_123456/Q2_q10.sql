
--question 2
select *
from ProductSubcategory
where Category like 'Accessories' 

--question 3

select p.ProductID , p.Name , p.Color , p.Cost , p.Price , p.SellEndDate 
from Product p
where p.SellEndDate >= 100 and p.cost <= 100
order by p.Cost asc 

--question 4
select p.ProductID, p.Name as ProductName , p.Price,
pm.Name as ModelName , ps.SubcategoryID , ps.Category 
from ProductSubcategory ps 
 right join Product p on p.SubcategoryID = ps.SubcategoryID 
 left join ProductModel pm on pm.ModelID = p.ModelID 
where p.Price < 100 and p.Color like 'Black' 

-- question 5 
select ps.SubcategoryID , ps.Name as SubCategoryName, ps.Category,
count(p.ProductID) as NumberOfProducts 
from ProductSubcategory ps join 
Product p on p.SubcategoryID = ps.SubcategoryID
group by ps.SubcategoryID , ps.Name , ps.Category
order by ps.Category asc , NumberOfProducts desc, SubCategoryName asc 

--question 6 (1 bang duy nhat )
with t as  (
select loc.LocationID , loc.Name as LocationName, count(distinct p.ProductID)
as NumberOfProducts 
from Location loc  
join ProductInventory p on p.LocationID = loc.LocationID 
group by loc.LocationID,  loc.Name )

select * from t 
where t.NumberOfProducts = (select min(NumberOfProducts) from t)

--question 7 
WITH TempCount AS
(
	SELECT s.Category, s.Name AS SubCategoryName, COUNT(DISTINCT p.ProductID) AS NumberOfProducts FROM ProductSubcategory s
	JOIN Product p
	ON s.SubcategoryID = p.SubcategoryID
	GROUP BY s.Category, s.Name
)
,TempMax AS
(
	SELECT Category, MAX(NumberOfProducts) AS NumberOfProducts FROM TempCount
	GROUP BY Category
)

SELECT t.* FROM TempCount t
JOIN TempMax m
ON t.Category = m.Category AND t.NumberOfProducts = m.NumberOfProducts
ORDER BY NumberOfProducts DESC

--question 8

create proc proc_product_model (@modelID int ,
@numberOfProducts int output) as 
begin 
SELECT @numberOfProducts = count(p.ProductID) 
from ProductModel pm 
join Product p on p.ModelID = pm.ModelID 
where @modelID = p.ModelID 
end 

declare @x int 
exec proc_product_model 9 , @x output 
select @x as NumberOfProducts

drop proc proc_product_model 

-- question 9 
create trigger tr_insert_Product on Product after insert as 
begin 
	select p.ProductID , p.Name as ProductName ,pm.ModelID , pm.Name as ModelName
	from inserted p left join ProductModel pm on p.ModelID = p.ModelID 
end 

insert into Product(ProductID, Name, Cost, Price, ModelID, SellStartDate )
values (1000,'Product Test' , 12.5,15.5,1,'2021-10-15')

drop trigger tr_insert_Product


--question 10 


delete from ProductInventory 
where exists (
select * from Product p 
where p.ModelID = 33 
and ProductID = ProductInventory.ProductID )