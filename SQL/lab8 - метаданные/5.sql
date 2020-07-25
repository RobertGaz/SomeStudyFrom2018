select sysobjects.name, text
	from sysobjects join sysusers on sysobjects.uid = sysusers.uid
					join syscomments on sysobjects.id = syscomments.id
	where xtype = 'V' and sysusers.name = 'dbo'