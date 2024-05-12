
use Northwind 

--PROCEDURE
--1.	Viết thủ tục spOderMonthYear Liệt kê danh sách các hóa đơn của các Customers mua hàng trong tháng của năm của năm.
-- Thông tin gồm Orderid, CompanyName, OrderDate, RequiredDate, được sắp xếp theo CompanyName, 
-- cùng Companyname thì theo OrderDate giảm dần.

go
create procedure spOrderMonthYear (@month int, @year int) as
begin
    select Orders.OrderID, Customers.CompanyName, Orders.OrderDate, Orders.RequiredDate
    from Orders
    inner join Customers on Orders.CustomerID = Customers.CustomerID
    where month(Orders.OrderDate) = @month and year(Orders.OrderDate) = @year
    order by Customers.CompanyName asc, Orders.OrderDate desc
end
go

exec spOrderMonthYear 7,1996

select * from Orders, Customers 

--2.	Viết thủ tục spLastNameEmp để liệt kê danh sách các hóa đơn do nhân viên có LastName 

go
create PROCEDURE spLastNameEmp(@lastName VARCHAR(255)) as
begin
    select Orders.OrderID, Employees.LastName, Employees.FirstName, Orders.OrderDate, Orders.RequiredDate
    from Orders
    join Employees on Orders.EmployeeID = Employees.EmployeeID
    where Employees.LastName = lastName
    order by Employees.LastName asc
end
go

exec spLastNameEmp '...'

--3.	Viết thủ tục spIncreseProduct để tăng đơn giá của sản phẩm thuộc nhóm nhà cung cấp,
-- tham số đầu vào là mã số nhà cung cấp và giá trị tăng lương. 
-- Biết rằng mã số nhà cung cấp phải tồn tại và giá trị tăng lớn hơn 0
go
create procedure spIncreaseProduct(
    @supplierID int,
    @increaseValue decimal(10, 2)) as
begin
    if exists (select * from Suppliers 
	where SupplierID = @supplierID) and @increaseValue > 0
    begin
        update Products
        set UnitPrice = UnitPrice + @increaseValue
        where SupplierID = @supplierID;
        
        select * from Products 
		where SupplierID = @supplierID;
    end
end
go

exec spIncreaseProduct @supplierID = 1, @increaseValue = 5.00
drop procedure spIncreaseProduct

--4.	Viết thủ tục spOldEmp để xóa tất cả những nhân viên có tuổi lớn hơn 65

go
create procedure spOldEmp as
begin
    delete from Employees
    WHERE DATEDIFF(YEAR, BirthDate, GETDATE()) > 65;
end
go

exec spOldEmp
drop procedure spOldEmp
--5.	Viết thủ tục spRename để cập nhật tên nhân viên (FirstNam) phải có prefix phía trước là Mr.
-- nếu là nam và Mrs. nếu là nữ  
go
create procedure spRename @EmployeeID int, @NewFirstName NVARCHAR(50)
as
begin
    declare @Prefix NVARCHAR(10)
    select @Prefix = case when TitleOfCourtesy = 'Mr.' then 'Mr.' else 'Mrs.' end
    from Employees
    where EmployeeID = @EmployeeID
    -- Cập nhật tên nhân viên 
    update Employees
    set FirstName = concat(@Prefix, ' ', @NewFirstName)
    where EmployeeID = @EmployeeID
end
go

EXEC spRename @EmployeeID = 123, @NewFirstName = 'Nancy'
	
select * from Employees


--FUNCTION

--1.	Viết hàm fnNgayLam để trả về số ngày vào công ty tính tới thời điểm hiện tại của một nhân viên khi biết mã nhân viên đó
go
create function fnNgayLam( @employeeID int )
returns int
as
begin
    declare @startDate date
    declare @currentDate date
    declare @daysWorked int

    select @startDate = HireDate, @currentDate = GETDATE()
    from Employees
    where EmployeeID = @employeeID

    set @daysWorked = DATEDIFF(DAY, @startDate, @currentDate);

    return @daysWorked
end
go

select EmployeeID, dbo.fnNgayLam(EmployeeID) as DaysWorked
from Employees


--2.	Viết hàm fnDiaChi để trả về số lượng nhân viên đang cư ngụ tại một địa điểm
go
create function fnDiaChi( @address nvarchar(100 ))
returns int
as
begin
    declare @employeeCount int

    select @employeeCount = count(*)
    from Employees
    where Address = @address

    return @employeeCount
end
go

select dbo.fnDiaChi('14 Garrett Hill') as EmployeeCount
select * from  Employees 

--3.	Viết hàm fnEmpOrder để cho biết thông tin hóa đơn mà nhân viên bán
create function fnEmpOrder( @employeeID int )
returns table
as
return (
    select Orders.OrderID, Orders.OrderDate, Orders.CustomerID
    from Orders
    where Orders.EmployeeID = @employeeID)
go

select *
from dbo.fnEmpOrder(1)

select * from  Employees 
--4.   Viết hàm fnCustomerOrder cho biết tổng số tiền mà khách hàng đã mua hàng khi biết mã khách hàng
go
create function  fnCustomerOrder ( @CustomerID NVARCHAR(10))
returns money 
as
begin
    declare @TotalOrderAmount money

    -- Tính tổng số tiền từ các đơn hàng của khách hàng
    select @TotalOrderAmount = SUM(UnitPrice * Quantity - Discount)
    from Orders
    join [Order Details] on Orders.OrderID = [Order Details].OrderID
    where Orders.CustomerID = @CustomerID

    -- Trả về tổng số tiền
    return @TotalOrderAmount
end
go

SELECT dbo.fnCustomerOrder('ALFKI') as TotalOrderAmount
select CustomerID from Orders 
drop function fnCustomerOrder

--5.	Viết hàm fnNhanVien để thống kê xem danh sách nhân viên với các thông tin:
-- nhân viên ở đâu, bao nhiêu tuổi, làm ở công ty bao lâu, tổng số hóa đơn đã bán
go 
create function fnNhanVien (@employeeID int)
returns table
as
return (
    select
        Employees.EmployeeID,
        Employees.Address as DiaChi,
        datediff(year, Employees.BirthDate, getdate()) as Tuoi,
        datediff(year, Employees.HireDate, getdate()) as ThoiGianLam,
     (select count(*)
            from Orders
            where Orders.EmployeeID = Employees.EmployeeID ) as TongSoHoaDon
    from Employees
    where Employees.EmployeeID = @employeeID )
go

select *
from dbo.fnNhanVien(1)

--TRIGGER

--1.	Hãy viết tgCheckAge để đảm bảo rằng khi thêm mới thì một nhân viên thì tuổi nhỏ hơn 35
go
create trigger tgCheckAge
on Employees
instead of insert
as
begin
    declare @currentDate date;
    set @currentDate = getdate()

    insert into Employees (EmployeeID, LastName, FirstName, Title, TitleOfCourtesy, BirthDate, HireDate, Address, City, Region, PostalCode, Country, HomePhone, Extension, Photo, Notes)
    select EmployeeID, LastName, FirstName, Title, TitleOfCourtesy, BirthDate, HireDate, Address, City, Region, PostalCode, Country, HomePhone, Extension, Photo, Notes
    from inserted
    where datediff(year, BirthDate, @currentDate) < 35
end
go

select * from Employees
disable trigger tgCheckAge on  Employees
drop trigger tgCheckAge

--2.	Hãy viết tgCheckAgeRetire để đảm bảo rằng khi cập nhật thì một nhân viên thì tuổi tối đa là 65
go
create trigger tgCheckAgeRetire
on Employees
instead of update
as
begin
    declare @currentDate date
    set @currentDate = getdate()

    update Employees
    set LastName = i.LastName,
        FirstName = i.FirstName,
        Title = i.Title,
        TitleOfCourtesy = i.TitleOfCourtesy,
        BirthDate = i.BirthDate,
        HireDate = i.HireDate,
        Address = i.Address,
        City = i.City,
        Region = i.Region,
        PostalCode = i.PostalCode,
        Country = i.Country,
        HomePhone = i.HomePhone,
        Extension = i.Extension,
        Photo = i.Photo,
        Notes = i.Notes
    from Employees e
    inner join inserted i on e.EmployeeID = i.EmployeeID
    where datediff(year, i.BirthDate, @currentDate) <= 65
end
go

select * from Employees
disable trigger tgCheckAge on  Employees
drop trigger tgCheckAge
--3.	Hãy viết tgCheckOrder để đảm bảo rằng khi cập nhật hoặc thêm mới thì một nhân viên chỉ có tối đa 10 đơn hàng trong một ngày
create trigger tgCheckOrder
on Orders
instead of insert, update
as
begin
    declare @maxOrderCount int
    set @maxOrderCount = 10

    declare @currentDate date
    set @currentDate = convert(date, getdate())

    -- Check for new orders
    if exists (
        select EmployeeID, count(*) as OrderCount
        from inserted
        where convert(date, OrderDate) = @currentDate
        group by EmployeeID
        having count(*) > @maxOrderCount
    )
    begin
        raiserror ('Một nhân viên chỉ có thể có tối đa %d đơn hàng trong một ngày.', 16, 1, @maxOrderCount);
        rollback transaction
        return
    end

    -- Insert or update orders
    insert into Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
    select OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry
    from inserted
end
go

--4.	Hãy viết tgCheckCate để đảm bảo rằng một danh mục chỉ tối đa được tối đa 20 sản phẩm khi thực hiện thao tác thêm, sửa
go
create trigger tgCheckCate
on Products
instead of insert, update
as
begin
    declare @maxProductCount int;
    set @maxProductCount = 20;

    -- Check for new products
    if exists (
        select CategoryID, count(*) as ProductCount
        from (
            select CategoryID
            from inserted
            union all
            select CategoryID
            from Products p
            where p.ProductID in (select ProductID from inserted)
        ) t
        group by CategoryID
        having count(*) > @maxProductCount
    )
    begin
        raiserror ('Một danh mục chỉ được phép chứa tối đa %d sản phẩm.', 16, 1, @maxProductCount);
        rollback transaction;
        return;
    end

    -- Insert or update products
    insert into Products (ProductID, ProductName, SupplierID, CategoryID, QuantityPerUnit, UnitPrice, UnitsInStock, UnitsOnOrder, ReorderLevel, Discontinued)
    select ProductID, ProductName, SupplierID, CategoryID, QuantityPerUnit, UnitPrice, UnitsInStock, UnitsOnOrder, ReorderLevel, Discontinued
    from inserted;
end;
go

--5.	5.	Hãy viết tgSupplier để đảm bảo rằng 
-- các nơi cung cấp không phải ở US thì không thể cung cấp vượt quá 10 sản phẩm khi thực hiện thao tác thêm, sửa
go
create trigger tgSupplier
on Products
instead of insert, update
as
begin
    declare @maxProductCount int
    set @maxProductCount = 10

    -- Check for new products
    if exists (
        select p.SupplierID, count(*) as ProductCount
        from (
            select p.SupplierID, s.Country
            from inserted i
            inner join Suppliers s on i.SupplierID = s.SupplierID
            inner join Products p on i.ProductID = p.ProductID
        ) p
        where p.Country <> 'US'
        group by p.SupplierID, p.Country
        having count(*) > @maxProductCount
    )
    begin
        raiserror ('Các nhà cung cấp không ở Mỹ không thể cung cấp vượt quá %d sản phẩm.', 16, 1, @maxProductCount);
        rollback transaction
        return
    end

    -- Insert or update products
    insert into Products (ProductID, ProductName, SupplierID, CategoryID, QuantityPerUnit, UnitPrice, UnitsInStock, UnitsOnOrder, ReorderLevel, Discontinued)
    select ProductID, ProductName, SupplierID, CategoryID, QuantityPerUnit, UnitPrice, UnitsInStock, UnitsOnOrder, ReorderLevel, Discontinued
    from inserted;
end;
go
drop trigger tgSupplier

--6.	6.	Hãy viết tgShipper để kiểm tra đảm bảo nhân viên giao hàng chỉ được 
-- giao hàng tối đa 10 đơn mỗi ngày khi thực hiện thao tác thêm, sửa
go
create trigger tgShipper
on Orders
instead of insert, update
as
begin
    declare @maxOrderCount int
    set @maxOrderCount = 10
    -- Check for new orders
    if exists (
        select EmployeeID, count(*) as OrderCount
        from (
            select EmployeeID
            from inserted
            union all
            select EmployeeID
            from Orders o
            where o.OrderID in (select OrderID from inserted)
        ) t
        group by EmployeeID
        having count(*) > @maxOrderCount
    )
    begin
        raiserror ('Nhân viên giao hàng chỉ được giao tối đa %d đơn hàng trong một ngày.', 16, 1, @maxOrderCount);
        rollback transaction
        return
    end

    -- Insert or update orders
    insert into Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
    select OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry
    from inserted;
end;
go
drop trigger tgcheckCate
drop trigger tgCheckOrder
--7.7.	Hãy viết tgOrderDetail để đảm bảo rằng khi thực hiện các thao tác xóa, chỉnh sửa trên
-- bảng Order Details thì nếu giá trị hóa đơn tương ứng là 0 thì xóa luôn hóa đơn.
go
create trigger tgOrderDetail
on [Order Details]
after delete, update
as
begin
    -- Check for zero invoice value
    if exists (
        select od.OrderID
        from deleted d
        inner join [Order Details] od on d.OrderID = od.OrderID
        where od.UnitPrice * od.Quantity - od.Discount = 0
    )
    begin
        delete from Orders
        where OrderID in (
            select od.OrderID 
            from deleted d 
            inner join [Order Details] od on d.OrderID = od.OrderID
            where od.UnitPrice * od.Quantity - od.Discount = 0
        )
    end
end
go

select *
from [Order Details]

