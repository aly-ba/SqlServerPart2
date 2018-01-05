select OrderInfo.OrderNumber, sf.CommonName, sf.SalesPrice, OrderInfo.Quantity, cast (OrderInfo.Quantity*sf.Salesprice as smallmoney) as SubTotal
from SALES.Flowers as SF,
	(select cod.OrderNumber,  COD.FlowerID, COD.Shipdate ,COD.Quantity
	from SALES.OrderDetails as COD, 
		(select SO.OrderNumber 
		from sales.Customers as SC, sales.orders as SO 
		where SC.CustomerNumber = '5'
		and SC.CustomerNumber = SO.CustomerNumber) as CO
	where COD.OrderNumber = CO.OrderNumber) as OrderInfo
where SF.FlowerID = OrderInfo.FlowerID
order by orderinfo.OrderNumber DESC
--compute sum (cast (OrderInfo.Quantity*sf.Salesprice as smallmoney)) by orderinfo.ordernumber 
--compute sum (cast (OrderInfo.Quantity*sf.Salesprice as smallmoney))
go

