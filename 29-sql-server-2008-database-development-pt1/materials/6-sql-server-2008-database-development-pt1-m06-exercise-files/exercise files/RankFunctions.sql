use veronicas;
go 

select * from SALES.OrderDetails where OrderNumber = '840'
select * from sales.Flowers where FlowerID in (  select flowerID from SALES.OrderDetails where OrderNumber = '840')


select SALES.OrderDetails.OrderNumber, 
       sum( cast(SALES.OrderDetails.Quantity*SALES.Flowers.SalesPrice as smallmoney) ) as OrderTotal
from SALES.Flowers, SALES.OrderDetails
where SALES.Flowers.FlowerID = SALES.OrderDetails.FlowerID --and OrderNumber = '840'
group by OrderNumber
order by OrderTotal desc


with TotalPerOrder (OrderNumber, OrderTotal) as  
(
	select SALES.OrderDetails.OrderNumber, 
		   sum( cast(SALES.OrderDetails.Quantity*SALES.Flowers.SalesPrice as smallmoney) ) as OrderTotal
	from SALES.Flowers, SALES.OrderDetails
	where SALES.Flowers.FlowerID = SALES.OrderDetails.FlowerID
	group by OrderNumber
--	order by OrderTotal desc)
)

SELECT TotalPerOrder.*, 
       NTILE(5) OVER (ORDER BY OrderTotal) AS [Sales Groups]
FROM TotalPerOrder
Order by [Sales Groups] desc, OrderTotal desc
