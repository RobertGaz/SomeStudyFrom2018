update telephone 
	set telephone = '+78124325566'
	where correspondent_id in (select correspondent_id
								from correspondent
								where last_name = 'Шпренсон' and first_name = 'Уран' )
