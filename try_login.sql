set serveroutput on;
declare
	user_name employee.name%TYPE := 'Swapnil';
	pass employee.password%TYPE := '1234';
	emp_id employee.eid%TYPE := 1;
	res number;
begin
	res := log_in_package.login(user_name,pass);
	
	IF res = 1 then
		dbms_output.put_line('Logged IN');
		dbms_output.put_line('Welcome ' || to_char(user_name));
	ELSE 
		dbms_output.put_line('User Name or Password Does Not Exist');
	END IF;

	log_in_package.show_login_log;
	
	res := log_in_package.logout(emp_id);
	
	IF res = 1 then
		dbms_output.put_line('Logged OUT ');
	ELSE 
		dbms_output.put_line('NOT logged IN');
	END IF;
	
end;
/

