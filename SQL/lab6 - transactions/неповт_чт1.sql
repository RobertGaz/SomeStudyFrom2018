set transaction isolation level read committed
begin transaction
select * from report where correspondent_id = 1 and event_id = 3
select * from report where correspondent_id = 1 and event_id = 3
commit