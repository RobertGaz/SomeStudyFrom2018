select sysobjects.name as [table], syscolumns.name as [column], isnullable, systypes.name as [type], systypes.length as [size]
	from sysobjects join syscolumns on sysobjects.id = syscolumns.id 
					join systypes on syscolumns.xtype = systypes.xtype 
					join sysusers on sysobjects.uid = sysusers.uid
	where sysobjects.xtype = 'U' and sysusers.name = 'dbo' 