set serveroutput on;
declare
	user_name employee.name%TYPE := 'Swapnil';
	pass employee.password%TYPE := '1234';
	res number;
begin
	res := login(user_name,pass);
	
	IF res = 1 then
		dbms_output.put_line('Logged IN');
		dbms_output.put_line('Welcome ' || to_char(user_name));
	ELSE 
		dbms_output.put_line('User Name or Password Does Not Exist');
	END IF;

	show_login_log;
	
end;
/

