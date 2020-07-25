select tab1.name as [trigger], tab2.name as [table]
	from sysobjects tab1 join sysobjects tab2 on tab1.parent_obj = tab2.id 
						 join sysusers on tab1.uid = sysusers.uid
	where tab1.xtype = 'TR' 
		  and sysusers.name = 'dbo'