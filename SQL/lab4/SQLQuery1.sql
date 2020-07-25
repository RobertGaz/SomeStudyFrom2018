select event.name, last_name, first_name, duration as duration_in_seconds
	from   correspondent join report on correspondent.correspondent_id = report.correspondent_id 
						 join event on event.event_id = report.event_id
	where event.city_id in (select city_id from city where name = 'Москва') and year(report.date) = 2018