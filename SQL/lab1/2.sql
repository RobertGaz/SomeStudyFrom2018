select * from (select name, regional_group as city, max_difference
	from department join location on department.location_id=location.location_id 
	join (select department_id, max(mng_salary-salary) as max_difference 
			from employee join (select employee_id, salary as mng_salary from employee) mng on employee.manager_id=mng.employee_id
			where manager_id is not null
			group by department_id) dop
		on department.department_id=dop.department_id 
	where max_difference>1500
	order by max_difference desc) as n