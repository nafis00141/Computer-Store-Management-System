set serveroutput on;
declare
	pro_code request.product_code%TYPE:=1208;
	sent_to_br request.send_to_branch%TYPE:='Dhanmondi';
	emp_req_id request.eid_req%TYPE:=2;
	req_id request.rid%TYPE:=1;
	emp_tra_id request.eid_done%TYPE:=1;
	res number;
begin
	res := transfer_package.add_request(pro_code,sent_to_br,emp_req_id);
	
	IF res = 1 then
		dbms_output.put_line('Request added');
		transfer_package.show_request;
	ELSE
		dbms_output.put_line('product code not found');
	END IF;
	
	res := transfer_package.transfer(req_id,emp_tra_id);

	IF res = 1 then
		dbms_output.put_line('Transfered');
		transfer_package.show_request;
	ELSE
		dbms_output.put_line('req_id not found');
	END IF;
	
end;
/

commit;