
select ordernumber as "Order Number", firstname as "First", 
lastname as "Last",  names.CommonName as "Flower"
from sales.Customers as c, 
   (select ords.CustomerNumber, flowernames.OrderNumber,  
    FlowerNames.CommonName from SALES.Orders as ords, 
       (select CommonName, so.OrderNumber 
        from SALES.Flowers as sf , SALES.OrderDetails as so
        where sf.FlowerID = so.FlowerID) as FlowerNames
    where ords.OrderNumber = FlowerNames.OrderNumber) as names
where c.CustomerNumber = names.CustomerNumber
order by lastname, firstname, ordernumber