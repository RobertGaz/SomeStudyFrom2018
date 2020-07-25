/*«а каждые 10 сюжетов повышенной сложности зарплата корреспондента повышаетс€ в 1.4 раза, за каждые 10 пониженной уменьшаетс€, если была увеличена.*/

	
create trigger SalaryUpdate
on salary after insert as

	with prev_salary as
	(select salary.correspondent_id, danger_award, salary_value from 
		(select salary.correspondent_id, max(salary.date) as max_date
			from salary join (select salary_id
								from salary
								where salary_id not in (select salary_id from inserted)) tab2
						on salary.salary_id = tab2.salary_id 
			group by salary.correspondent_id) tab3
		join salary on tab3.correspondent_id = salary.correspondent_id and tab3.max_date = salary.date )
	
	
	update salary 
		set salary_value = (select salary_value from prev_salary where correspondent_id = salary.correspondent_id)
				* power(cast(1.4 as float), (select dbo.upzero((select danger_award from inserted where correspondent_id = salary.correspondent_id)))
				
																		- (select dbo.upzero((select danger_award from prev_salary where correspondent_id = salary.correspondent_id))))
		where salary_id in (select salary_id from inserted)
	


	declare @cur_sal_id int = (select min(salary_id) from inserted);
	declare @max_sal_id int = (select max(salary_id) from inserted);

	while @cur_sal_id <= @max_sal_id
	begin

		with prev_salary as
			(select salary.correspondent_id, danger_award, salary_value from 
				(select salary.correspondent_id, max(salary.date) as max_date
					from salary join (select salary_id
							from salary
								where salary_id not in (select salary_id from inserted)) tab2
						on salary.salary_id = tab2.salary_id 
			group by salary.correspondent_id) tab3
		join salary on tab3.correspondent_id = salary.correspondent_id and tab3.max_date = salary.date )

		insert into salary_report
			select salary_id, report_id
			from 
			(select salary_id, report_id 
				from inserted join report on inserted.correspondent_id = report.correspondent_id 
				where report_id not in (select top (select count(*)%10 from report where correspondent_id = inserted.correspondent_id) report_id
											from report 
											where correspondent_id = inserted.correspondent_id
											order by report_id desc)

						and report_id in (select top ((select count(*)%10 from report where correspondent_id = inserted.correspondent_id) + danger_award*10) report_id
											from report
											where correspondent_id = inserted.correspondent_id
											order by report_id desc) ) tab
			
				
			where salary_id = @cur_sal_id 
				and salary_id in (select salary_id 
									from inserted join prev_salary on inserted.correspondent_id = prev_salary.correspondent_id
									where inserted.danger_award != prev_salary.danger_award)
			set @cur_sal_id = @cur_sal_id + 1
	end