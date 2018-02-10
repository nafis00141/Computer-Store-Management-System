
-- returns the pid of the new added product
create or replace function insert_product(nam product.name%TYPE,bran product.brand%TYPE,cat product.catagory%TYPE)
	return product.pid%TYPE
	is
	
	P_id product.pid%TYPE; 
	
BEGIN  
	
	insert into product(name,catagory,brand) values(nam,cat,bran);
	
	select pid into P_id from product where name = nam and catagory = cat and brand = bran;
	
	return P_id;
	
	exception

		when no_data_found then
			P_id := 0;
			return P_id;

	
END insert_product;
/

--returns 1 when successful
--returns 0 when error
--returns 2 when already exist
create or replace function insert_product_new(nam product.name%TYPE,bran product.brand%TYPE,cat product.catagory%TYPE,
												pro_code product_info.product_code%TYPE,sup_id product_info.sid%TYPE,
												buy_price product_info.buyprice%TYPE,sell_price product_info.sellprice%TYPE,
												branc product_info.branch%TYPE)
			return number
			is

			tot number;
			P_id product.pid%TYPE;
			ret number;
			
begin

	ret := 0;
	
    select COUNT(*) into tot from product where name = nam and catagory = cat and brand = bran;
	
	if tot = 0 then
		P_id := insert_product(nam,cat,bran);
	ELSE  
		select pid into P_id from product where name = nam and catagory = cat and brand = bran;
	end if;
	
	select COUNT(*) into tot from product_info where product_code = pro_code;
	
	
	if tot = 0 then
		insert into product_info values(pro_code,P_id,sup_id,null,buy_price,sell_price,branc,'new',0);
		ret := 1;
		return ret;
	ELSE  
		ret := 2;
		return ret;
	end if;

	
	exception

		when no_data_found then
		  return ret;
		  
	
end insert_product_new;
/


--returns 1 when successful
--returns 0 when error
--returns 2 when already exist
create or replace function insert_product_old(nam product.name%TYPE,bran product.brand%TYPE,cat product.catagory%TYPE,
												pro_code product_info.product_code%TYPE,cus_id product_info.cid%TYPE,
												buy_price product_info.buyprice%TYPE,sell_price product_info.sellprice%TYPE,
												branc product_info.branch%TYPE)
			return number
			is

			tot number;
			P_id product.pid%TYPE;
			ret number;
			
begin

	ret := 0;
	
    select COUNT(*) into tot from product where name = nam and catagory = cat and brand = bran;
	
	if tot = 0 then
		P_id := insert_product(nam,cat,bran);
	ELSE  
		select pid into P_id from product where name = nam and catagory = cat and brand = bran;
	end if;
	
	select COUNT(*) into tot from product_info where product_code = pro_code;
	
	
	if tot = 0 then
		insert into product_info values(pro_code,P_id,null,cus_id,buy_price,sell_price,branc,'old',0);
		ret := 1;
		return ret;
	ELSE  
		ret := 2;
		return ret;
	end if;

	
	exception

		when no_data_found then
		  return ret;
		  
	
	
end insert_product_old;
/