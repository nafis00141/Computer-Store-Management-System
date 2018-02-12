
create or replace package transfer_package as
	
	procedure show_request;
	
	function add_request(pro_code request.product_code%TYPE,
						 sent_to_br request.send_to_branch%TYPE,
						 emp_id request.eid_req%TYPE)
		return number;

	
	function transfer(req_id request.rid%TYPE,emp_id request.eid_done%TYPE)
		return number;
	
end transfer_package;
/

create or replace package body transfer_package as

	procedure show_request
		IS
		cursor c is select * from request ORDER BY rid DESC;
	begin
		dbms_output.put_line('req_id   pro_code    emp_who_req   br_to_send   loc_at  status   emp_who_trans');
		dbms_output.put_line('------------------------------------------------------------------------------');
		for r in c loop
		   dbms_output.put_line(to_char(r.rid)|| '      ' || to_char(r.product_code) || '      ' || to_char(r.eid_req)|| '       ' || to_char(r.send_to_branch)
		   || '      ' || to_char(r.at_branch) || '      ' || to_char(r.status) || '       ' || to_char(r.eid_done));
		end loop;
	end show_request;

	--returns 0 when pro_code not found
	--returns 1 when request is added
	function add_request(pro_code request.product_code%TYPE,
						 sent_to_br request.send_to_branch%TYPE,
						 emp_id request.eid_req%TYPE)
		return number
		is
		yes number;
		br product_info.branch%TYPE;
	begin
		yes :=0;
		
		select branch into br from product_info where product_code = pro_code;
		
		insert into request(product_code,eid_req,send_to_branch,at_branch,status,eid_done) values(pro_code,emp_id,sent_to_br,br,0,null);
		
		yes := 1;
		
		return yes;
		
		exception

			when no_data_found then
			  return yes;
		

	end add_request;

	
	--returns 0 when req_id not found
	--returns 1 when successfully transfered
	function transfer(req_id request.rid%TYPE,emp_id request.eid_done%TYPE)
		return number
		is
		yes number;
		br request.send_to_branch%TYPE;
		pro_code request.product_code%TYPE;
	begin
		yes :=0;
		
		select send_to_branch,product_code into br,pro_code from request where rid = req_id;
		
		update product_info set branch = br where product_info.product_code = pro_code;
		
		update request set status = 1 where rid = req_id;
		
		update request set eid_done = emp_id where rid = req_id;
		
		yes := 1;
		
		return yes;
		
		exception

			when no_data_found then
			  return yes;
		

	end transfer;

end transfer_package;
/