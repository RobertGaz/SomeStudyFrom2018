
select name, avg_sum, deals_amnt
	from customer join (select customer_id, sum(total)/count(distinct year(order_date)) as avg_sum, count(order_id) as deals_amnt
							from sales_order
							group by customer_id) info 
					on customer.customer_id=info.customer_id
	where deals_amnt>0
	order by avg_sum desc