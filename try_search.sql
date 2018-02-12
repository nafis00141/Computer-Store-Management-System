set serveroutput on;
declare
	x product.name%TYPE := 'Rx 480';
	co1 product_info.condition%TYPE := 'new';
	co2 product_info.condition%TYPE := 'old';
	br product_info.branch%TYPE := 'Dhanmondi';
begin
	dbms_output.put_line('search all product');
	search_package.search_all_pro(x);
	dbms_output.put_line('search new product');
	search_package.search_con_pro(x,co1);
	dbms_output.put_line('search old product');
	search_package.search_con_pro(x,co2);
	dbms_output.put_line('search product against branch');
	search_package.search_bran_pro(x,br);
	dbms_output.put_line('get all product against branch');
	search_package.get_all_pro_branch(br);
end;
/
