with dang_now as 
(select correspondent_id, count(report.event_id) as dang_amnt
	from report join event on report.event_id = event.event_id
	where danger > 1
	group by correspondent_id)

select * from dang_now join correspondent_table on correspondent_table.correspondent_id = dang_now.correspondent_id;

with usual_now as
(select correspondent_id, count(report.event_id) as usual_amnt
	from report join event on report.event_id = event.event_id
	where danger <= 1
	group by correspondent_id)

select * from usual_now join correspondent_table on correspondent_table.correspondent_id = usual_now.correspondent_id
