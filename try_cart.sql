set serveroutput on;
declare
	pro_code product_info.product_code%TYPE := 1208;
	res number;
begin
	res := add_to_cart(pro_code);
	
	IF res = 1 then
		dbms_output.put_line('Added to cart');
	ELSIF res = 2 then
		dbms_output.put_line('Product already exists');
	ELSE
		dbms_output.put_line('Product NOT FOUND');
	END IF;

	show_cart;
	
	/*
	res := delete_from_cart(pro_code);
	
	IF res = 1 then
		dbms_output.put_line('Deleted');
	ELSIF res = 2 then
		dbms_output.put_line('Does not exit');
	ELSE
		dbms_output.put_line('Problem');
	END IF;
	
	show_cart;
	
	*/
	
end;
/



--begin
--	empty_cart;
--end;
--/