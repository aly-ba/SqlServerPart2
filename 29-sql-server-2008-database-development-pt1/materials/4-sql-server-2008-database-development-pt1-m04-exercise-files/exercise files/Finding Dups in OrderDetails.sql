--Finding dups in OrderDeatils

select (OrderNumber + ' ' + flowerid) as allFields, count(OrderNumber + ' ' + flowerid) as cnt
from sales.OrderDetails as totalList
group by (OrderNumber + ' ' + flowerid)
HAVING ( COUNT(OrderNumber + ' ' + flowerid) > 0 )