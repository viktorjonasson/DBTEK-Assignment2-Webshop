use `DBTEK_02_ShoeWebshop`;
drop procedure if exists `GetOrder`;

delimiter //

create procedure `GetOrder`(in in_CustomerId int, out out_orderSum double)
begin
    
    select CustomerOrder.Id as CustomerOrderId, Shoe.*, OrderDetail.Quantity, sum(Shoe.Price * OrderDetail.Quantity) as SubTotal
	from CustomerOrder
	inner join Customer
	on CustomerOrder.CustomerId = Customer.Id
	inner join OrderDetail
	on CustomerOrder.Id = OrderDetail.CustomerOrderId
	inner join Shoe
	on OrderDetail.ShoeId = Shoe.Id
	where Customer.Id = in_CustomerId and CustomerOrder.Status = 'Active'
	group by CustomerOrder.Id, Shoe.Id, Shoe.Brand, Shoe.Name, Shoe.Size, Shoe.Color, Shoe.Price, OrderDetail.Quantity;
    
    select SUM(Shoe.Price * OrderDetail.Quantity) into out_orderSum
	from CustomerOrder
	inner join Customer 
    on CustomerOrder.CustomerId = Customer.Id
	inner join OrderDetail 
    on CustomerOrder.Id = OrderDetail.CustomerOrderId
	inner join Shoe 
    on OrderDetail.ShoeId = Shoe.Id
	where Customer.Id = in_CustomerId and CustomerOrder.Status = 'Active'
	group by CustomerOrder.Id;

end//

delimiter ;