set serveroutput on;
declare
	emp_id employee.eid%TYPE := 1;
    cus_id customer.cid%TYPE := 2;
	res number;
begin
	res := cart_sell_package.sell(emp_id,cus_id);
	
	IF res = 1 then
		dbms_output.put_line('Sold');
	ELSIF res = 2 then
		dbms_output.put_line('Nothing to sell');
	ELSE
		dbms_output.put_line('NOT FOUND Problem');
	END IF;

end;
/