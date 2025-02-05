use `DBTEK_02_ShoeWebshop`;
drop procedure if exists `ValidateCustomer`;

delimiter //

create procedure `ValidateCustomer`(in in_username varchar(50), in in_password varchar(50))
begin
	select *
    from Customer
    where Username = in_username and Password = in_password;
end//

delimiter ;