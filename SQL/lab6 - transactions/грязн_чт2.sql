set transaction isolation level read uncommitted
begin transaction
update report set operator_id = 2 where correspondent_id = 2 and event_id = 1
rollback