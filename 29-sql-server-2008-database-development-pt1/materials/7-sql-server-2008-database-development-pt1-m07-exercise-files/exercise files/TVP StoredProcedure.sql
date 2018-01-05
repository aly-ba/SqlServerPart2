
USE veronicas
GO


CREATE TABLE [SALES].[DupCustomerTable](
	[CustomerNumber] [varchar](10) NOT NULL,
	[FirstName] [varchar](50) NULL,
	[LastName] [varchar](50) NULL,
	[Phone] [varchar](50) NULL,
	[Address] [varchar](50) NULL,
	[City] [varchar](50) NULL,
	[State] [varchar](50) NULL,
	[Zip] [varchar](10) NULL,
	[Email] [varchar](50) NULL,
	[Birthdate] [varchar](50) NULL,
	[Anniversary] [varchar](50) NULL
) ON [PRIMARY]
GO



CREATE TYPE [SALES].[Customer_Tabletype] AS TABLE(
	[CustomerNumber] [varchar](10) NOT NULL,
	[FirstName] [varchar](50) NULL,
	[LastName] [varchar](50) NULL,
	[Phone] [varchar](50) NULL,
	[Address] [varchar](50) NULL,
	[City] [varchar](50) NULL,
	[State] [varchar](50) NULL,
	[Zip] [varchar](10) NULL,
	[Email] [varchar](50) NULL,
	[Birthdate] [varchar](50) NULL,
	[Anniversary] [varchar](50) NULL
)
GO



CREATE PROCEDURE SALES.[usp_MoveCustomers]
    @TVP Customer_TableType READONLY
    AS 
    SET NOCOUNT ON
    INSERT INTO [SALES].[DupCustomerTable] Select * from @TVP
        
 GO
 
/*
This procedure gets the table variable as input and inserts the data 
*/

DECLARE @TV AS [SALES].[Customer_Tabletype]
INSERT INTO @TV (	
    [CustomerNumber],
	[FirstName],
	[LastName],
	[Phone],
	[Address],
	[City],
	[State],
	[Zip],
	[Email],
	[Birthdate],
	[Anniversary])     SELECT * from sales.customers where sales.customers.state = 'IL'
	

   
exec SALES.[usp_MoveCustomers] @TV
go
--Now, let’s query all the data from the table TestLocationTable using the following Transact SQL statement.

select * from [SALES].[DupCustomerTable]
go

