
select FL.CommonName, OD.quantity, FL.SalesPrice, OD.quantity*FL.SalesPrice as [Item Total]
from sales.orderdetails as OD, sales.Flowers as FL
where OD.OrderNumber = '395' 
and OD.FlowerID = FL.FlowerID


select OD.OrderNumber, sum(OD.quantity*FL.SalesPrice) as [Item Total]
from sales.orderdetails as OD, sales.Flowers as FL
where OD.OrderNumber = '395' 
and OD.FlowerID = FL.FlowerID
group by OD.OrderNumber


IF OBJECT_ID(N'SALES.OrderTotal', N'FN') IS NOT NULL
    DROP FUNCTION SALES.OrderTotal;
GO
CREATE FUNCTION SALES.OrderTotal   -- function name
(@OrderNumber varchar(10))         -- input parameter name and data type
RETURNS smallmoney                 -- return parameter data type
AS
BEGIN                              -- begin body definition

DECLARE @OrderTotal smallmoney     -- Declare a local variable
select @OrderTotal = Total From
	(select OD.OrderNumber, sum(OD.quantity*FL.SalesPrice) as Total
	from sales.orderdetails as OD, sales.Flowers as FL
	where OD.OrderNumber = @OrderNumber 
	and OD.FlowerID = FL.FlowerID
	group by OD.OrderNumber) as OrderTotalValue


RETURN @OrderTotal     
END;
GO


select 'Order Total' as ' ' , SALES.OrderTotal('395') as ' '

