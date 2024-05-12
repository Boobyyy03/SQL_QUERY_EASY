use Northwind 

SELECT c.CustomerID, c.CompanyName, c.Address, o.OrderID, o.OrderDate
FROM Customers c
JOIN Orders o ON c.CustomerID = o.CustomerID
WHERE YEAR(o.OrderDate) = 1997 AND MONTH(o.OrderDate) = 7;


SELECT TOP 1 o.ShipCountry
FROM Orders o
WHERE YEAR(o.OrderDate) = 1997 AND DATEPART(QUARTER, o.OrderDate) = 4
ORDER BY o.CustomerID DESC, o.OrderDate ASC;



SELECT *
FROM Customers
WHERE ContactTitle LIKE 'n%' COLLATE SQL_Latin1_General_CP1_CI_AS;

SELECT TOP 1 ShipCity
FROM Orders
WHERE YEAR(OrderDate) = 1998
ORDER BY CustomerID ASC;


SELECT *, COUNT(*) OVER() AS TotalRows
FROM Customers
WHERE ContactName LIKE 'A%' AND City = 'Madrid';

SELECT COUNT(*) AS TotalOrders
FROM Orders
WHERE YEAR(OrderDate) = 1996;

SELECT COUNT(*) AS TotalSuppliers
FROM Suppliers
WHERE SupplierID NOT IN (
    SELECT DISTINCT SupplierID
    FROM Products
);

SELECT TOP 1 ContactName, COUNT(*) AS TotalOrders
FROM Customers c
JOIN Orders o ON c.CustomerID = o.CustomerID
GROUP BY c.ContactName
ORDER BY TotalOrders DESC;

SELECT COUNT(*) AS TotalUnsoldProducts
FROM Products
WHERE UnitsInStock = 0 OR Discontinued = 1;

SELECT TOP 1 c.ContactName, MIN(*) AS TotalOrders
FROM Customers c
JOIN Orders o ON c.CustomerID = o.CustomerID
WHERE YEAR(o.OrderDate) = 1996
GROUP BY c.ContactName
HAVING MIN(*) > 4
ORDER BY MIN(*) ASC;

SELECT *
FROM Customers
WHERE City IN ('London', 'Boise', 'Paris');

SELECT CustomerID, COUNT(*) AS CountOfOrder
FROM Orders
GROUP BY CustomerID;

SELECT COUNT(DISTINCT CustomerID) AS TotalCustomers
FROM Orders
WHERE YEAR(OrderDate) = 1996 AND MONTH(OrderDate) = 12;

SELECT *
FROM Customers
WHERE Fax IS NULL OR Fax = '';

SELECT p.ProductID, p.ProductName, MAX(od.Quantity) AS SoluongMAX
FROM Products p
JOIN [Order Details] od ON p.ProductID = od.ProductID
GROUP BY p.ProductID, p.ProductName
ORDER BY p.ProductID ASC;

SELECT COUNT(*) AS TotalEmployees
FROM Employees
WHERE YEAR(BirthDate) > 1960

SELECT TOP 5 CustomerID, CompanyName, City, Country
FROM Customers
WHERE City LIKE 'M%'
ORDER BY Country ASC;

SELECT COUNT(DISTINCT EmployeeID) AS TotalEmployees
FROM Orders
WHERE YEAR(OrderDate) = 1996 AND MONTH(OrderDate) = 7;

SELECT CustomerID, COUNT(*) AS CountOfOrder
FROM Orders
WHERE CustomerID LIKE 'B%'  -- Lọc theo CustomerID bắt đầu bằng 'B'
GROUP BY CustomerID
HAVING COUNT(*) > 10;  -- Lọc theo số lượng hóa đơn lớn hơn 10


SELECT CustomerID, COUNT(*) AS CountOfOrder
FROM Orders
GROUP BY CustomerID
HAVING COUNT(*) > 10;

SELECT TOP 1 c.ContactName, COUNT(*) AS TotalOrders
FROM Customers c
JOIN Orders o ON c.CustomerID = o.CustomerID
WHERE YEAR(o.OrderDate) = 1996
GROUP BY c.ContactName
ORDER BY COUNT(*) DESC;

SELECT COUNT(*) AS TotalSuppliersWithoutWebsite
FROM Suppliers
WHERE  IS NULL OR Website = '';

SELECT TOP 1 p.ProductName
FROM Products JOIN [Order Details] od ON p.ProductID = od.ProductID
JOIN Orders o ON od.OrderID = o.OrderID
WHERE ProductID IN (
    SELECT DISTINCT ProductID
    FROM [Order Details]
    WHERE OrderID IN (
        SELECT OrderID
        FROM Orders
        WHERE YEAR(ShippedDate) = 1998
    )
)
ORDER BY ShippedDate DESC;

SELECT TOP 1 p.ProductName
FROM Products p
JOIN [Order Details] od ON p.ProductID = od.ProductID
JOIN Orders o ON od.OrderID = o.OrderID
WHERE YEAR(o.ShippedDate) = 1998
ORDER BY o.ShippedDate DESC;


SELECT TOP 1 c.ContactName
FROM Customers c
JOIN Orders o ON c.CustomerID = o.CustomerID
WHERE o.OrderDate BETWEEN '1998-02-01' AND '1998-02-07'
ORDER BY c.CustomerID ASC;

SELECT TOP 1 ShipCountry
FROM Orders
WHERE YEAR(OrderDate) = 1996 AND MONTH(OrderDate) = 9
ORDER BY CustomerID ASC, OrderDate DESC;

SELECT TOP 1 CountOfOrder
FROM (
    SELECT CustomerID, COUNT(*) AS CountOfOrder
    FROM Orders
    WHERE CustomerID LIKE 'B%'
    GROUP BY CustomerID
    HAVING COUNT(*) > 5
) AS Subquery
ORDER BY CountOfOrder DESC;

SELECT EmployeeId, CONCAT(FirstName, ' ', LastName) AS EmployeeName, Phone, DATEDIFF(YEAR, BirthDate, GETDATE()) AS Age
FROM Employees;

SELECT SUM(od.Quantity) AS TotalQuantity
FROM [Order Details] od
JOIN Orders o ON od.OrderID = o.OrderID
WHERE YEAR(o.OrderDate) = 1996;

SELECT *
FROM Products;

SELECT TOP 1 City
FROM (
    SELECT c.CustomerID, c.CompanyName, c.Address, o.OrderID, o.OrderDate, c.City
    FROM Customers c
    JOIN Orders o ON c.CustomerID = o.CustomerID
    WHERE YEAR(o.OrderDate) = 1997 AND MONTH(o.OrderDate) = 7
    ORDER BY c.CustomerID ASC, o.OrderDate DESC
) AS Subquery;

SELECT COUNT(*) AS NumberOfCustomersWithFax
FROM Customers
WHERE Fax IS NOT NULL;

SELECT COUNT(*) AS NumberOfCustomersInLondon
FROM Customers
WHERE City = 'London';

SELECT COUNT(*) AS NumberOfCustomersWithoutFax
FROM Customers
WHERE Fax IS NULL;



SELECT c.CustomerID, c.CompanyName, c.Address, o.OrderID, o.OrderDate
FROM Customers c
JOIN Orders o ON c.CustomerID = o.CustomerID
WHERE YEAR(o.OrderDate) = 1997 AND MONTH(o.OrderDate) = 7
ORDER BY c.CustomerID ASC, o.OrderDate DESC;

SELECT TOP 1 City
FROM (
    SELECT c.CustomerID, c.CompanyName, c.Address, o.OrderID, o.OrderDate, c.City
    FROM Customers c
    JOIN Orders o ON c.CustomerID = o.CustomerID
    WHERE YEAR(o.OrderDate) = 1997 AND MONTH(o.OrderDate) = 7
    ORDER BY c.CustomerID ASC, o.OrderDate DESC
) AS Subquery;
