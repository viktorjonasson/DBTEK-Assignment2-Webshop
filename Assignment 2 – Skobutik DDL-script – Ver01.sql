-- DDL-script

-- Skapar databasen

drop database if exists DBTEK_02_ShoeWebshop;
create database DBTEK_02_ShoeWebshop;
use DBTEK_02_ShoeWebshop;

create table Customer(
Id int not null auto_increment primary key,
FirstName varchar(50) not null,
LastName varchar(50) not null,
Username varchar(50) not null unique,
Password varchar(50) not null,
created timestamp default CURRENT_TIMESTAMP,
lastUpdate timestamp default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP
);

create table City(
Id int not null auto_increment primary key,
Name varchar(50) not null,
created timestamp default CURRENT_TIMESTAMP,
lastUpdate timestamp default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP
);

create table Shoe(
Id int not null auto_increment primary key,
Brand varchar(50) not null,
Name varchar(50) not null,
Size double not null,
Color varchar(50) not null,
Price double not null,
Stock int,
created timestamp default CURRENT_TIMESTAMP,
lastUpdate timestamp default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP
);

create table Category(
Id int not null auto_increment primary key,
Name varchar(50) not null,
created timestamp default CURRENT_TIMESTAMP,
lastUpdate timestamp default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP
);

create table ShoeCategoryMapping(
Id int not null auto_increment primary key,
ShoeId int not null,
CategoryId int not null,
created timestamp default CURRENT_TIMESTAMP,
lastUpdate timestamp default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP,
foreign key (ShoeId) references Shoe(Id) on update cascade,
-- Frångår default ref.int.: Om jag vill ändra ShoeId för att det av någon anledning känns mer logiskt så kommer ShoeId-referensen här att uppdatears med det nya Id:t.
foreign key (CategoryId) references Category(Id) on delete cascade on update cascade
-- Frångår default ref.int.: 'on update cascade': Här gör jag samma som för ShoeId ovan (fast om jag byter Id på en Category).
-- Frångår default ref.int.: 'on delete cascade': Jag kan vilja radera en kategori som är överflödig. När jag gör detta vill jag ta bort kopplingen till en sko, dvs radera de berörda raderna här.
);

create table CustomerOrder(
Id int not null auto_increment primary key,
CityId int,
CustomerId int not null,
Status enum ('Active', 'Paid') not null, 
created timestamp default CURRENT_TIMESTAMP,
lastUpdate timestamp default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP,
foreign key (CityId) references City(Id),
foreign key (CustomerId) references Customer(Id)
);

create table OrderDetail(
Id int not null auto_increment primary key,
CustomerOrderId int not null,
ShoeId int not null,
Quantity int not null,
created timestamp default CURRENT_TIMESTAMP,
lastUpdate timestamp default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP,
foreign key (CustomerOrderId) references CustomerOrder(Id) on delete cascade,
-- Frångår default ref.int.: När en CustomerOrder raderas, vill jag även radera OrderDetails kopplat till denna order. Orderdetailjerna är ju meningslösa om ordern har annullerats.
foreign key (ShoeId) references Shoe(Id) on update cascade
-- Frångår default ref.int.: Om jag vill ändra ShoeId för att det av någon anledning känns mer logiskt så kommer ShoeId-referensen här att uppdatears med det nya Id:t.

);

create table OutOfStock(
Id int not null auto_increment primary key,
ShoeId int not null,
created timestamp default CURRENT_TIMESTAMP,
lastUpdate timestamp default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP,
foreign key (ShoeId) references Shoe(Id) on update cascade
);

-- Fyller med data

insert into Customer (FirstName, LastName, Username, Password) values
	('Viktor', 'Köpamera', 'viktor', 'viktorpassword'),
	('Klas', 'Shopparsson', 'klas', 'klaspassword'),
	('Sven', 'Spenderarbyxa', 'sven', 'svenpassword'),
	('Elin', 'Shopping von Spree', 'elin', 'elinpassword'),
	('Marie', 'Le Nouveu Riche', 'marie', 'mariepassword');

insert into City (Name) values
	('Malmö'),
	('Göteborg'),
	('Växjö'),
	('Lund'),
	('Norrköping'),
	('Kalmar');

insert into Shoe (Brand, Name, Size, Color, Price, Stock) values
	('Ecco', 'Rugged Sandals', '38', 'Black', '899', '14'),
	('Ecco', 'Rugged Sandals', '40', 'Cream', '899', '9'),
	('Ecco', 'Elegant Boots', '41', 'Black', '2190', '25'),
	('HM', 'Chunky Sneakers', '38', 'Blue', '499', '34'),
	('HM', 'Mary Jane Flats', '37', 'Dark Brown', '750', '12'),
	('HM', 'Mary Jane Flats', '36', 'Dark Brown', '750', '12'),
	('HM', 'Leather Ballet Flats', '40', 'Light Brown', '400', '45'),
	('Filippa K', 'Wool Lined Boots', '39', 'Dark Brown', '2800', '30'),
	('Filippa K', 'Wool Lined Boots', '39', 'Black', '2600', '56'),
	('Filippa K', 'Braided Flats', '35', 'White', '1900', '5'),
	('Filippa K', 'Sporty Sneakers', '41', 'White', '2100', '17');

insert into Category (Name) values
	('Sandals'),
	('Boots'),
	('Ballet Flats'),
	('Sneakers'),
	('Winter'),
	('Summer'),
	('Special Occasions');

insert into ShoeCategoryMapping (ShoeId, CategoryId) values
	(1, 1),
	(1, 6),
	(2, 1),
	(2, 6),
	(3, 2),
	(3, 5),
	(3, 7),
	(4, 4),
	(4, 5),
	(5, 3),
	(5, 6),
	(5, 7),
	(6, 3),
	(6, 6),
	(6, 7),
	(7, 3),
	(7, 6),
	(7, 7),
	(8, 2),
	(8, 5),
	(9, 2),
	(9, 5),
	(10, 3),
	(10, 6),
	(10, 7),
	(11, 4),
	(11, 6);

insert into CustomerOrder (CityId, CustomerId, Status) values
	(1, 3, 'Paid'),
	(2, 5, 'Paid'),
	(6, 2, 'Paid'),
	(2, 2, 'Paid'),
	(3, 2, 'Paid'),
	(3, 1, 'Paid'),
	(4, 1, 'Paid'),
	(4, 4, 'Paid'),
	(4, 3, 'Paid'),
	(5, 4, 'Paid');

insert into OrderDetail (CustomerOrderId, ShoeId, Quantity) values
	(1, 4, 1),
	(1, 7, 1),
	(2, 11, 2),
	(3, 1, 2),
	(3, 8, 3),
	(3, 10, 1),
	(4, 2, 2),
	(4, 9, 1),
	(4, 10, 1),
	(4, 3, 4),
	(5, 5, 2),
	(5, 1, 1),
	(6, 9, 5),
	(6, 10, 1),
	(6, 4, 2),
	(7, 8, 3),
	(8, 5, 4),
	(8, 9, 2),
	(8, 2, 1),
	(8, 4, 2),
	(8, 7, 3),
	(9, 2, 1),
	(10, 6, 1);


-- Creation of index

-- Index på skomärke då de som jobbar med skobutiken ofta kan behöva söka upp alla skor de har för ett visst märke,
-- för att kolla vad de har i form av modeller, storlekar, färger och saldo.
create index IX_Shoe_Brand on Shoe(Brand);


-- Display all tables

select * from Customer;
select * from CustomerOrder;
select * from OrderDetail;
select * from City;
select * from Shoe;
select * from Category;
select * from ShoeCategoryMapping;
