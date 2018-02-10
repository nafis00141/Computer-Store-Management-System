set serveroutput on;

declare
	nam product.name%TYPE:='Rx 480';
	bran product.brand%TYPE:='AMD';
	cat product.catagory%TYPE:='GPU';
	pro_code product_info.product_code%TYPE:=1212;
	sup_id product_info.sid%TYPE:=4;
	buy_price product_info.buyprice%TYPE:=28000;
	sell_price product_info.sellprice%TYPE:=35000;
	branc product_info.branch%TYPE:='Dhanmondi';
	cus_id product_info.cid%TYPE:=2;
	res number;
	
begin
	--new product inset
	/*
	res := insert_product_new(nam,bran,cat,pro_code,sup_id,buy_price,sell_price,branc);
	
	if res = 1 then
		dbms_output.put_line('Product code ' || to_char(pro_code) || ' Product Name ' || to_char(nam) || ' inserted as new product');
	ELSIF res = 2 then
		dbms_output.put_line('Product code ' || to_char(pro_code) || ' all ready exists');
	ELSE
		dbms_output.put_line('Problem');
	END IF;
	*/
	
	res := insert_product_old(nam,bran,cat,pro_code,cus_id,buy_price,sell_price,branc);
	
	if res = 1 then
		dbms_output.put_line('Product code ' || to_char(pro_code) || ' Product Name ' || to_char(nam) || ' inserted as used product');
	ELSIF res = 2 then
		dbms_output.put_line('Product code ' || to_char(pro_code) || ' all ready exists');
	ELSE
		dbms_output.put_line('Problem');
	END IF;
	
	
end;
/

