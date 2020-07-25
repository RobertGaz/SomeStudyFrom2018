
	
create view correspondent as

	with cur_salary as
	(select salary.correspondent_id, salary.salary_value as salary, salary.danger_award as danger_award 
		from (select correspondent_id, max(date) as max_date
				from salary
				group by correspondent_id) tab1
			 join salary on tab1.correspondent_id = salary.correspondent_id and tab1.max_date = salary.date )

	select correspondent_table.correspondent_id, last_name, middle_name, birthdate, hire_date, home_address, homecity_id, location_id, email, status, salary, danger_award
		from correspondent_table join cur_salary on correspondent_table.correspondent_id = cur_salary.correspondent_id