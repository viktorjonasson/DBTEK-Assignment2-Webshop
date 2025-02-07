use `DBTEK_02_ShoeWebshop`;
drop procedure if exists `ValidateCustomer`;

delimiter //

create procedure `ValidateCustomer`(in in_username varchar(50), in in_password varchar(50))
begin

if exists (select 1 from Customer where Username = in_username and Password = in_password) then
	select * from Customer where Username = in_username and Password = in_password;
end if;
end//

delimiter ;