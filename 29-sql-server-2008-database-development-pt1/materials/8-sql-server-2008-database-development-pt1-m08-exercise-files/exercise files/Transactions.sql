USE veronicas
GO

DROP PROCEDURE sp_NewOrder
GO

CREATE PROCEDURE sp_NewOrder
@OrderNumber AS varchar(10),
@CustomerNumber AS VARCHAR (10),
@OrderDate AS VARCHAR (10)
AS

	INSERT INTO [veronicas].[SALES].[Orders]
			   ([OrderNumber]
			   ,[CustomerNumber]
			   ,[OrderDate])
		 VALUES
			   ( @OrderNumber
			   , @CustomerNumber
			   , @OrderDate)

GO


DROP PROCEDURE sp_NewOrderDetail
GO

CREATE PROCEDURE sp_NewOrderDetail
@OrderNumber AS varchar(10),
@FlowerID AS varchar(10),
@Quantity AS varchar(10)
AS

	INSERT INTO [veronicas].[SALES].[OrderDetails]
			   ([FlowerID]
			   ,[OrderNumber]
			   ,[Quantity])
		 VALUES
			   (@FlowerID
			   ,@OrderNumber
			   ,@Quantity)


go


--Testing code

DECLARE @NewOrderNumber as varchar(10)
set @NewOrderNumber = '55300'

BEGIN TRY
	BEGIN TRANSACTION
		exec sp_NewOrder @NewOrderNumber, '1', '06/26/2009'
		exec sp_newOrderDetail @NewOrderNumber, 45, 5
		exec sp_newOrderDetail @NewOrderNumber, 14, 45
		exec sp_newOrderDetail @NewOrderNumber, 21, 10
		exec sp_newOrderDetail @NewOrderNumber, 77, 10
	COMMIT TRANSACTION
	select 'Order number ' + @NewOrderNumber + ' was added.' AS [Transaction completed]
	
	
	select * 
    from SALES.Orders 
    where sales.orders.OrderNumber = @NewOrderNumber 

    select * 
    from SALES.OrderDetails 
    where SALES.OrderDetails.OrderNumber = @NewOrderNumber

END TRY
BEGIN CATCH
	ROLLBACK TRANSACTION
	select ERROR_NUMBER() AS ErrorNumber, ERROR_MESSAGE() + ',  ' + 'Transaction was not completed' AS Message
	select 'Order number ' + @NewOrderNumber + ' already exsist.' AS [Transaction failed]
END CATCH


