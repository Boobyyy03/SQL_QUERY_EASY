--Syntax
--Insert 
		--		Insert into table(ten coloumn)
		--		values(column)

-- Delete 
		--      Delete from table
		--		Where

--Update 
		--		Update table
		--		Set cái điều kiện
		--		where

--Procedure
	-- Create procedure ten
	--	@parameter
	-- as
	-- Begin
	--		cau lenh
	-- End

--Function
	-- Create function ten (@bien)
	-- Returns de bai cho
	-- as 
	-- Begin 
	--		Cau lenh
	-- End

--Trigger
	-- Create trigger ten on table
	-- after insert hoac delete hoac update
	-- as 
	-- Begin 

CREATE TRIGGER trigger_name
ON table_name
AFTER INSERT, DELETE, UPDATE
AS
BEGIN
    -- Trigger logic here
END;


USE PE_DBI202_SU23; -- Replace with your database name

-- Create the trigger
CREATE OR ALTER TRIGGER Salary_Not_Decrease
ON employees
AFTER UPDATE
AS
BEGIN
    -- Check if the salary is being decreased
    IF EXISTS (
        SELECT *
        FROM inserted i
        JOIN deleted d ON i.employee_id = d.employee_id
        WHERE i.salary < d.salary
    )
    BEGIN
        THROW 50000, 'Salary cannot be decreased.', 1;
    END
END;

