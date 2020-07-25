/*
drop table eventExt_index
drop table eventExt

select * into eventExt from event
select * into eventExt_index from event

go
*/
insert into eventExt 
	select name, date, city_id, danger, place, specifity_id from event

insert into eventExt_index
	select name, date, city_id, danger, place, specifity_id from event

go 50000

/*
drop table reportExt
drop table reportExt_index
select * into reportExt from report
select * into reportExt_index from report

go
*/
insert into reportExt
	select * from report

insert into reportExt_index
	select * from report

go 50000

/*
drop table correspExt
drop table correspExt_index
select * into correspExt from correspondent
select * into correspExt_index from correspondent

go
*/
insert into correspExt
	select last_name, first_name, middle_name, birthdate, hire_date, home_address, salary, award, homecity_id, location_id, email, status from correspondent

insert into correspExt_index
	select last_name, first_name, middle_name, birthdate, hire_date, home_address, salary, award, homecity_id, location_id, email, status from correspondent

go 50000