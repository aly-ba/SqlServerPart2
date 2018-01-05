use veronicas
go

DELETE FROM [veronicas].[SALES].[Flowers]
      WHERE FlowerID in (512, 513, 514, 515, 516, 517, 518, 519)
GO
INSERT INTO [veronicas].[SALES].[Flowers]
           ([FlowerID]
           ,[Description])
     VALUES
           (512
           ,'oir�a')
GO
  
INSERT INTO [veronicas].[SALES].[Flowers]
           ([FlowerID]
           ,[Description])
     VALUES
           (513
           ,'oir�amos')
GO
INSERT INTO [veronicas].[SALES].[Flowers]
           ([FlowerID]
           ,[Description])
     VALUES
           (514
           ,'oyes')
GO


INSERT INTO [veronicas].[SALES].[Flowers]
           ([FlowerID]
           ,[Description])
     VALUES
           (515
           ,'oye')
GO

INSERT INTO [veronicas].[SALES].[Flowers]
           ([FlowerID]
           ,[Description])
     VALUES
           (516
           ,'o�mos')
GO

INSERT INTO [veronicas].[SALES].[Flowers]
           ([FlowerID]
           ,[Description])
     VALUES
           (517
           ,'oyen')
GO


INSERT INTO [veronicas].[SALES].[Flowers]
           ([FlowerID]
           ,[Description])
     VALUES
           (518
           ,'o�s')
GO

INSERT INTO [veronicas].[SALES].[Flowers]
           ([FlowerID]
           ,[Description])
     VALUES
           (519
           ,'o�r')
GO

select FlowerID, description from SALES.Flowers
where contains (Description, 'FORMSOF(INFLECTIONAL, oyes)', LANGUAGE N'spanish')