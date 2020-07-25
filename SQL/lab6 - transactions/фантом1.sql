set transaction isolation level repeatable read
begin transaction
select * from report where quality = 3
select * from report where quality = 3
commit 