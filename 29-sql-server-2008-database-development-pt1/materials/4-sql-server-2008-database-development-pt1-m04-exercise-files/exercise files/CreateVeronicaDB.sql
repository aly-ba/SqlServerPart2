USE master

DROP DATABASE veronicas

CREATE DATABASE veronicas
go

USE [veronicas]
GO

CREATE SCHEMA SALES
GO
CREATE SCHEMA HR
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

USE [veronicas]
GO

CREATE TABLE [HR].[Benefits](
	[abc] [int] NULL
) ON [PRIMARY]

GO

CREATE TABLE [HR].[Deductions](
	[abc] [int] NULL
) ON [PRIMARY]

GO

CREATE TABLE [HR].[Employeees](
	[abc] [int] NULL
) ON [PRIMARY]

GO

CREATE TABLE [Sales].[Flowers](
    [FlowerID] [varchar](10) ,
	[CommonName] [varchar](50) NULL,
	[DominateColor] [varchar](50) NULL,
	[SubordinateColor] [varchar](50) NULL,
	[Height] [varchar](50) NULL,
	[TempRange] [varchar](50) NULL,
	[Cost] [smallmoney] NULL,
	[SalesPrice] [smallmoney] NULL,
	[StockLevel] [varchar](50) NULL,
	[NextShipmentDate] [varchar](50) NULL,
	[Description] [varchar](150) NULL
 CONSTRAINT [PK_Flowers] PRIMARY KEY CLUSTERED 
(
	[FlowerID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) 
) ON [PRIMARY]

GO




/*********************************/



CREATE TABLE [Sales].[Customers](
	[CustomerNumber] [varchar] (10) NOT NULL,
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
	CONSTRAINT [PK_Customers] PRIMARY KEY CLUSTERED 
	(
	[CustomerNumber] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

/********************************/



CREATE TABLE [Sales].[OrderDetails](
	[FlowerID] [varchar](10) NOT NULL,
	[OrderNumber] [varchar](10) NOT NULL,
	[Shipdate] [varchar](10) NULL,
	[Quantity] [varchar](10) NULL
) ON [PRIMARY]

GO


/********************************/


CREATE TABLE [Sales].[Orders](
	[OrderNumber] [varchar](10) NOT NULL,
	[CustomerNumber] [varchar](10) NOT NULL,
	[OrderDate] [varchar](10) NULL,
 CONSTRAINT [PK_Orders] PRIMARY KEY CLUSTERED 
(
	[OrderNumber] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

CREATE TABLE [Sales].[ClientFlowerMatch](
	[zip] [varchar](10) NOT NULL,
	[FlowerID] [varchar](10) NOT NULL,
	[Performance] [varchar](10) NULL
) ON [PRIMARY]

GO



CREATE TABLE [SALES].[OrderStatus](
	[FlowerID] [nchar](10) NOT NULL,
	[OrderNumber] [nchar](10) NOT NULL,
	[Unshipped] [nchar](10) NOT NULL
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO


BULK 
INSERT Sales.Flowers
        FROM 'c:\CourseFiles\Video03\FlowersData.csv'
            WITH
    (
                FIELDTERMINATOR = ',',
                ROWTERMINATOR = '\n'
    )
GO


BULK 
INSERT Sales.Customers
        FROM 'c:\CourseFiles\Video03\customersData.csv'
            WITH
    (
                FIELDTERMINATOR = ',',
                ROWTERMINATOR = '\n'
    )
GO


BULK 
INSERT Sales.Orders
        FROM 'c:\CourseFiles\Video03\ordersData.csv'
            WITH
    (
                FIELDTERMINATOR = ',',
                ROWTERMINATOR = '\n'
    )
GO


BULK 
INSERT Sales.OrderDetails
        FROM 'c:\CourseFiles\Video03\orderDetailsData.csv'
            WITH
    (
                FIELDTERMINATOR = ',',
                ROWTERMINATOR = '\n'
    )
GO


BULK 
INSERT Sales.ClientFlowerMatch
        FROM 'c:\CourseFiles\Video03\ClientFlowerMatchData.csv'
            WITH
    (
                FIELDTERMINATOR = ',',
                ROWTERMINATOR = '\n'
    )
GO

BULK 
INSERT Sales.OrderStatus
        FROM 'c:\CourseFiles\Video03\OrderStatus.csv'
            WITH
    (
                FIELDTERMINATOR = ',',
                ROWTERMINATOR = '\n'
    )
GO