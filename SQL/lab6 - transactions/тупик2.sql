set transaction isolation level repeatable read
begin transaction
select * from report where correspondent_id = 1 and event_id = 4
update report set duration = 300 where correspondent_id = 1 and event_id = 3
commit