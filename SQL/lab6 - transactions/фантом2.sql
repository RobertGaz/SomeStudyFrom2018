set transaction isolation level repeatable read
begin transaction
/*update report set quality = 2 where quality = 3 and duration < 240 */
insert into report values(1, 2, 10, 229, 3, '2017-10-16', '19:00', 1, 3.50)
commit