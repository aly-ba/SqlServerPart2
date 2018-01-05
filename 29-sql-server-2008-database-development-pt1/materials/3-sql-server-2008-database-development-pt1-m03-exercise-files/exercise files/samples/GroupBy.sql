use veronicas
go

select customernames.CustomerNumber,CustomerNames.Name,
       COUNT(*) [Total Orders]
from 
(
SELECT [CustomerNumber]
      ,[FirstName] + ' ' + [LastName] as Name
  FROM [veronicas].[SALES].[Customers]
) as CustomerNames

, SALES.Orders
where CustomerNames.CustomerNumber = SALES.Orders.CustomerNumber 
group by customernames.CustomerNumber , customernames.Name
having count(*)  >= 2
order by customernames.Name  desc