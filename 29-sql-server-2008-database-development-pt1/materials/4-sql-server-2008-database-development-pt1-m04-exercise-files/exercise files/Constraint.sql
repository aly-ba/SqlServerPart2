INSERT INTO [veronicas].[SALES].[Flowers]
           ([FlowerID]
           ,[CommonName]
           ,[DominateColor]
           ,[Cost]
           ,[SalesPrice]
           ,[StockLevel]
           ,[NextShipmentDate]
           ,[Description])
     VALUES
           (1000, 
           'Flower1000', 
           'Blue', 
           -6.50, 
           -10.00, 
           500, 
           06/15/2009, 
           'Fake Flowers')
GO

UPDATE [veronicas].[SALES].[Flowers]
   SET [Cost] = -6.50
       ,[SalesPrice] = -10.00
 WHERE flowerID = 1000
GO

select * from [veronicas].[SALES].[Flowers]
where flowerid in (1000)

ALTER TABLE [veronicas].[SALES].[Flowers] ADD CONSTRAINT CK_Cost
    CHECK (Cost >= 0)
    
    
ALTER TABLE [veronicas].[SALES].[Flowers] ADD CONSTRAINT CK_SalesPrice
    CHECK (SalesPrice >= 0)



USE [veronicas]
GO

ALTER TABLE [SALES].[Flowers]  WITH NOCHECK ADD  CONSTRAINT [CK_Cost] CHECK  (([Cost]>=(0)))
GO

ALTER TABLE [SALES].[Flowers] CHECK CONSTRAINT [CK_Cost]
GO