select event.name, danger, place, city.name, isnull(reports_amnt, 0) as reports_amnt
	from event left join (select event_id, count(event_id) as reports_amnt
						from report 
						group by event_id ) tab on event.event_id = tab.event_id
			   join city on event.city_id = city.city_id
	order by (reports_amnt) desc