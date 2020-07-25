create user [1] for login [corr_1]
	with default_schema = [dbo]

alter role [correspondent_role] add member [2]

create user [2] for login [corr_2]
	with default_schema = [dbo]

alter role [correspondent_role] add member [2]

create user [boss] for login [boss]
	with default_schema = [dbo]

alter role [boss_role] add member [boss]