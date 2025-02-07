use `DBTEK_02_ShoeWebshop`;
drop procedure if exists `PlaceOrder`;

delimiter //

create procedure `PlaceOrder`(in in_CustomerOrderId int, in in_city varchar(50))
begin
	declare CurrentCity int default 0;
    
    set autocommit = 0;
	start transaction;
    
    if exists (select 1 from City where City.Name = in_city) then
		set CurrentCity = (select Id from City where City.Name = in_city);
    else
		insert into City(Name) values
		(in_City);
        set CurrentCity = LAST_INSERT_ID();
        if (select ROW_COUNT()) = 0 then
			signal sqlstate '45000'
			set message_text = 'There was an error registering the city. Please try again, or contact support.';
		end if;
    end if;

	if exists (select 1 from CustomerOrder where Id = in_CustomerOrderId) then
		update CustomerOrder set CityId = CurrentCity, Status = 'Paid' where Id = in_CustomerOrderId;
        if (select ROW_COUNT()) = 0 then
			signal sqlstate '45000'
			set message_text = 'There was an error placing your order. Please try again, or contact support.';
		end if;
    else
		signal sqlstate '45002'
        set message_text = 'Your shopping cart seems to have been emptied due to an unexpected error. Please start again.';
	end if;
    
    commit;
    set autocommit = 1;
    
end//

delimiter ;