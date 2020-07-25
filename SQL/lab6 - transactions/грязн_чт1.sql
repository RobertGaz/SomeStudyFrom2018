set transaction isolation level read uncommitted
begin transaction
select * from report where correspondent_id = 2 and event_id = 1
select * from report where correspondent_id = 2 and event_id = 1
select * from report where correspondent_id = 2 and event_id = 1
commit