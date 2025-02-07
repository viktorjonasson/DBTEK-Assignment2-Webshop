use `DBTEK_02_ShoeWebshop`;
drop procedure if exists `AddToCart`;

delimiter //

create procedure `AddToCart`(in in_CustomerId int, in in_ShoeId int)

begin
	declare CurrentOrderId int default 0;
    
    declare exit handler for 1452 -- foreign key constraint: i detta fall om kunden saknas (vilket inte bör ske)
    begin
		rollback;
        resignal set message_text = 'Error likely due to a user account problem. Please try again or contact support:';
	end;

    set autocommit = 0;
	start transaction;
    
    -- Kollar först om ordern existerar
	if exists (select 1 from CustomerOrder where CustomerId = in_CustomerId and Status = 'Active') then
		set CurrentOrderId = (select Id from CustomerOrder where CustomerId = in_CustomerId and Status = 'Active');
	-- Annars skapar ny order
    else
		insert into CustomerOrder(CustomerId, Status) values
		(in_CustomerId, 'Active');
        if (select ROW_COUNT()) = 0 then
			signal sqlstate '45000'
			set message_text = 'Failed to create a new order likely due to a user account problem. Please try again or contact support:';
		end if;
		set CurrentOrderId = LAST_INSERT_ID();
    end if;
    
    -- Först ökar kvantitet
    if exists (select 1 from OrderDetail inner join Shoe on Shoe.Id = ShoeId where CustomerOrderId = CurrentOrderId and ShoeId = in_ShoeId and Shoe.Stock > 0) then
		update OrderDetail set Quantity = Quantity + 1 where CustomerOrderId = CurrentOrderId and in_ShoeId = ShoeId;
        if (select ROW_COUNT()) = 0 then
            signal sqlstate '45000'
            set message_text = 'Failed to update order quantity. Please try again or contact support:';
        end if;
	-- Annars lägger till ny rad
    elseif exists (select 1 from Shoe where Shoe.Id = in_ShoeId and Stock > 0) then
		insert into OrderDetail(CustomerOrderId, ShoeId, Quantity) values
		(CurrentOrderId, in_ShoeId, 1);
        if (select ROW_COUNT()) = 0 then
            signal sqlstate '45000'
            set message_text = 'Failed to add product to order. Please try again or contact support:';
        end if;
	else
		signal sqlstate '45000'
        set message_text = 'The product is no longer available, please select another:';
    end if;

    update Shoe set Stock = Stock - 1 where Shoe.Id = in_ShoeId;
    if (select ROW_COUNT()) = 0 then
        signal sqlstate '45001'
        set message_text = 'There was an uxepected problem with the automated stock handling. The store is temporarily unavailable.';
    end if;

    commit;
    set autocommit = 1;

end//

delimiter ;