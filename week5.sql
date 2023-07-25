use week5;

drop procedure if exists week5;
delimiter //
create procedure week5()
begin
declare sql_error int default false;
declare continue handler for sqlexception set sql_error = true;
start transaction;

insert into orders values (NULL, "2316542","2023-02-15 15:10:45", 1);
set @last_id = last_insert_id();
insert into order_details values (NULL, 1, "25%", @last_id, 1, 1);

insert into orders values (NULL, "2316542","2023-02-16 09:45:05", 1);
set @last_id = last_insert_id();
insert into order_details values (NULL, 1, "50%", @last_id, 2, 2);

insert into orders values (NULL, "2316542","2023-02-17 12:30:50", 1);
set @last_id = last_insert_id();
insert into order_details values (NULL, 1, "100%", @last_id, 3, 3);

if sql_error = false then commit; select "Success";
else rollback; select "fail";
end if;
end //
delimiter ;
call week5();

select customer_name,  level_of_sweet, count(order_detail_id) as Count
from customers join orders using(customer_id)
join order_details using(order_id)
group by level_of_sweet, customer_name
order by customer_name;