USE db_localizer_relational;
GO


-- Insert data into Room table
INSERT INTO [Room] ([Name])
VALUES ('Garage'),
       ('Pantry'),
       ('Bedroom'),
	   ('Kitchen');

-- Insert data into Furniture table
INSERT INTO [Container] ([Name], [RoomID])
VALUES (NULL, 1),
       ('Tool Cabinet', 1),
       ('Cabinet', 2),
       (NULL, 3),
	   ('Wardrobe', 3);

-- Insert data into Location table
INSERT INTO [Location] ([Name], [ContainerID])
VALUES (NULL, 1),
       (NULL, 4),
       ('Top Shelf', 2),
       ('Bottom Shelf', 2),
	   ('Right Top Shelf', 3),
	   ('Right Middle Shelf', 3),
	   ('Right Top Shelf', 5),
	   ('Left Top Shelf', 5);

-- Insert data into Category table
INSERT INTO [Category] ([Name])
VALUES ('Furnitures'),
       ('Vehicles'),
       ('Tools'),
	   ('Supplies'),
	   ('Books'),
	   ('Medicine');

-- Insert data into Item table
INSERT INTO [Item] ([Name], [LocationID], [CategoryID])
VALUES ('Car', 1, 2),
       ('Bicycle', 1, 2),
       ('Hammer drill', 3, 3),
       ('Electric Screwdriver', 3, 3),
	   ('Sprayer', 4, 3),
	   ('Paper Towels', 5, 4),
	   ('Gloves', 6, 4),
	   ('Headache Pill', 7, 6),
	   ('Books', 7, 5),
	   ('Bedding', 8, 4),
	   ('Towels', 8, 4),
	   ('Bed', 2, 1);

GO