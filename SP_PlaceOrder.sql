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
    end if;

	update CustomerOrder set CityId = CurrentCity, Status = 'Paid' where Id = in_CustomerOrderId;
    
    commit;
    set autocommit = 1;
    
end//

delimiter ;