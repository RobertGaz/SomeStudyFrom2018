delete from specifity
	where specifity_id not in (select specifity_id from event)