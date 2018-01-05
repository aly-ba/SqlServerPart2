select firstname, lastname, phone, address, State
from SALES.Customers
where state = 'IL' and LastName like 'a%'
order by LastName, FirstName


select CommonName, so.OrderNumber
from SALES.Flowers as sf, SALES.OrderDetails as so
where sf.FlowerID = so.FlowerID