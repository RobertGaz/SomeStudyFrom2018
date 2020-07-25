drop index ix_place on eventExt_index 
create nonclustered index ix_place on eventExt_index (place asc, city_id asc)