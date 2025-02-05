use `DBTEK_02_ShoeWebshop`;
drop procedure if exists `AddToCart`;

delimiter //

create procedure `AddToCart`(in in_CustomerId int, in in_ShoeId int)

begin

	declare CurrentOrderId int default 0;

    set autocommit = 0;
	start transaction;
    
	if exists (select 1 from CustomerOrder where CustomerId = in_CustomerId and Status = 'Active') then
		set CurrentOrderId = (select Id from CustomerOrder where CustomerId = in_CustomerId and Status = 'Active');
    else
		insert into CustomerOrder(CustomerId, Status) values
		(in_CustomerId, 'Active');
        set CurrentOrderId = LAST_INSERT_ID();
    end if;
    
    if exists (select 1 from OrderDetail where CustomerOrderId = CurrentOrderId and ShoeId = in_ShoeId) then
		update OrderDetail set Quantity = Quantity + 1 where CustomerOrderId = CurrentOrderId and in_ShoeId = ShoeId;
    else
		insert into OrderDetail(CustomerOrderId, ShoeId, Quantity) values
		(CurrentOrderId, in_ShoeId, 1);
    end if;
    
    update Shoe set Stock = Stock - 1 where Shoe.Id = in_ShoeId;
    
    commit;
    set autocommit = 1;

end//

delimiter ;