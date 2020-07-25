create view info4 as
with tab1 as
(select specifity_id, avg(duration) as avg_duration
	from report join event on report.event_id = event.event_id
	group by specifity_id ),

tab2 as
(select specifity_id, count(corr_spec.correspondent_id) as corr_amnt, avg(salary) as avg_salary
	from corr_spec join correspondent on corr_spec.correspondent_id = correspondent.correspondent_id
	group by corr_spec.specifity_id )

select specifity.name, corr_amnt, avg_salary, avg_duration
	from tab1 join tab2 on tab1.specifity_id = tab2.specifity_id
			  join specifity on tab1.specifity_id = specifity.specifity_id