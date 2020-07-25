
create trigger log_trig1
on all server after logon as

insert into logs1 values(original_login(), getdate())

