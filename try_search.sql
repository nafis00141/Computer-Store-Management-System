set serveroutput on;
declare
	x product.name%TYPE := 'Nvidia GTX 1060';
	co1 product_info.condition%TYPE := 'new';
	co2 product_info.condition%TYPE := 'old';
	br product_info.branch%TYPE := 'kalabagan';
begin
	dbms_output.put_line('search all product');
	search_all_pro(x);
	dbms_output.put_line('search new product');
	search_con_pro(x,co1);
	dbms_output.put_line('search old product');
	search_con_pro(x,co2);
	dbms_output.put_line('search product against branch');
	search_bran_pro(x,br);
	dbms_output.put_line('get all product against branch');
	get_all_pro_branch(br);
end;
/
