CREATE PROCEDURE Sales.GetCustomerInfoFor 
AS 
    SELECT FirstName, LastName, Address, City, State, Zip, Phone, Email
    FROM SALES.Customers
    order by lastname
GO

--CREATE PROCEDURE Sales.GetCustomerInfoFor 
--    @LastName nvarchar(50) = N'%', 
--    @FirstName nvarchar(50) = N'%'
--AS 
--    SET NOCOUNT ON;
--    SELECT FirstName, LastName, Address, City, State, Zip, Phone, Email
--    FROM SALES.Customers
--    WHERE FirstName LIKE @FirstName AND LastName LIKE @LastName
--    order by lastname
--GO

Sales.GetCustomerInfoFor
