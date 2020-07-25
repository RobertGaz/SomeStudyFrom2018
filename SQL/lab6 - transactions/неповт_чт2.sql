set transaction isolation level read committed
begin transaction
update report set newscast_time = '16:45'
	where correspondent_id = 1 and event_id = 3
commit