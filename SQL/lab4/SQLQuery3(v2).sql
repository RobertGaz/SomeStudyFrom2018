with tab1 as 
(select correspondent_id, avg(1.0*duration) as avg_duration, avg(1.0*danger) as avg_danger
	from report join event on report.event_id = event.event_id
	group by correspondent_id ),

tab2 as
(select correspondent_id, avg(1.0*report_amnt) as avg_per_month
	from (select correspondent_id, count(event_id) as report_amnt, month([date]) as month, year([date]) as year
			from report
			group by correspondent_id, month([date]), year([date]) ) tab3
	group by correspondent_id )

select first_name, last_name, country.name as country, avg_duration, avg_per_month, avg_danger
	from tab1 join tab2 on tab1.correspondent_id = tab2.correspondent_id
			  join correspondent on tab1.correspondent_id = correspondent.correspondent_id
			  join city on correspondent.homecity_id = city.city_id
			  join country on city.country_id = country.country_id
	order by country asc