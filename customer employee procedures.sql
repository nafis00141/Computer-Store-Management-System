create or replace package customer_employee_package as
	
	procedure add_employee(nam in employee.name%TYPE,
						   num in employee.numbers%TYPE,
						   pass in employee.password%TYPE);

	
	procedure add_customer(nam in customer.name%TYPE,
						   num in customer.numbers%TYPE);	
	
end customer_employee_package;
/


create or replace package body customer_employee_package as

		
	procedure add_employee(nam in employee.name%TYPE,
						   num in employee.numbers%TYPE,
						   pass in employee.password%TYPE)
		IS
	begin
		insert into employee(name,numbers,password) values(nam,num,pass);	
	end add_employee;
	
	
	procedure add_customer(nam in customer.name%TYPE,
						   num in customer.numbers%TYPE)
		IS
	begin
		insert into customer(name,numbers) values(nam,num);	
	end add_customer;
	

end customer_employee_package;
/