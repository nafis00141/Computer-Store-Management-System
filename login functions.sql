create or replace package log_in_package as
	
	procedure show_login_log;	
	
	procedure login_log(emp_id in employee.eid%TYPE);
	
	function login(user_name employee.name%TYPE, pass employee.password%TYPE)
		return number;
		
	function logout(emp_id employee.eid%TYPE)
		return number;
	
end log_in_package;
/

create or replace package body log_in_package as

	procedure show_login_log
		IS
		cursor c is select * from log_in_history ORDER BY log_time DESC;
	begin
		for r in c loop
		   dbms_output.put_line(to_char(r.eid)|| ' ' || to_char(r.log_time) || ' ' || to_char(r.status));
		end loop;
	end show_login_log;
	

	procedure login_log(emp_id in employee.eid%TYPE)
		IS
	begin
		insert into log_in_history (eid,status) values(emp_id,0);	
	end login_log;
	
	
	function login(user_name employee.name%TYPE, pass employee.password%TYPE)
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
	
	function logout(emp_id employee.eid%TYPE)
		return number
		is
		yes number;
	BEGIN  

		yes := 0;
		
		update log_in_history set status = 1 where eid = emp_id and status = 0;
		
		yes := 1;
		
		return yes;
		
		exception

			when no_data_found then
			  return yes;
		
	END logout;

end log_in_package;
/