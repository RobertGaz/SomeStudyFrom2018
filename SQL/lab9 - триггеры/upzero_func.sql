create function upzero (@val int)
returns int 
as 
begin
	if @val > 0 
		return @val;
	return 0;
end
