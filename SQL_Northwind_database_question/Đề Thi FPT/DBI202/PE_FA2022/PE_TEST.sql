go
create function fnSumSalaryEmployeeSex1(
	@gioitinh varchar(1)
)
returns float
as
begin 
	declare @tongluong float
	select @tongluong = sum(empSalary)
	from tblEmployee
	where empSex = @gioitinh
	return @tongluong
end
go

begin tran
update tblEmployee
set empSalary += 10000

declare @tongluong int
select @tongluong = sum(empSalary)
from tblEmployee





--question 2 

select StockItemID, StockItemName ,SupplierID ,Color 
from StockItems 
where Color like 'Blue' 

--question 3
select sl.SupplierTransactionID , su.SupplierID , su.SupplierName ,sl.TransactionDate,
sl.TransactionAmount 
from Suppliers su 
join SupplierTransactions sl on sl.SupplierID = su.SupplierID 
where sl.TransactionDate >= '2013-02-01' and sl.TransactionDate <= '2013-02-15'

--question 4 
select st.StockItemID, st.StockItemName , su.SupplierID , su.SupplierName,
st.OuterPackageID, pa.PackageTypeName as OuterPackegeTypeName, st.UnitPrice 
from  Suppliers su
join StockItems st on su.SupplierID = st.SupplierID 
join PurchaseOrderLines pu on pu.StockItemID = st.StockItemID 
join PackageTypes pa on pa.PackageTypeID = pu.PackageTypeID 
where st.StockItemID >= 135 
order by OuterPackegeTypeName asc , st.StockItemName asc 

--question 5
select su.SupplierID , su.SupplierName, count(pu.PurchaseOrderID) as NumberOfPuchaseOrders 
from Suppliers su 
left join PurchaseOrders pu on pu.SupplierID = su.SupplierID 
group by su.SupplierID , su.SupplierName
order by NumberOfPuchaseOrders desc , su.SupplierName desc 

--question 6
with t as (
select st.UnitPackageID , pa.PackageTypeName as UnitPackageTypeName, count(pa.PackageTypeID)
as NumberOfStockItems 
from PackageTypes pa 
join StockItems st on st.UnitPackageID = pa.PackageTypeID 
group by st.UnitPackageID , pa.PackageTypeName)

select * from t  
where NumberOfStockItems = (select top 1 NumberOfStockItems from t
ORDER BY NumberOfStockItems ASC)

--question 7

--question 8

create procedure Proc4 (@stockitemID int , @OrderYear int , @NumberOfPuchaseOrders int output)
as 
begin 
	select @NumberOfPuchaseOrders = count(*)  
	from PurchaseOrderLines pu join PurchaseOrders po on pu.PurchaseOrderID = po.PurchaseOrderID 
	where @stockitemID = pu.StockItemID and @OrderYear = year(po.OrderDate)
	
end

DECLARE @x INT
EXEC Proc4 95
          ,2013
          ,@x OUTPUT
SELECT
  @x AS NumberOfPurchaseOrders
  
  drop proc  Proc4

  -- question 9

create trigger Tr4 on StockItems after insert 
as  
begin 
	select st.StockItemID , st.StockItemName , st.OuterPackageID,
	pa.PackageTypeName as OuterPackageTypeName , st.UnitPrice , TaxRate 
	from inserted st left join PackageTypes pa on pa.PackageTypeID = st.OuterPackageID	 
end 

INSERT into StockItems (StockItemID, StockItemName, UnitPackageID, OuterPackageID, QuantityPerOuter, IsChillerStock, TaxRate, UnitPrice, TypicalWeightPerUnit, Color)
  VALUES (308, N'T-shirt Red bull', 7, 6, 1, 0, 0.15, 10.5, 0.4, 4)
  drop trigger Tr4

  --question 10 

  delete from PackageTypes 
  where PackageTypeID not in (
  select st.OuterPackageID 
  from StockItems st join PackageTypes pa on pa.PackageTypeID = st.OuterPackageID 
  group by st.OuterPackageID
  union 
  select st.UnitPackageID 
  from StockItems st join PackageTypes pa on pa.PackageTypeID = st.UnitPackageID 
  group by st.UnitPackageID 
  )
  --------------------
  CREATE TRIGGER InsertProduct
ON Product
AFTER INSERT
AS
BEGIN
	SELECT p.ProductName, s.SubCategoryName FROM inserted p
	INNER JOIN SubCategory s
	ON p.SubCategoryID = s.ID
END

------
  INSERT INTO Category (CategoryName)
VALUES ('Sports')

DECLARE @ID int = SCOPE_IDENTITY()

INSERT INTO SubCategory
	(SubCategoryName ,CategoryID)
VALUES
	('Tennis', @ID),
	('Football', @ID)