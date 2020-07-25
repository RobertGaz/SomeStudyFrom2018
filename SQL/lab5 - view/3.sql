
create view info3 as
(select report.date, newscast_time, first_name, last_name, duration as duration_seconds
	from report join correspondent on report.correspondent_id = correspondent.correspondent_id )