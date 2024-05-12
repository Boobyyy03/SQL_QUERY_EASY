use Northwind 

--1. Danh sách các orders ứng với tổng tiền của từng hóa đơn. Thông tin bao gồm 
--OrdersId, OrderDate, TotalAccount. Trong đó TotalAccount là Sum của 
--Quantity * Unitprice, kết nhóm theo OrderId.

select ord.OrderID, ord.OrderDate , sum(detail.Quantity * detail.Unitprice) as TotalAccount
from Orders ord join [Order Details] detail on ord.OrderID = detail.OrderID 
group by ord.OrderID, ord.OrderDate

--2. Danh sách các orders ứng với tổng tiền của từng hóa đơn được lập ở thành phố 
--(Shipcity) là ‘Madrid’. Thông tin bao gồm OrdersId, OrderDate, TotalAccount. 
--Trong đó TotalAccount là Sum của Quantity * Unitprice, kết nhóm theo 
--OrderId.
select ord.OrderID , ord.OrderDate , sum(detail.Quantity * Unitprice) as TotalAccount, ord.ShipCity
from Orders ord join [Order Details] detail on ord.OrderID = detail.OrderID
group by ord.OrderID, ord.OrderDate , ord.ShipCity
having ord.ShipCity like N'%Madrid%'


--3. Danh sách các Products có tổng số lượng lập hóa đơn lớn nhất. Thông tin gồm 
--ProductID, ProductName, CountOfOrders.
select pd.ProductID, pd.ProductName, Count(ord.orderID) as CountOfOrders
from Products pd join [Order Details] ord on ord.ProductID = pd.ProductID
group by pd.ProductID, pd.ProductName
order by count(ord.orderID) DESC

--4. Cho biết mỗi customers đã lập bao nhiêu hóa đơn. Thông tin gồm CustomerID, 
--CompanyName, CountOfOrder. Trong đó CountOfOrder (tổng số hóa đơn) 
--được đếm (Count) theo từng Customers.
select cus.CustomerID , cus.CompanyName , count(ord.orderID)
from Customers cus join Orders ord on cus.CustomerID = ord.CustomerID
GROUP BY cus.CustomerID , cus.CompanyName 


--5. Cho biết mỗi Employee đã lập được bao nhiêu hóa đơn, ứng với tổng tiền.
select emp.EmployeeID , concat(FirstName,' ',LastName) as Employee , count(ord.OrderID) as N'Tổng Tiền'  
from Employees emp join Orders ord on emp.EmployeeID = ord.EmployeeID 
group by  emp.EmployeeID , concat(FirstName,' ',LastName) 

--6. Liệt kê bảng lương của mỗi nhân viên theo từng tháng trong năm 1996 gồm 
--EmployeeID, EmployName, Month_Salary, Salary = 
--sum(quantity*unitprice)*10%. Được sắp xếp theo Month_Salary, cùmg 
--Month_Salary thì sắp xếp theo Salary giảm dần.
select emp.EmployeeID , concat(emp.FirstName, ' ',emp.LastName) as EmployeeName, 
month(ord.orderDate) as Month_Salary , sum(details.quantity * unitprice) * 10/100 as SALARY 
from Employees emp 
join Orders ord on emp.EmployeeID = ord.EmployeeID 
join [Order Details] details on details.OrderID = ord.OrderID 
group by emp.EmployeeID , concat(emp.FirstName, ' ',emp.LastName), month(ord.orderDate)
order by sum(details.quantity * unitprice) * 10/100 desc 

--7. Danh sách các customer ứng với tổng tiền các hoá đơn, mà các hóa đơn được 
--lập từ 31/12/1996 đến 1/1/1998 và tổng tiền các hóa đơn >20000.
select cus.CustomerID ,  cus.ContactName,
SUM(details.Quantity * details.UnitPrice) AS TotalAmount
from Customers cus 
join Orders ord on cus.CustomerID = ord.CustomerID 
join [Order Details] details on details.OrderID = ord.OrderID 
where ord.OrderDate >= '1996-12-31' and ord.OrderDate <= '1998-01-01' 
group by cus.CustomerID ,  cus.ContactName 
having SUM(details.Quantity * details.UnitPrice) > 20000


--8. Danh sách các customer ứng với tổng số hoá đơn, tổng tiền các hoá đơn, mà 
--các hóa đơn được lập từ 31/12/1996 đến 1/1/1998 và tổng tiền các hóa đơn >20000
--Thông tin được sắp xếp theo CustomerID, cùng mã thì sắp xếp theo 
--tổng tiền giảm dần.
select
cus.CustomerID,
cus.ContactName,
count(ordetails.Quantity * ordetails.UnitPrice) as N'Tổng số hoá đơn',
sum(ordetails.Quantity * ordetails.UnitPrice) as N'Tổng tiền hoá đơn'
from Customers cus
join Orders ord on cus.CustomerID = ord.CustomerID
join [Order Details] ordetails on ord.OrderID = ordetails.OrderID
where ord.OrderDate >= '1996-12-31' and ord.OrderDate <= '1998-01-01' 
group by cus.CustomerID, cus.ContactName
having sum(ordetails.Quantity * ordetails.UnitPrice) > 20000
order by sum(ordetails.Quantity * ordetails.UnitPrice) desc

--9. Danh sách các Category có tổng số lượng tồn (UnitsInStock) lớn hơn 300, đơn 
--giá trung bình nhỏ hơn 25. Thông tin kết quả bao gồm CategoryID, 
--CategoryName, Total_UnitsInStock, Average_Unitprice.
select cate.CategoryID,cate.CategoryName, sum(pro.UnitsInStock) as SumUnitsInStock, avg(pro.UnitPrice) as AvgUnitPrice
from Categories cate 
join Products pro on pro.CategoryID = cate.CategoryID
group by cate.CategoryID, cate.CategoryName
having sum(pro.UnitsInStock) > 300 and avg(pro.UnitPrice) > 25 

--10.Danh sách các loại sản phẩm (Category) có tổng số sản phẩm (product) nhỏ
--hớn 10. Thông tin kết quả bao gồm CategoryID, CategoryName, 
--TotalOfProducts. Được sắp xếp theo CategoryName, cùng tên loại theo 
--TotalOfProducts giảm dần.
select ca.CategoryID,ca.CategoryName, count(pro.ProductID) as TotalOfProducts
from Categories ca inner join Products pro on ca.CategoryID = pro.CategoryID
group by ca.CategoryID,ca.CategoryName
having count(pro.ProductID) < 10
order by count(pro.ProductID) desc


--11.Liệt kê danh sách các sản phẩm bán trong quý 1 năm 1998 có tổng số lương >200,
--thông tin gồm [ProductID], [ProductName], SumofQuatity 
select pro.ProductID,pro.ProductName, sum(pro.UnitsOnOrder) as SumOfQuantity
from Products pro inner join [Order Details] ordt on pro.ProductID = ordt.ProductID
inner join Orders ord on ord.OrderID = ordt.OrderID
where month(ord.OrderDate) in (1,2,3)
and year(ord.OrderDate) = 1998
group by pro.ProductID,pro.ProductName
having sum(pro.UnitsOnOrder) > 200

--12.Danh sách các Customer ứng với tổng tiền của các hóa đơn ở từng tháng. 
--Thông tin bao gồm CustomerID, CompanyName, Month_Year, Total. Trong 
--đó Month_year là tháng và năm lập hóa đơn, Total là tổng của Unitprice* 
--Quantity.
select cus.CustomerID,
cus.ContactName, 
cus.CompanyName, 
concat(month(od.OrderDate),'-', year(od.OrderDate)) as Month_Year, 
sum(odd.Quantity * odd.UnitPrice) as Total
from Customers cus
join Orders od on od.CustomerID = cus.CustomerID
join [Order Details] odd on odd.OrderID = od.OrderID
GROUP BY cus.CustomerID,cus.ContactName, cus.CompanyName, od.OrderDate

--13.Cho biết Employees nào bán được nhiều tiền nhất trong 7 của năm 1997
select top 1 emp.EmployeeID,
CONCAT(emp.FirstName,' ',emp.LastName) as EmployeeName,
SUM(odd.Quantity * odd.UnitPrice) as SumTotalOfEmployee
from Employees emp
join Orders od on od.EmployeeID = emp.EmployeeID
join [Order Details] odd on odd.OrderID = od.OrderId
where month(od.RequiredDate) = '7' and year(od.RequiredDate) = '1997'
GROUP BY emp.EmployeeID, emp.LastName, emp.FirstName
order by SumTotalOfEmployee desc

--14.Danh sách 3 khách có nhiều đơn hàng nhất của năm 1996.
select top 3 cus.CustomerID, cus.ContactName,count(od.OrderID)
from Customers cus
join Orders od on od.CustomerID = cus.CustomerID
where year(od.OrderDate) = '1996'
group by cus.CustomerID, cus.ContactName
order by count(od.OrderID) DESC

--15. Tính tổng số hóa đơn và tổng tiền của mỗi nhân viên đã bán trong tháng 3/1997, có tổng tiền >4000, thông tin gồm [EmployeeID],[LastName], [FirstName], countofOrderid, sumoftotal.
select emp.EmployeeID,
CONCAT(emp.FirstName,' ',emp.LastName) as EmployeeName,
SUM(odd.Quantity * odd.UnitPrice) as SumTotalOfEmployee,
COUNT(od.OrderID) as TotalOrder
from Employees emp
join Orders od on od.EmployeeID = emp.EmployeeID
join [Order Details] odd on odd.OrderID = od.OrderId
where od.RequiredDate >= '1997-03-01' and od.RequiredDate <= '1997-03-31' 
GROUP BY emp.EmployeeID, emp.LastName, emp.FirstName
HAVING SUM(odd.Quantity * odd.UnitPrice) > 4000