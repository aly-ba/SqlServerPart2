select SALES.Orders.CustomerNumber, SALEDetails.OrderNumber, saledetails.commonname
from SALES.Orders, (
	select OD.OrderNumber, FL.CommonName 
	from SALES.OrderDetails as OD, SALES.Flowers as FL 
	where OD.FlowerID = FL.FlowerID) as SaleDetails
where SALES.Orders.OrderNumber = SALEDetails.OrderNumber
order by SALES.Orders.CustomerNumber, SaleDetails.OrderNumber


INSERT INTO [veronicas].[SALES].[Orders]
           ([OrderNumber]
           ,[CustomerNumber]
           ,[OrderDate])
     VALUES
           (10002, 100000 , 02/06/2009)
GO

/****** Object:  Index [PK_Flowers]    Script Date: 06/01/2009 21:56:04 ******/
ALTER TABLE [SALES].[Flowers] ADD  CONSTRAINT [PK_Flowers] PRIMARY KEY CLUSTERED 
(
	[FlowerID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO


USE [veronicas]
GO

ALTER TABLE [SALES].[OrderDetails]  WITH CHECK ADD  CONSTRAINT [FK_OrderDetails_Orders] FOREIGN KEY([OrderNumber])
REFERENCES [SALES].[Orders] ([OrderNumber])
GO

ALTER TABLE [SALES].[OrderDetails] CHECK CONSTRAINT [FK_OrderDetails_Orders]
GO

---Unique Constraint

drop table hr.employees
go 
CREATE TABLE [HR].[Employees](
	[FirstName] [nvarchar](50) NULL,
	[LastName] [nvarchar](50) NULL,
	[Address] [nchar](50) NULL,
	[City] [nchar](10) NULL,
	[State] [nchar](10) NULL,
	[Zip] [nchar](10) NULL,
	[EmployeeID] [nchar](10) NOT NULL,
	[SSN] [nchar](10) UNIQUE NONCLUSTERED NULL,
 CONSTRAINT [PK_HR.Employees] PRIMARY KEY CLUSTERED 
(
	[EmployeeID] ASC
) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

INSERT INTO [veronicas].[HR].[Employees]
           ([FirstName]
           ,[LastName]
           ,[Address]
           ,[EmployeeID]
           ,[SSN])
     VALUES
           ('Mike' , 'Smith' ,'1234 Park'
           , '1001'
           ,'123456789')
GO
