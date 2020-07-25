
create view award_info as
select correspondent_id, last_name + ' ' + first_name + ' ' + middle_name + ', ¬аша преми€ составл€ет: ' + cast(salary - salary/power(cast(1.4 as float), danger_award) as varchar(10)) + '. ѕреми€ назначена за то, что сюжетов повышенной сложности больше, чем обычных на ' + cast(danger_award*10 as varchar(10))+ '.' as info
	from correspondent
	where cast(correspondent_id as varchar(10)) = cast(current_user as varchar(10)) 

create view all_award_info as
select last_name, first_name, middle_name, 'ѕреми€: ' + cast(salary - salary/power(cast(1.4 as float), danger_award) as varchar(10)) + ', назначена за то, что сюжетов повышенной сложности больше, чем обычных на ' + cast(danger_award*10 as varchar(10))+ '.' as info
	from correspondent

