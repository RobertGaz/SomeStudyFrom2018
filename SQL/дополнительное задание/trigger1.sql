/*«а каждые 10 сюжетов повышенной сложности зарплата корреспондента повышаетс€ в 1.4 раза, за каждые 10 пониженной уменьшаетс€, если была увеличена.*/

create trigger AwardUpdate
on report after insert as
	
	with 
	dang_inserted as 
	(select correspondent_id, count(danger) as amnt
		from inserted join event on inserted.event_id = event.event_id
		where danger > 1
		group by correspondent_id),

	dang_now as
	(select correspondent_id, count(report.event_id) as amnt
		from report join event on report.event_id = event.event_id
		where danger > 1
		group by correspondent_id),
	
	dang_diff as
	(select dang_now.correspondent_id, dang_now.amnt/10 - (dang_now.amnt - dang_inserted.amnt)/10 as amnt
		from dang_now join dang_inserted on dang_now.correspondent_id = dang_inserted.correspondent_id),
	
	prev_award as
	(select salary.correspondent_id, danger_award from 
		(select correspondent_id, max(date) as max_date
			from salary
			group by correspondent_id) tab1
		join salary on tab1.correspondent_id = salary.correspondent_id and tab1.max_date = salary.date )

	 
	insert into salary(correspondent_id, danger_award)
	select prev_award.correspondent_id, danger_award + amnt
		from prev_award join dang_diff on prev_award.correspondent_id = dang_diff.correspondent_id
		where amnt > 0;

	
	with usual_inserted as
	(select correspondent_id, count(inserted.event_id) as amnt
		from inserted join event on inserted.event_id = event.event_id
		where danger <= 1
		group by correspondent_id),

	usual_now as
	(select correspondent_id, count(report.event_id) as amnt
		from report join event on report.event_id = event.event_id
		where danger <= 1
		group by correspondent_id),

	usual_diff as
	(select usual_now.correspondent_id, usual_now.amnt/10 - (usual_now.amnt - usual_inserted.amnt)/10 as amnt
		from usual_now join usual_inserted on usual_now.correspondent_id = usual_inserted.correspondent_id),


	prev_award as
	(select salary.correspondent_id, danger_award from 
		(select correspondent_id, max(date) as max_date
			from salary
			group by correspondent_id) tab1
		join salary on tab1.correspondent_id = salary.correspondent_id and tab1.max_date = salary.date )

	
	insert into salary(correspondent_id, danger_award)
	select prev_award.correspondent_id, dbo.upzero(danger_award - amnt)
		from prev_award join usual_diff on prev_award.correspondent_id = usual_diff.correspondent_id
		where amnt > 0 and dbo.upzero(danger_award - amnt) != (select danger_award from prev_award where correspondent_id = usual_diff.correspondent_id)
															--выборка ровно из одного значени€
