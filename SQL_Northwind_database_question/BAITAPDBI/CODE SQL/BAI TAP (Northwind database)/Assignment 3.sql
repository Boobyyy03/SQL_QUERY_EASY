use Northwind

--1. Liệt kê các customer lập hóa đơn trong tháng 7/1997. Thông tin gồm 
--CustomerID, CompanyName, Address, OrderID, Orderdate. Được sắp xếp theo 
--Customerid, cùng CustomerID thì sắp xếp theo OrderDate giảm dần.
select ord.CustomerID,cs.CompanyName,cs.Address,ord.OrderID,ord.OrderDate
from Customers cs  join Orders ord on cs.CustomerID = ord.CustomerID
where month(ord.OrderDate) = 7 and year(ord.OrderDate) = 1997
order by ord.CustomerID asc,
ord.OrderDate desc

--2. Liệt kê các customer có lập hóa đơn trong 15 ngày đầu tiên của 1/1997
select ord.CustomerID,ord.OrderDate
from Customers cus join Orders ord on cus.CustomerID = ord.CustomerID
where month(ord.OrderDate) = 1 and year(ord.OrderDate) = 1997
and day(ord.OrderDate) <= 15

--3. Liệt kê danh sách các sản phẩm được giao vào ngày 16/7/1996
select ordt.ProductID, ord.OrderDate
from Products pro 
join [Order Details] ordt on pro.ProductID = ordt.ProductID
join Orders ord on ord.OrderID = ordt.OrderID
where day(ord.ShippedDate) = 16 
and month(ord.ShippedDate) = 7
and year(ord.ShippedDate) = 1996

--4. Liệt kê danh sách các hóa đơn của các Customers mua hàng trong tháng 4, 9 
--của năm 1997. Thông tin gồm Orderid, CompanyName, OrderDate, 
--RequiredDate, được sắp xếp theo CompanyName, cùng Companyname thì theo 
--OrderDate giảm dần.
select ord.OrderID,cus.CompanyName,ord.OrderDate,ord.RequiredDate
from Customers cus
join Orders ord on cus.CustomerID = ord.CustomerID
where month(ord.OrderDate) in (4,9) 
and year(ord.OrderDate) = 1997
order by cus.CompanyName asc,
ord.OrderDate desc

--5. Liệt kê danh sách các hóa đơn do nhân viên có Lastname là Fuller lập.
select emp.LastName,ord.OrderID
from Employees emp 
join Orders ord on emp.EmployeeID = ord.EmployeeID
where emp.LastName like 'Fuller'

--6. Liệt kê danh sách các Products do nhà cung cấp (supplier) có mã 1,3,6 bán 
--được trong tháng quý 2 của năm 1997, được sắp xếp theo mã nhà cung cấp 
--(SupplierID), cùng mã nhà cung cấp thì sắp xếp theo ProductID.
select pro.ProductID,pro.ProductName,sup.SupplierID
from Suppliers sup 
join Products pro on sup.SupplierID = pro.SupplierID
join [Order Details] ordt on pro.ProductID = ordt.ProductID
join Orders ord on ord.OrderID = ordt.OrderID
where month(ord.OrderDate) in (4,5,6) and year(ord.OrderDate) = 1997
and sup.SupplierID in (1,3,6)
group by sup.SupplierID,pro.ProductID,pro.ProductName
order by pro.ProductID


--7. Liệt kê danh sách các Products có đơn giá bán bằng đơn giá mua.
 select pro.ProductID,pro.ProductName ,(pro.UnitPrice) as N'Đơn giá mua', (ordt.UnitPrice) as N'Đơn giá bán'
 from Products pro 
 join [Order Details] ordt on pro.ProductID = ordt.ProductID
 where pro.UnitPrice = ordt.UnitPrice
 group by pro.ProductID,pro.ProductName,pro.UnitPrice,ordt.UnitPrice


--8. Liệt kê danh sách các Products mà hóa đơn có OrderID là 10248 đã mua.
select pro.ProductID,pro.ProductName,ordt.OrderID
from Products pro 
join [Order Details] ordt on pro.ProductID = ordt.ProductID
where ordt.OrderID = 10248

--9. Liệt kê danh sách các Employers đã lập các hóa đơn trong tháng 7 của năm 
--1996.
select emp.EmployeeID,concat(emp.LastName,' ',emp.FirstName) as N'Tên nhân viên',ord.OrderDate
from Employees emp 
join Orders ord on emp.EmployeeID = ord.EmployeeID
where month(ord.OrderDate) = 7 and year(ord.OrderDate) = 1996

--10.Danh sách các sản phẩm bán trong ngày thứ 7 và chủ nhật của tháng 12 năm 
--1996, thông tin gồm [ProductID], [ProductName], OrderID, OrderDate, 
--CustomerID, Unitprice, Quantity, ToTal= Quantity*UnitPrice. Được sắp xếp 
--theo ProductID, cùng ProductID thì sắp xếp theo Quantity giảm dần.
select ordt.ProductID,pro.ProductName,ord.OrderID, ord.OrderDate,
ord.CustomerID,ordt.UnitPrice,ordt.Quantity,(ordt.Quantity*ordt.UnitPrice) as Total
from Products pro 
join [Order Details] ordt on pro.ProductID = ordt.ProductID
join Orders ord on ordt.OrderID = ord.OrderID
where Datepart(dw,ord.OrderDate) in (6,7) and year(ord.OrderDate) = 1996
and month(ord.OrderDate) = 12
group by ordt.ProductID,pro.ProductName,ord.OrderID, ord.OrderDate,ord.CustomerID,ordt.UnitPrice,ordt.Quantity
order by ordt.ProductID asc,
ordt.Quantity desc

--11.Liệt kê bảng doanh thu của mỗi nhân viên theo từng hóa đơn trong năm 1996 
--gồm EmployeeID, EmployName, OrderID, Orderdate, Productid, quantity, 
--unitprice, ToTal=quantity*unitprice. 
select emp.EmployeeID,concat(emp.Lastname,' ',emp.FirstName) as Name, ord.OrderID,ord.OrderDate,
pro.ProductID,ordt.Quantity,ordt.UnitPrice,(ordt.Quantity*ordt.UnitPrice) as Total
from Employees emp 
join Orders ord on emp.EmployeeID = ord.EmployeeID
join [Order Details] ordt on ord.OrderID = ordt.OrderID
join Products pro on ordt.ProductID = pro.ProductID
where year(ord.OrderDate) = 1996

--12.Danh sách các đơn hàng sẽ được giao trong các thứ 7 của tháng 12 năm 1996. 
select ord.OrderID,ord.OrderDate
from Orders ord
where Datepart(dw,ord.ShippedDate) = 6 and month(ord.ShippedDate) = 12
and year(ord.ShippedDate) = 1996

--13.Liệt kê danh sách các nhân viên chưa lập hóa đơn (dùng LEFT JOIN/RIGHT 
--JOIN).
select *
from Orders ord 
right join Employees emp on ord.EmployeeID = emp.EmployeeID
where emp.EmployeeID not in (select ord.EmployeeID
from Orders ord)

--14.Liệt kê danh sách các sản phẩm chưa bán được (dùng LEFT JOIN/RIGHT 
--JOIN).
select *
from Products pro 
left join [Order Details] ordt on pro.ProductID = ordt.ProductID
where pro.ProductID  not in (
select ordt.ProductID
from [Order Details] ordt)

--15.Liệt kê danh sách các khách hàng chưa mua hàng lần nào (dùng LEFT 
--JOIN/RIGHT JOIN).
select *
from Customers cus 
left join Orders ord on cus.CustomerID = ord.CustomerID
where cus.CustomerID not in (select ord.CustomerID
from Orders ord)
