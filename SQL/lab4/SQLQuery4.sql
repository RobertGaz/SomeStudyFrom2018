with corr as
(select corr_spec.specifity_id as specifity_id, country.country_id as country_id, count(corr_spec.correspondent_id) as corr_amnt
		from
		correspondent join corr_spec on correspondent.correspondent_id = corr_spec.correspondent_id
					  join specifity on corr_spec.specifity_id = specifity.specifity_id
					  join city on correspondent.homecity_id = city.city_id
					  join country on city.country_id = country.country_id
		group by corr_spec.specifity_id, country.country_id ),
		
dur as
(select specifity_id, country.country_id as country_id, avg(1.0*duration) as avg_duration
	from
	event join city on event.city_id = city.city_id 
		  join country on city.country_id = country.country_id
		  join report on event.event_id = report.event_id
	group by specifity_id, country.country_id )

select country.name, specifity.name, isnull(avg_duration, 0) as avg_duration, isnull(corr_amnt, 0) as corr_amnt
from
(select isnull(corr.country_id, dur.country_id) as corr_country_id, isnull(dur.country_id, corr.country_id) as dur_country_id, isnull(corr.specifity_id, dur.specifity_id) as corr_specifity_id, isnull(dur.specifity_id, corr.specifity_id) as dur_specifity_id, avg_duration, corr_amnt 
	from corr full outer join dur on corr.country_id = dur.country_id and corr.specifity_id = dur.specifity_id ) tab join country on tab.corr_country_id = country.country_id
																													 join specifity on tab.corr_specifity_id = specifity.specifity_id