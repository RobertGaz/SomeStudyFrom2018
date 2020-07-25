create view info2 as
with tab1 as
(select month(report.date) as month_mon, year(report.date) as year_mon, event.city_id as cityid, count(report.event_id) as reports_amnt, avg(duration) as avg_duration
	from report join event on report.event_id = event.event_id
	group by month(report.date), year(report.date), event.city_id)

select month_mon, year_mon, city.name as city, reports_amnt, avg_duration, first_name, last_name
	from tab1 join city on tab1.cityid = city.city_id cross join correspondent
	where correspondent_id in 
	(select correspondent_id from
	 (select top 1 correspondent_id, count(correspondent_id) as amnt
		from report join event on report.event_id = event.event_id
		group by correspondent_id, month(report.date), year(report.date), event.city_id
		having month(report.date) = tab1.month_mon and year(report.date) = tab1.year_mon and event.city_id = tab1.cityid
		order by amnt desc) tab2 )
