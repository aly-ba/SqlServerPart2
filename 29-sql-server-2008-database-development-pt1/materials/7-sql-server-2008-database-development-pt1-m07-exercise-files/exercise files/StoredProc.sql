-- ================================================
-- Template generated from Template Explorer using:
-- Create Procedure (New Menu).SQL
--
-- Use the Specify Values for Template Parameters 
-- command (Ctrl-Shift-M) to fill in the parameter 
-- values below.
--
-- This block of comments will not be included in
-- the definition of the procedure.
-- ================================================
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Haynes, Mel
-- Create date: June, 17, 2009
-- Description:	Returns all orders for a given customer
-- =============================================
CREATE PROCEDURE sales.GetOrdersForCustomer 
	-- Add the parameters for the stored procedure here
	@CustomerNumber varchar(10)  
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	select OrderInfo.OrderNumber, --This select gives the product name, price and calculates the subtotal for the order details provided.
	       sf.CommonName, 
	       sf.SalesPrice, 
	       OrderInfo.Quantity, 
	       cast (OrderInfo.Quantity*sf.Salesprice as smallmoney) as SubTotal
    from SALES.Flowers as SF,
	                        (select COD.OrderNumber,  -- This select looks up all the order details for a list of order numbers.
	                                COD.FlowerID, 
	                                COD.Shipdate, 
	                                COD.Quantity
	                         from SALES.OrderDetails as COD, 
		                                                    (select SO.OrderNumber -- This select given a customer number returns all the order numbers
		                                                     from sales.Customers as SC, sales.orders as SO 
		                                                     where SC.CustomerNumber = @CustomerNumber
		                                                     and SC.CustomerNumber = SO.CustomerNumber) as CO
	                         where COD.OrderNumber = CO.OrderNumber) as OrderInfo
    where SF.FlowerID = OrderInfo.FlowerID
    order by orderinfo.OrderNumber DESC
END
GO


execute sales.GetOrdersForCustomer '5'