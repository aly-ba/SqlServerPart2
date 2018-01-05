Customer code of for Sproc example.  Not done yet.


use veronicas
go 

Select 
    SALES.Customers.CustomerNumber,
	SALES.Customers.FirstName, 
	SALES.Customers.LastName, 
	SALES.Customers.Address, 
	SALES.Customers.City, 
	SALES.Customers.State, 
	SALES.Customers.Zip
from SALES.Customers
where SALES.Customers.CustomerNumber = '722'

select SALES.Orders.* 
from sales.orders inner join sales.orderdetails
where sales.orders.ordernumber = sales.orderdetails.ordernumber
and sales.orders.customernumber = '722'

select * from sales.Orders where ordernumber = '1020'

--select SALES.ORDERS.* from sales.orders
--group by cast(customernumber as int)
--order by cast(customernumber as int)