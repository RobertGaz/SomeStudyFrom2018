select description, amnt, money 
from
product join
(select product.product_id, count(order_id) as amnt, sum(total) as money
	from item join product on item.product_id = product.product_id
	group by product.product_id) a on product.product_id = a.product_id 
where description like '%WIFF%'