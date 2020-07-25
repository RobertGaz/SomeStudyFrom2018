select first_name, last_name, avg_rating
	from (select top 1 with ties correspondent_id, avg(1.0*rating) as avg_rating
			from report
			group by correspondent_id 
			order by avg_rating desc) tab join correspondent on tab.correspondent_id = correspondent.correspondent_id
										  join city on correspondent.homecity_id = city.city_id
	where city.name = 'Москва'