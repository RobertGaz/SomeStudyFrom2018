set transaction isolation level read uncommitted
begin transaction
update report set rating = 2 where correspondent_id = 2 and event_id = 6
commit