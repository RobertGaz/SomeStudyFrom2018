with tab as
(select correspondent_id, avg(1.0 * datediff(day, event.date, report.date)) as avg_days
	from report join event on report.event_id = event.event_id
	group by correspondent_id )

select substring(first_name + ' ' + last_name, 1, 60) as name, avg_days
	from tab join correspondent on tab.correspondent_id = correspondent.correspondent_id
	
