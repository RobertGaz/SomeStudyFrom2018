select sysobjects.name 
	from sysobjects join sysusers on sysobjects.uid = sysusers.uid
	where sysusers.name = 'test/test' and xtype = 'U'
	