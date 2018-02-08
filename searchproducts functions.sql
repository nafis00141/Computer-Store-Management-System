set serveroutput on;

-- search with the name of the prodect
create or replace procedure search_all_pro(pnam in product.name%TYPE)
as
cursor c is select product.pid as pid, product.name as pname, product.catagory as catagory, product.brand as brand,
product_info.product_code as product_code, product_info.buyprice as buyprice , product_info.sellprice as sellprice,
product_info.branch as branch, product_info.condition as condition from product,product_info
where product.pid = product_info.pid and product_info.status = 0 and product.name = pnam;
begin
	
    for r in c loop
       dbms_output.put_line(to_char(r.pid)|| ' ' || to_char(r.pname) || ' ' || to_char(r.branch));
    end loop;
end;
/

-- search with name and condition of the product
create or replace procedure search_con_pro(pnam in product.name%TYPE,con in product_info.condition%TYPE)
as
cursor c is select product.pid as pid, product.name as pname, product.catagory as catagory, product.brand as brand,
product_info.product_code as product_code, product_info.buyprice as buyprice , product_info.sellprice as sellprice,
product_info.branch as branch, product_info.condition as condition from product,product_info 
where product.pid = product_info.pid and product_info.status = 0 and product_info.condition = con and product.name = pnam;
begin
	
    for r in c loop
       dbms_output.put_line(to_char(r.pid)|| ' ' || to_char(r.pname) || ' ' || to_char(r.branch) || ' ' || to_char(r.condition));
    end loop;
end;
/

-- search with name and branch of the product
create or replace procedure search_bran_pro(pnam in product.name%TYPE,bran in product_info.branch%TYPE)
as
cursor c is select product.pid as pid, product.name as pname, product.catagory as catagory, product.brand as brand,
product_info.product_code as product_code, product_info.buyprice as buyprice , product_info.sellprice as sellprice,
product_info.branch as branch, product_info.condition as condition from product,product_info 
where product.pid = product_info.pid and product_info.status = 0 and product_info.branch = bran and product.name = pnam;
begin
	
    for r in c loop
       dbms_output.put_line(to_char(r.pid)|| ' ' || to_char(r.pname) || ' ' || to_char(r.branch) || ' ' || to_char(r.condition));
    end loop;
end;
/

-- get all product against branch 
create or replace procedure get_all_pro_branch(bran in product_info.branch%TYPE)
as
cursor c is select product.pid as pid, product.name as pname, product.catagory as catagory, product.brand as brand,
product_info.product_code as product_code, product_info.buyprice as buyprice , product_info.sellprice as sellprice,
product_info.branch as branch, product_info.condition as condition from product,product_info 
where product.pid = product_info.pid and product_info.status = 0 and product_info.branch = bran;
begin
	
    for r in c loop
       dbms_output.put_line(to_char(r.pid)|| ' ' || to_char(r.pname) || ' ' || to_char(r.branch) || ' ' || to_char(r.condition));
    end loop;
end;
/

