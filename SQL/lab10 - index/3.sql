set statistics time on
set statistics io on

checkpoint
go
dbcc dropcleanbuffers
go

select * from eventExt
	where place = '�����' and city_id = 5

select * from eventExt_index
	where place = '�����' and city_id = 5

go

set statistics io off
set statistics time off