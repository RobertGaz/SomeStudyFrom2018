select tab1.name, tab1.xtype, tab2.name as [table], sysusers.name as username
	from sysobjects tab1 join sysobjects tab2 on tab1.parent_obj = tab2.id join sysusers on tab2.uid = sysusers.uid
	where tab1.xtype = 'PK' or tab1.xtype = 'F'