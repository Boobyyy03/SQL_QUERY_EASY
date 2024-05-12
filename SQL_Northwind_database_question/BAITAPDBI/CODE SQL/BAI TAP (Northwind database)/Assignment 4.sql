use Northwind

-- 1. Các product có đơn giá bán lớn hơn đơn giá bán trung bình của các product.
-- Thông tin gồm ProductID, ProductName, Unitprice (Bên bảng Order Details).
select ord.ProductID, pro.ProductName, ord.UnitPrice
from [Order Details] ord 
join Products pro on pro.ProductID = ord.ProductID
where ord.UnitPrice > (
select AVG(UnitPrice) 
from [Order Details])
group by ord.ProductID, pro.ProductName, ord.UnitPrice

-- 2. Các product có đơn giá bán lớn hơn đơn giá bán trung bình của các product có 
-- ProductName bắt đầu là 'N'
select ord.ProductID, pro.ProductName, ord.UnitPrice
from [Order Details] ord 
join Products pro on pro.ProductID = ord.ProductID
where ord.UnitPrice > (
select AVG(UnitPrice) from [Order Details])
and pro.ProductName like 'N%'
group by ord.ProductID, pro.ProductName, ord.UnitPrice 

-- 3. Cho biết những sản phẩm có tên bắt đầu bằng chữ N và đơn giá bán > đơn giá bán của sản phẩm khác
select pro.ProductID, pro.ProductName, ord.UnitPrice, pro.UnitPrice
from Products pro 
join [Order Details] ord on ord.ProductID = pro.ProductID
where pro.ProductName like 'N%'
and ord.UnitPrice > (select MAX(UnitPrice) 
from [Order Details])
group by pro.ProductID, pro.ProductName, ord.UnitPrice, pro.UnitPrice

-- 4. Danh sách các products đã có khách hàng đặt hàng (tức là ProductId có trong Order Details). Thông tin bao gồm ProductId, ProductName, Unitprice
select pro.ProductID, pro.ProductName , ord.UnitPrice
from Products pro 
join [Order Details] ord on ord.ProductID = pro.ProductID
where pro.ProductID in 
(select ProductID from [Order Details])
group by pro.ProductID, pro.ProductName, ord.UnitPrice 

-- 5. Danh sách các products có đơn giá nhập lớn hơn đơn giá bán nhỏ nhất của tất cả các Products
select pro.ProductID, pro.ProductName, pro.UnitPrice
from Products pro 
join [Order Details] ord on ord.ProductID = pro.ProductID
where pro.UnitPrice > (select min(UnitPrice) 
from [Order Details])
group by pro.ProductID, pro.ProductName, pro.UnitPrice

-- 6. Danh sách các hóa đơn của những Customers mà Customers ở thành phố LonDon và Madrid.
select cus.CustomerID, cus.ContactName, cus.City, ord.OrderID
from Customers cus join Orders ord on ord.CustomerID = cus.CustomerID
where cus.City in ('Madrid','London')

-- 7. Danh sách các products có đơn vị tính có chữ Box và có đơn giá mua nhỏ hơn đơn giá bán trung bình của tất cả các Products.
select pro.ProductID, pro.ProductName, pro.QuantityPerUnit, details.UnitPrice
from Products pro join  [Order Details] details on details.ProductID = pro.ProductID
where pro.QuantityPerUnit like '%_box_%'
and details.UnitPrice < (select avg(UnitPrice) 
from Products)

-- 8. Danh sách các Products có số lượng (Quantity) bán được lớn nhất.
select pro.ProductID, pro.ProductName, ord.Quantity
from Products pro 
join [Order Details] ord on ord.ProductID = pro.ProductID
where ord.Quantity = (select max(Quantity) from [Order Details])
group by pro.ProductID, pro.ProductName, ord.Quantity

-- 9. Danh sách các Customer chưa từng lập hóa đơn (viết bằng ba cách: dùng NOT EXISTS, dùng LEFT JOIN, dùng NOT IN )
--Cách 1 : 
select cus.CustomerID, cus.ContactName 
from Customers cus 
where cus.CustomerID not in (
select od.CustomerID 
from Orders od )

--Cách 2 :
select cus.CustomerID, cus.ContactName 
from Customers cus 
where not exists (
select ord.CustomerID
from Orders ord 
where cus.CustomerID = ord.CustomerID)

--Cách 3 : 
select cus.CustomerID, cus.ContactName , od.CustomerID as CustomerIDOnOrder
from Customers cus 
left join Orders od on od.CustomerID = cus.CustomerID
where od.CustomerID is null

-- 10.Cho biết các sản phẩm có đơn vị tính có chứa chữ box và có đơn giá bán cao nhất.
select pro.ProductID, pro.ProductName 
from Products pro 
where pro.QuantityPerUnit like '%_box_%'
and pro.UnitPrice = (
select max(UnitPrice) 
from [Order Details])

-- 11. Danh sách các products có đơn giá bán lớn hơn đơn giá bán trung bình của các Products có ProductId<=5.
select pro.ProductID, pro.ProductName, ord.UnitPrice
from Products pro 
join [Order Details] ord on ord.ProductID = pro.ProductID
where pro.ProductID <= 5 
and ord.UnitPrice <= (select avg(UnitPrice) from [Order Details]) 
group by pro.ProductID, pro.ProductName, ord.UnitPrice

-- 12.Cho biết những sản phẩm nào có tổng số lượng bán được lớn hơn số lượng  trung bình bán ra.
select pro.ProductID, pro.ProductName, sum(ord.Quantity) as SumQuantity
from Products pro 
join [Order Details] ord on ord.ProductID = pro.ProductID
group by pro.ProductID, pro.ProductName
having sum(ord.Quantity) > (select avg(Quantity)
from [Order Details])
order by pro.ProductID

-- 13.Liệt kê danh sách các khách hàng mua các hóa đơn mà các hóa đơn này chỉ mua những sản phẩm có mã >=3
select cus.CustomerID, cus.ContactName, od.OrderID, pro.ProductID
from Customers cus 
join Orders od on od.CustomerID = cus.CustomerID
join [Order Details] ord on ord.OrderID = od.OrderID
join Products pro on pro.ProductID = ord.ProductID
where pro.ProductID >= 3 
group by cus.CustomerID, cus.ContactName, pro.ProductID, od.OrderID

-- 14.Liệt kê các sản phẩm có trên 20 đơn hàng trong quí 3 năm 1998, thông tin gồm [ProductID], [ProductName]
select pro.ProductID, pro.ProductName
from Products pro 
join [Order Details] ord on ord.ProductID = pro.ProductID
join Orders od on od.OrderID = ord.OrderID
where year(od.OrderDate) = 1998 and month(od.OrderDate) in (7,8,9)
group by pro.ProductID, pro.ProductName
having count(od.OrderID) > 20 

-- 15.Liệt kê danh sách các sản phẩm Producrs chưa bán được trong tháng 6 năm 1996
select pro.ProductID, pro.ProductName, od.OrderDate
from Products pro 
join [Order Details] ord on ord.ProductID = pro.ProductID
join Orders od on od.OrderID = ord.OrderID
where pro.ProductID not in 
(select ProductID from [Order Details])
and year(od.OrderDate) = 1996
and month(od.OrderDate) = 6
order by month(od.OrderDate)

-- 16.Liệt kê danh sách các Employes không lập hóa đơn vào ngày hôm nay.
select emp.EmployeeID, concat(emp.FirstName,' ',emp.LastName) as EmployeeName
from Employees emp
join Orders od on od.EmployeeID = emp.EmployeeID 
where od.OrderDate != getdate()
group by emp.EmployeeID, emp.LastName, emp.FirstName
order by emp.EmployeeID

-- 17.Liệt kê danh sách các Customers chưa mua hàng trong năm 1997
select cus.CustomerID, cus.ContactName
from Customers cus 
where cus.CustomerID not in (select CustomerID from Orders where year(OrderDate) = 1997)

-- 18.Tìm tất cả các Customers mua các sản phẩm có tên bắt đầu bằng chữ T trong tháng 7.
select cus.CustomerID, cus.ContactName, pro.ProductName, od.OrderDate
from Customers cus 
join Orders od on od.CustomerID = cus.CustomerID
join [Order Details] ord on ord.OrderID = od.OrderID
join Products pro on pro.ProductID = ord.ProductID
where pro.ProductName like 'T%' and month(od.OrderDate) = 7

-- 19. Danh sách các City có nhiều hơn 3 customer.
select cus.City, count(cus.CustomerID) as SumCustomer
from Customers cus group by cus.City
having count(cus.CustomerID) > 3 

-- 20. Bạn hãy đưa ra câu hỏi cho 3 câu truy vấn sau và cho biết sự khác nhau của 3 câu truy vấn này:
Select ProductId, ProductName, UnitPrice from [Products]
Where Unitprice > ALL (
Select Unitprice from [Products] where 
ProductName like 'B%')

Select ProductId, ProductName, UnitPrice from [Products]
Where Unitprice > ANY (
Select Unitprice from [Products] where 
ProductName like 'B%')

Select ProductId, ProductName, UnitPrice from [Products]
Where Unitprice = ANY  ( 
Select Unitprice from [Products] where 
ProductName like 'B%') 

--Sự khác nhau của ba câu truy vấn này là:
-- Câu truy vấn thứ nhất (Unitprice > ALL) trả về các sản phẩm có giá UnitPrice cao hơn tất cả các sản phẩm có tên bắt đầu bằng chữ 'B'.
-- Nó chỉ trả về các sản phẩm có giá cao hơn tất cả các sản phẩm khác.
-- Câu truy vấn thứ hai (Unitprice > ANY) trả về các sản phẩm có giá UnitPrice cao hơn ít nhất một sản phẩm có tên bắt đầu bằng chữ 'B'.
-- Nó trả về các sản phẩm có giá cao hơn một số sản phẩm khác hoặc có thể chỉ là một sản phẩm.
-- Câu truy vấn thứ ba (Unitprice = ANY) trả về các sản phẩm có giá UnitPrice bằng với một trong các sản phẩm có tên bắt đầu bằng chữ 'B'. 
-- Nó trả về các sản phẩm có giá bằng với một số sản phẩm khác hoặc có thể chỉ là một sản phẩm.