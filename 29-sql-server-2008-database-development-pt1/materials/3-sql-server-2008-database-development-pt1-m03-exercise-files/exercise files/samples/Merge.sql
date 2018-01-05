

use veronicas
go

Merge veronicas.sales.OrderStatus as target
using (Select FlowerID, OrderNumber, Quantity from Sales.OrderDetails) as source
(FlowerID, OrderNumber, Quantity)
on (target.OrderNumber = source.OrderNumber and target.flowerID = source.flowerID)
when Matched and Target.Unshipped <= 0
Then Delete
When Matched and Target.Unshipped > 0
Then Update set target.Unshipped -= 1
output inserted.FlowerID as [Inserted FlowerID], Inserted.OrderNumber as [Inserted OrderNumber], Inserted.Unshipped, 
       Deleted.FlowerID as [Deleted FlowerID], Deleted.OrderNumber as [Deleted OrderNumber];
go


select * from veronicas.SALES.OrderStatus
where FlowerID = 168 and OrderNumber = 963