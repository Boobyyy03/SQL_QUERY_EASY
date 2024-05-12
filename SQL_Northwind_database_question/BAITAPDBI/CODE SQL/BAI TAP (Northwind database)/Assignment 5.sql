use Northwind 
--1. Tạo view vw_Products_Info hiển thị danh sách các sản phẩm từ bảng Products 
--và bảng Categories. Thông tin bao gồm CategoryName, Description, 
--ProductName, QuantityPerUnit, UnitPrice, UnitsInStock.
go
create view vw_Products_Info as
select cat.CategoryName, cat.Description, pro.ProductName, pro.QuantityPerUnit, pro.UnitPrice, pro.UnitsInStock
from Products pro join Categories cat on cat.CategoryID = pro.CategoryID 
go

select *
from vw_Products_Info
--2. Tạo view List_Product_view chứa danh sách các sản phẩm dạng hộp (box) có 
--đơn giá > 16, thông tin gồm ProductID, ProductName, UnitPrice, 
--QuantityPerUnit, COUNT of OrderID
go
create view List_Product_view as 
select pro.ProductID , pro.ProductName , pro.UnitPrice, pro.QuantityPerUnit, count(ord.orderID) as OrderCount 
from Products pro join [Order Details] ord on pro.ProductID = ord.ProductID 
where pro.QuantityPerUnit like '%box%' and pro.UnitPrice > 16 
group by  pro.ProductID , pro.ProductName , pro.UnitPrice, pro.QuantityPerUnit
go
 
--3. Tạo view vw_CustomerTotals hiển thị tổng tiền bán được từ mỗi khách hàng 
--theo tháng và theo năm. Thông tin gồm CustomerID, YEAR(OrderDate) AS 
--OrderYear, MONTH(OrderDate) AS OrderMonth, SUM(UnitPrice*Quantity).
--Xem lại cú pháp lệnh tạo view này.
go
create view vw_CustomerTotals as
select Orders.CustomerID,
YEAR(Orders.OrderDate) as OrderYear,
MONTH(Orders.OrderDate) as OrderMonth,
SUM([Order Details].UnitPrice * [Order Details].Quantity) as TotalSales
from Orders
join [Order Details] on Orders.OrderID = [Order Details].OrderID
group by Orders.CustomerID, YEAR(Orders.OrderDate), MONTH(Orders.OrderDate);
go

select *
from vw_CustomerTotals

--4. Tạo view trả về tổng số lượng sản phẩm bán được của mỗi nhân viên 
--(Employee) theo từng năm. Thông tin gồm EmployeeID, OrderYear, 
--sumOfOrderQuantity. Yêu cầu sau khi tạo view, người dùng không xem được 
--cú pháp lệnh đã tạo view này.
go 
create view vw_employeesales as
select 
EmployeeID,
YEAR(OrderDate) as OrderYear,
SUM(Quantity) as sumOfOrderQuantity
from Orders
join [Order Details] on Orders.OrderID = [Order Details].OrderID
group by EmployeeID, YEAR(OrderDate)
go

select *
from vw_employeesales

--5. Tạo view ListCustomer_view chứa danh sách các khách hàng có trên 5 hóa đơn 
--đặt hàng từ năm 1997 đến 1998, thông tin gồm mã khách (CustomerID) , họ tên 
--(CompanyName), Số hóa đơn (CountOfOrders).
go
create view ListCustomer_view as 
select 
Customers.CustomerID,
Customers.CompanyName,
COUNT(Orders.OrderID) as CountOfOrders
from Customers
join Orders on Customers.CustomerID = Orders.CustomerID
where 
YEAR(Orders.OrderDate) between 1997 and 1998
group by Customers.CustomerID, Customers.CompanyName
having COUNT(Orders.OrderID) > 5;
go

select *
from ListCustomer_view

--6. Tạo view ListProduct_view chứa danh sách những sản phẩm nhóm Beverages 
--và Seafood có tổng số lượng bán trong mỗi năm trên 30 sản phẩm, thông tin 
--gồm CategoryName, ProductName, Year, SumOfOrderQuantity.
go
create view ListProduct_view  as
select
Categories.CategoryName,
Products.ProductName,
YEAR(Orders.OrderDate) as Year,
SUM([Order Details].Quantity) as SumOfOrderQuantity
from Categories
join Products on Categories.CategoryID = Products.CategoryID
join [Order Details] on Products.ProductID = [Order Details].ProductID
join Orders on [Order Details].OrderID = Orders.OrderID
where Categories.CategoryName IN ('Beverages', 'Seafood')
group by
Categories.CategoryName, Products.ProductName, YEAR(Orders.OrderDate)
having
SUM([Order Details].Quantity) > 30;
go

select *
from ListProduct_view 
--7. Tạo view vw_OrderSummary với từ khóa WITH ENCRYPTION gồm 
--OrderYear (năm của ngày lập hóa đơn), OrderMonth (tháng của ngày lập hóa 
--đơn), OrderTotal (tổng tiền, =UnitPrice*Quantity). Sau đó xem thông tin và trợ 
--giúp về mã lệnh của view này
go 
create view vw_OrderSummary WITH ENCRYPTION AS
select
YEAR(ord.OrderDate) as OrderYear,
MONTH(ord.OrderDate) as OrderMonth,
SUM(details.UnitPrice * details.Quantity) as OrderTotal
from Orders ord
join
[Order Details] details on Ord.OrderID = details.OrderID
group by
YEAR(ord.OrderDate),
MONTH(ord.OrderDate)
go 


select *
from vw_OrderSummary 
EXEC sp_helptext 'vw_OrderSummary'
drop view vw_OrderSummary 


--8. Tạo view vwProducts với từ khóa WITH SCHEMABINDING gồm ProductID, 
--ProductName, Discount. Xem thông tin của View. Xóa cột Discount. Có xóa 
--được không? Vì sao?
-- Tạo view vwProducts
go
create view vw_Products WITH SCHEMABINDING as
SELECT pro.ProductID, pro.ProductName, ord.Discount
FROM Products pro 
join [Order Details] ord on pro.ProductID = pro.ProductID 
go

select * from vw_Products
-- Xem thông tin của view vwProducts
DESCRIBE vw_Products;

-- Xóa cột Discount
-- Không xóa được cột Discount vì nó liên kết chặt chẽ với cấu trúc của bảng và các cột được sử dụng trong view. 
-- Việc xóa cột từ bảng hoặc view liên quan sẽ làm hỏng tính nhất quán và không cho phép xóa cột.

select *
from vw_Products
drop view vw_Products
------------------------
--9. Tạo view vw_Customer với với từ khóa WITH CHECK OPTION chỉ chứa các 
--khách hàng ở thành phố London và Madrid, thông tin gồm: CustomerID, 
--CompanyName, City.

go
create view vw_Customer
as
select cs.CustomerID,cs.CompanyName,cs.City
from Customers cs
where cs.City in ('London','Madrid')
with check option
go

--a. Chèn thêm một khách hàng mới không ở thành phố London và Madrid 
--thông qua view vừa tạo. Có chèn được không? Giải thích.
insert into vw_Customer values
('123456','Hoangchualamassignment','HoChiMinh')

--b. Chèn thêm một khách hàng mới ở thành phố London và một khách hàng 
--mới ở thành phố Madrid. Dùng câu lệnh select trên bảng Customers để 
--xem kết quả .
insert into vw_Customer values
('123123','Hoang','London')

select * from vw_Customer