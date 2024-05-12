use Northwind 


--1.	Liệt kê thông tin của tất cả các sản phẩm (Products) 
select *
from Products

--2.Liệt kê danh sách các khách hàng (Customers). Thông tin bao gồm CustomerID, CompanyName, City, Phone. 
select  CustomerID, CompanyName, City, Phone 
from Customers

--3.	Liệt kê danh sách các sản phẩm (Products). Thông tin bao gồm ProductId, ProductName, UnitPrice. 
select ProductId, ProductName, UnitPrice
from Products

--4.	Liệt kê danh sách các nhân viên (Employees). Thông tin bao gồm EmployeeId, EmployeeName, Phone, Age.
-- Trong đó EmployeeName được ghép từ LastName và FirstName; Age là tuổi được tính từ năm hiện hành (GetDate()) và năm của Birthdate. 

SELECT EmployeeId, LastName + FirstName AS NAME , HomePhone as Phone, year(getdate()) - YEAR(BirthDate) as Age 
from Employees

--5.	Liệt kê danh sách các khách hàng (Customers) có ContactTitle bắt đầu bằng chữ O 
SELECT CustomerID,ContactName, ContactTitle
FROM Customers
where ContactTitle LIKE 'O%'

--6.	Liệt kê danh sách khách hàng (Customers) ở thành phố LonDon, Boise và Paris 
SELECT CustomerID, ContactName, City
FROM Customers 
WHERE city in (N'LonDon' , N'Boise' , N'Paris')

--7.	Liệt kê danh sách khách hàng (Customers) có tên bắt đầu bằng chữ V mà ở thành phố Lyon 
select CompanyName, city
from Customers 
where CompanyName like 'V%' and city = (N'Lyon')

--8.	Liệt kê danh sách các khách hàng (Customers) không có số fax 
select CustomerID, ContactName, fax
from Customers 
where fax IS null

--9.	Liệt kê danh sách các khách hàng (Customers) có số Fax 
select CustomerID,ContactName
from Customers 
where fax IS not null

--10.	Liệt kê danh sách nhân viên (Employees) có năm sinh <=1960. 
select EmployeeID, CONCAT(FirstName,' ',LastName) as EmployeeName, year(Birthdate)
from Employees
where year(BirthDate) <= 1960

--11.	Liệt kê danh sách các sản phẩm (Products) có từ ‘Boxes’ trong cột QuantityPerUnit.
SELECT ProductID,  ProductName, QuantityPerUnit
from Products 
WHERE QuantityPerUnit like '%Boxes%'

--12.	Liệt kê danh sách các sản phẩm (Products) có Unitprice lớn hớn 10 và nhỏ hơn 15.
select ProductName, UnitPrice
from Products 
where UnitPrice > 10 and UnitPrice < 15

--13.	Liệt kê danh sách các hóa đơn (orders) có OrderDate được lập trong tháng 9 năm 1996. 
--      Được sắp xếp theo mã khách hàng, cùng mã khách hàng sắp xếp theo ngày lập hóa đơn giảm dần. 
select CustomerID, OrderID, OrderDate from Orders
where month(OrderDate) like 9 and year(OrderDate) like 1996
order by CustomerID ASC , day(OrderDate) DESC

--14.	Liệt kê danh sách các hóa đơn (Orders) được lập trong quý 4 năm 1997.
--      Thông tin gồm OrderID, OrderDate, Customerid, EmployeeID. Được sắp xếp theo tháng của ngày lập hóa đơn. 
select OrderID, CustomerID, OrderDate, EmployeeID from Orders 
where month(OrderDate) in ('10','11','12') 
order by month(OrderDate)

--15.	Liệt kê danh sách các hóa đơn (Orders) được lập trong trong ngày thứ 7 và chủ nhật của tháng 12 năm 1997.
-- Thông tin gồm OrderID, OrderDate, Customerid, EmployeeID, WeekDayOfOrdate (Ngày thứ mấy trong tuần). 
select OrderID, OrderDate, CustomerID, EmployeeID, DATENAME(dw,OrderDate) as WeekDayOfOrDate 
from Orders
where year(OrderDate) = 1997 and month(OrderDate) = 12 and DATENAME(dw,OrderDate) in ('Saturday','Sunday')

--16.	Liệt kê danh sách các sản phẩm (Products) ứng với tiền tồn vốn. 
--Thông tin bao gồm ProductId, ProductName, Unitprice, UnitsInStock, TotalAccount. Trong đó TotalAccount= UnitsInStock * Unitprice. 
-- Được sắp xếp theo TotalAcount giảm dần. 
select ProductID, ProductName, Unitprice, UnitsInStock, UnitsInStock * Unitprice as TotalAccount 
from Products
order by TotalAccount desc

--17.	Liệt kê danh sách 5 customers có city bắt đầu ‘M’. 
select top 5 CustomerID, ContactName, City from Customers 
where City like 'M%'

--18.	Liệt kê danh sách 2 employees có tuổi lớn nhất. Thông tin bao gồm EmployeeID, EmployeeName, Age. Trong đó, EmployeeName được ghép từ LastName và FirstName; Age là năm hiện hành trừ năm sinh. 
select top 2 EmployeeID, concat(LastName,' ',FirstName) as EmployeeName, year(getdate()) - year(BirthDate) as Age 
from Employees

--19.	Liệt kê danh sách các Products có số lượng tồn nhỏ hơn 5. 
select ProductID, ProductName, UnitsInStock from Products 
where UnitsInStock < 5

--20.	Liệt kê danh sách các Orders gồm OrderId, Productid, Quantity, Unitprice, Discount, ToTal = Quantity * unitPrice – 20%*Discount. 
select OrderID, ProductID, Quantity, UnitPrice, Quantity * UnitPrice - 20/100 * Discount as Total from [Order Details]
