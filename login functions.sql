create or replace procedure show_login_log
		IS
	cursor c is select * from log_in_history ORDER BY log_time DESC;
begin
	for r in c loop
       dbms_output.put_line(to_char(r.eid)|| ' ' || to_char(r.log_time));
    end loop;
end show_login_log;
/



create or replace procedure login_log(emp_id in employee.eid%TYPE)
		IS
begin
		insert into log_in_history (eid) values(emp_id);	
end login_log;
/


create or replace function login(user_name employee.name%TYPE, pass employee.password%TYPE)
	return number
	is
	up employee.password%TYPE;
	emp_id employee.eid%TYPE;
	yes number;

BEGIN  

	--up := 'NONE';
	yes := 0;
	
	select password,eid into up,emp_id from employee where name = user_name;
	
	
	if( up = pass ) then 
		yes := 1;
		login_log(emp_id);	
	end if;
	
	return yes;
	
	exception

		when no_data_found then
		  return yes;
	
END login;
/
