
create or replace package cart_sell_package as
	
	procedure show_cart;
	
	procedure empty_cart;
	
	function add_to_cart(pro_code product_info.product_code%TYPE)
		return number;
		
	function delete_from_cart(pro_code product_info.product_code%TYPE)
		return number;
	
	procedure show_recept(purch_id in purchase.purchase_id%TYPE);
	
	function sell(emp_id employee.eid%TYPE , cus_id customer.cid%TYPE)
		return number;
	
end cart_sell_package;
/


create or replace package body cart_sell_package as

	procedure show_cart
		IS
		cursor c is select * from temp;
		total temp.sellprice%TYPE;
	begin
		dbms_output.put_line('CART');
		dbms_output.put_line('product_id    product_code     buyprice   sellprice');
		dbms_output.put_line('---------------------------------------------------');
		for r in c loop
		   dbms_output.put_line(to_char(r.pid)|| '               ' || to_char(r.product_code) || '          ' || to_char(r.buyprice) || '          ' || to_char(r.sellprice));
		   --dbms_output.put_line(to_char(r.pid));
		end loop;
		
		select SUM(sellprice) into total from temp;
		
		dbms_output.put_line('TOTAL : ' || to_char(total));
		
	end show_cart;

	
	procedure empty_cart
		IS
	begin
		execute immediate 'TRUNCATE TABLE temp';
		dbms_output.put_line('Cart Empted');
	end empty_cart;
	
	
	-- returns 1 when successfully added
	-- returns 0 when product not found
	-- returns 2 when same product is added 2 times
	function add_to_cart(pro_code product_info.product_code%TYPE)
		return number
		is

		ppid product_info.pid%TYPE;
		buy product_info.buyprice%TYPE;
		sell product_info.sellprice%TYPE;
		yes number;
		tot number;
		
	BEGIN  
		
		yes := 0;
		
		select COUNT(*) into tot from temp where product_code = pro_code;
		
		if tot = 1 then
			yes := 2;
			return yes;
		end if;
		
		select pid,buyprice,sellprice into ppid,buy,sell from product_info where product_code = pro_code and status = 0;
		
		insert into temp values(ppid,pro_code,buy,sell);	
		
		yes := 1;
		
		return yes;
		
		exception

			when no_data_found then
			  return yes;
		
	END add_to_cart;
	
	
	
	-- return 1 when deleted
	-- returns 2 when not found
	-- return 0 when problem
	function delete_from_cart(pro_code product_info.product_code%TYPE)
		return number
		is
		
		yes number;
		tot number;
		
	BEGIN  
		
		yes := 0;
		
		select COUNT(*) into tot from temp where product_code = pro_code;
		
		if tot = 0 then
			yes := 2;
			return yes;
		end if;
		
		DELETE FROM temp WHERE product_code = pro_code;	
		
		yes := 1;
		
		return yes;
		
		exception

			when no_data_found then
			  return yes;
		
	END delete_from_cart;
	
	
	procedure show_recept(purch_id in purchase.purchase_id%TYPE)
		IS
		cursor ca is select product_info.product_code,product_info.pid,product.name,product_info.buyprice,product_info.sellprice,product.brand as product_brand
		from purchase,product_info,product where product_info.product_code = purchase.product_code and purchase.pid = product.pid  and purchase.purchase_id = purch_id;
		
		buy_price purchase_history.buyprice%TYPE;
		sold_price purchase_history.soldprice%TYPE;
		purch_type purchase_history.purchase_type%TYPE;
		e_name employee.name%TYPE;
		cus_name customer.name%TYPE;
	begin
		
		
		select purchase_history.buyprice,purchase_history.soldprice,purchase_history.purchase_type,employee.name,customer.name into
		buy_price,sold_price,purch_type,e_name,cus_name from purchase_history,employee,customer where employee.eid = purchase_history.eid 
		and customer.cid = purchase_history.cid and purchase_history.purchase_id = purch_id;
		
		dbms_output.put_line('Recept:                               Purches ID:' ||to_char(purch_id));
		dbms_output.put_line('------------------------------------------------------');
		dbms_output.put_line('code     id     name     sellprice   brand');
		dbms_output.put_line('------------------------------------------');
		for r in ca loop
		   dbms_output.put_line(to_char(r.product_code)|| '     ' || to_char(r.pid) || '      ' || to_char(r.name) ||
		   '     ' || to_char(r.sellprice) || '     ' || to_char(r.product_brand));
		end loop;
		dbms_output.put_line('------------------------------------------------------');
		dbms_output.put_line('employee: ' ||to_char(e_name) ||'                   customer:' || to_char(cus_name));
		dbms_output.put_line('                                          TOTAL:' ||to_char(sold_price));
		
		
	end show_recept;
	
	
	-- returns 1 when success
	-- return 2 when temp is empty
	function sell(emp_id employee.eid%TYPE , cus_id customer.cid%TYPE)
		return number
		is
		
		tot_capital temp.buyprice%TYPE := 0;
		tot_sell temp.sellprice%TYPE :=0;
		tot number;
		cursor c is select * from temp;
		yes number;
		purch_id purchase_history.purchase_id%TYPE;
		
	BEGIN  
		
		yes := 0;
		
		select SUM(buyprice),SUM(sellprice) into tot_capital,tot_sell from temp;
		
		select COUNT(*) into tot from temp;
		
		if tot = 0 then
			yes := 2;
			return yes;
		end if;
		
		
		insert into purchase_history (eid,cid,buyprice,soldprice,capitalprice,purchase_type) values(emp_id,cus_id,tot_capital,tot_sell,null,'sell');
		
		select MAX(purchase_id) into purch_id from purchase_history;
		
		for r in c loop
		   
		   insert into purchase values(purch_id,r.pid,r.product_code);
		   
		   update product_info set status = 1 where product_code = r.product_code;
		   
		end loop;
		
		show_recept(purch_id);
		
		empty_cart;
		
		yes := 1;
		
		return yes;
		
		exception

			when no_data_found then
			  return yes;
		
	END sell;

end cart_sell_package;
/