select event.name, duration as duration_in_seconds, first_name, last_name 
	from report join event on report.event_id = event.event_id 
				join correspondent on correspondent.correspondent_id = report.correspondent_id
	where report.date = '22/11/2018' and report.newscast_time = '20:30'
