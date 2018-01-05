USE [AdventureWorksLT2008]
GO

CREATE TABLE [SalesLT].[MyProduct](
	[ProductID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [dbo].[Name] NOT NULL,
	[ProductNumber] [nvarchar](25) NOT NULL,
	[Color] [nvarchar](15) NULL,
	[StandardCost] [money] NOT NULL,
	[ListPrice] [money] NOT NULL,
	[CatalogData] UDTCatalog NULL,
	[Size] [nvarchar](5) NULL,
	[Weight] [decimal](8, 2) NULL,
	[ProductCategoryID] [int] NULL,
	[ProductModelID] [int] NULL,
	[SellStartDate] [datetime] NOT NULL,
	[SellEndDate] [datetime] NULL,
	[DiscontinuedDate] [datetime] NULL,
	[ThumbNailPhoto] [varbinary](max) NULL,
	[ThumbnailPhotoFileName] [nvarchar](50) NULL,
	[rowguid] [uniqueidentifier] ROWGUIDCOL  NOT NULL,
	[ModifiedDate] [datetime] NOT NULL,
 CONSTRAINT [PK_MyProduct_ProductID] PRIMARY KEY CLUSTERED 
(
	[ProductID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY],
 CONSTRAINT [AK_MyProduct_Name] UNIQUE NONCLUSTERED 
(
	[Name] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY],
 CONSTRAINT [AK_MyProduct_ProductNumber] UNIQUE NONCLUSTERED 
(
	[ProductNumber] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY],
 CONSTRAINT [AK_MyProduct_rowguid] UNIQUE NONCLUSTERED 
(
	[rowguid] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

ALTER TABLE [SalesLT].[MyProduct]  WITH CHECK ADD  CONSTRAINT [FK_MyProduct_ProductCategory_ProductCategoryID] FOREIGN KEY([ProductCategoryID])
REFERENCES [SalesLT].[ProductCategory] ([ProductCategoryID])
GO

ALTER TABLE [SalesLT].[MyProduct] CHECK CONSTRAINT [FK_MyProduct_ProductCategory_ProductCategoryID]
GO

ALTER TABLE [SalesLT].[MyProduct]  WITH CHECK ADD  CONSTRAINT [FK_MyProduct_ProductModel_ProductModelID] FOREIGN KEY([ProductModelID])
REFERENCES [SalesLT].[ProductModel] ([ProductModelID])
GO

ALTER TABLE [SalesLT].[MyProduct] CHECK CONSTRAINT [FK_MyProduct_ProductModel_ProductModelID]
GO

ALTER TABLE [SalesLT].[MyProduct]  WITH CHECK ADD  CONSTRAINT [CK_MyProduct_ListPrice] CHECK  (([ListPrice]>=(0.00)))
GO

ALTER TABLE [SalesLT].[MyProduct] CHECK CONSTRAINT [CK_MyProduct_ListPrice]
GO

ALTER TABLE [SalesLT].[MyProduct]  WITH CHECK ADD  CONSTRAINT [CK_MyProduct_SellEndDate] CHECK  (([SellEndDate]>=[SellStartDate] OR [SellEndDate] IS NULL))
GO

ALTER TABLE [SalesLT].[MyProduct] CHECK CONSTRAINT [CK_MyProduct_SellEndDate]
GO

ALTER TABLE [SalesLT].[MyProduct]  WITH CHECK ADD  CONSTRAINT [CK_MyProduct_StandardCost] CHECK  (([StandardCost]>=(0.00)))
GO

ALTER TABLE [SalesLT].[MyProduct] CHECK CONSTRAINT [CK_MyProduct_StandardCost]
GO

ALTER TABLE [SalesLT].[MyProduct]  WITH CHECK ADD  CONSTRAINT [CK_MyProduct_Weight] CHECK  (([Weight]>(0.00)))
GO

ALTER TABLE [SalesLT].[MyProduct] CHECK CONSTRAINT [CK_MyProduct_Weight]
GO

ALTER TABLE [SalesLT].[MyProduct] ADD  CONSTRAINT [DF_MyProduct_rowguid]  DEFAULT (newid()) FOR [rowguid]
GO

ALTER TABLE [SalesLT].[MyProduct] ADD  CONSTRAINT [DF_MyProduct_ModifiedDate]  DEFAULT (getdate()) FOR [ModifiedDate]
GO
