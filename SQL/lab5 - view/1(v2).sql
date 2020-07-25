create view info1 as
with tab1 as
	(select correspondent_id, avg(1.0*report_amnt) as avg_per_month
		from (select correspondent_id, count(event_id) as report_amnt, month([date]) as month, year([date]) as year
				from report
				group by correspondent_id, month([date]), year([date]) ) tab2
		group by correspondent_id )

select first_name, last_name, avg(1.0*danger) as avg_danger, avg_per_month
	from correspondent join tab1 on correspondent.correspondent_id = tab1.correspondent_id 
					   join report on correspondent.correspondent_id = report.correspondent_id 
					   join event on report.event_id = event.event_id
	group by correspondent.correspondent_id, first_name, last_name, avg_per_month