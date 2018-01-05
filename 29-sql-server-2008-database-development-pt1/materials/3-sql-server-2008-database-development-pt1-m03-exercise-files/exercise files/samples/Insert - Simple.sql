use veroncas
go


INSERT INTO [veronicas].[SALES].[Flowers]
     VALUES
(1000, 'Flower1000', 'Blue','Red', '35', '55-85','25.00', '37.00', '250','June 1','Rare variant')
GO

INSERT INTO [veronicas].[SALES].[Flowers]
           ([FlowerID]
           ,[CommonName]
           ,[DominateColor]
           ,[Height]
           ,[Description])
     VALUES
(1020, 'Flower1020', 'Grey', '25','Rare variant'),
(1021, 'Flower1021', 'Fushia', '15','Rare variant'),
(1022, 'Flower1022', 'Wine', '18','Rare variant'),
(1023, 'Flower1023', 'Plum', '21','Rare variant')
GO