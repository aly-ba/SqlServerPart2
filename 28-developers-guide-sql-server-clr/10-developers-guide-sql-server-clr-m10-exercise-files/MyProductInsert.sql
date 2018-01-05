SET IDENTITY_INSERT SalesLT.MyProduct ON
GO

INSERT SalesLT.MyProduct
(ProductId, Name, ProductNumber, Color, StandardCost, ListPrice,
CatalogData, 
Size, Weight, ProductCategoryID, ProductModelID, SellStartDate,
SellEndDate, DiscontinuedDate, ThumbNailPhoto, ThumbnailPhotoFileName)

(SELECT ProductId, Name, ProductNumber, Color, StandardCost, ListPrice,
convert(varchar(20), ListPrice) + ';1;1', 
Size, Weight, ProductCategoryID, ProductModelID, SellStartDate,
SellEndDate, DiscontinuedDate, ThumbNailPhoto, ThumbnailPhotoFileName
FROM SalesLT.Product)
GO

SET IDENTITY_INSERT SalesLT.MyProduct OFF
GO