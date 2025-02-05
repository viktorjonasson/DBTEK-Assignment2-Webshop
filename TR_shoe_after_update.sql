use `DBTEK_02_ShoeWebshop`;
drop trigger if exists `Shoe_after_update`;

delimiter //

create trigger `Shoe_after_update`
	after update on `Shoe` 
	for each row
    
begin
	if new.Stock = 0 and old.Stock > 0 then
		insert into OutOfStock(ShoeId) values (new.Id);
	end if;
    
    if old.Stock <= 0 and new.Stock > 0 then
		delete from OutOfStock where ShoeId = new.Id;
	end if;
end//

delimiter ;