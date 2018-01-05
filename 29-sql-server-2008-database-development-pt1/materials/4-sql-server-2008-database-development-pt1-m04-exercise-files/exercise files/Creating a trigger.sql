--Creating the trigger
USE veronicas;
GO
IF OBJECT_ID ('SALES.Trig1','TR') IS NOT NULL
   DROP TRIGGER SALES.Trig1;
GO
-- Creating a trigger on an existent table.

CREATE TRIGGER SALES.Trig1
on Sales.orderdetails
AFTER INSERT
AS 
BEGIN

DECLARE @NewFlowerID varchar(10),
        @NewOrderNumber varchar(10),
        @NewQuantity varchar(10)
SELECT @NewFlowerID = FlowerID, @NewOrderNumber = OrderNumber, @NewQuantity = Quantity from inserted

INSERT INTO [veronicas].[SALES].[OrderStatus]
           ([FlowerID]
           ,[OrderNumber]
           ,[Unshipped])
     VALUES (@NewFlowerID, @NewOrderNumber, @NewQuantity )
END

GO


--Testing the trigger


use veronicas
go


INSERT INTO [veronicas].[SALES].[OrderDetails]
           ([FlowerID]
           ,[OrderNumber]
           ,[Shipdate]
           ,[Quantity])
     VALUES
           ('295'
           ,'395' 
           ,'06/01/2009' 
           , 8 ) 
GO

select * from SALES.OrderDetails
where SALES.OrderDetails.OrderNumber = '395'

select * from SALES.OrderStatus
where OrderNumber = '395'