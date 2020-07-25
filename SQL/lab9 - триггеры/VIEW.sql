create trigger SalaryInfo
on salary after insert as

	with last_award as
	(select award.correspondent_id, danger_value from 
		(select correspondent_id, max(date) as max_date
			from award
			group by correspondent_id) tab1
		join award on tab1.correspondent_id = award.correspondent_id and tab1.max_date = award.date )

	update salary set info = 
	 'Премия: ' + cast(value - value/power(cast(1.4 as float), (select danger_value 
																from last_award 
																where correspondent_id = salary.correspondent_id)) as varchar(10)) + 
		' за ' + cast((select danger_value 
						from last_award 
						where correspondent_id = salary.correspondent_id)*10 as varchar(10)) +
		'сюжетов повышенной опасности.'
		where correspondent_id in (select correspondent_id from inserted) and date in (select date from inserted) 