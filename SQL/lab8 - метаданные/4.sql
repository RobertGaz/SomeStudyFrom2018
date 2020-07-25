select tab1.name as foreign_key, tab2.name as [table], tab3.name as [parent_table]
	from sysreferences  join sysobjects tab1 on sysreferences.constid = tab1.id 
						join sysobjects tab2 on sysreferences.fkeyid = tab2.id
						join sysobjects tab3 on sysreferences.rkeyid = tab3.id
						join sysusers on tab1.uid = sysusers.uid
	where sysusers.name = 'dbo'