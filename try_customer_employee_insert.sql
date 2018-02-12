set serveroutput on;
declare
	nam_emp employee.name%TYPE := 'Sajid';
	num_emp employee.numbers%TYPE := 01711925689;
	pass_emp employee.password%TYPE := 9874;
	
	nam_cus customer.name%TYPE := 'Faiza';
	num_cus customer.numbers%TYPE := 01685025656;

	
begin
	customer_employee_package.add_employee(nam_emp,num_emp,pass_emp);
	
	dbms_output.put_line('employee added ' || to_char(nam_emp));
	
	customer_employee_package.add_customer(nam_cus,num_cus);
	
	dbms_output.put_line('customer added ' || to_char(nam_cus));
	
	

end;
/

commit;