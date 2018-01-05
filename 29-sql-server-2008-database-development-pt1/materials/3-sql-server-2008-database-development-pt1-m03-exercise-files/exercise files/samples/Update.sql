
select * from veronicas.SALES.Flowers
where FlowerID = 151

UPDATE [veronicas].[SALES].[Flowers]
   SET [StockLevel] = StockLevel+1
 WHERE FlowerID = 151
GO

select * from veronicas.SALES.Flowers
where FlowerID = 151