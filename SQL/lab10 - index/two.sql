select * from reportExt join eventExt on reportExt.event_id = eventExt.event_id 
						join correspExt on reportExt.correspondent_id = correspExt.correspondent_id