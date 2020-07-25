select name, regional_group as city, avg_exp
	from department join location on department.location_id=location.location_id join 
	(select department_id,  avg(1.0*experience) as avg_exp 
		from (select department_id, datediff(day, hire_date, getdate()) as experience from employee) a
		group by department_id) yo on department.department_id=yo.department_id
	order by avg_exp desc