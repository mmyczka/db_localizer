USE db_localizer_recursive;
GO

-- Insert data into Category table
INSERT INTO Category (Name)
VALUES ('Rooms'),
	   ('Furnitures'),
	   ('Locations'),
	   ('Vehicles'),
       ('Tools'),
       ('Supplies'),
	   ('Books'),
	   ('Medicine');

-- Insert data into Item table
-- Garage
INSERT INTO Item (Name, ContainerID, CategoryID)
VALUES ('Garage', NULL, 1);

DECLARE @GarageID INT;
SELECT @GarageID = SCOPE_IDENTITY();

INSERT INTO Item (Name, ContainerID, CategoryID)
VALUES ('Car', @GarageID, 4),
	   ('Bicycle', @GarageID, 4),
	   ('Tool Cabinet', @GarageID, 2);

-- Garage -> Tool Cabinet
DECLARE @ToolCabinetID INT;
SELECT @ToolCabinetID = SCOPE_IDENTITY();

INSERT INTO Item (Name, ContainerID, CategoryID)
VALUES ('Top Shelf', @ToolCabinetID, 3);

-- Garage -> Tool Cabinet -> Top Shelf
DECLARE @TopShelfID INT;
SELECT @TopShelfID = SCOPE_IDENTITY();

INSERT INTO Item (Name, ContainerID, CategoryID)
VALUES ('Hammer Drill', @TopShelfID, 4),
	   ('Electric Screwdriver', @TopShelfID, 4);

-- Garage -> Tool Cabinet -> Bottom Shelf
INSERT INTO Item (Name, ContainerID, CategoryID)
VALUES ('Bottom Shelf', @ToolCabinetID, 3);

DECLARE @BottomShelfID INT;
SELECT @BottomShelfID = SCOPE_IDENTITY();

INSERT INTO Item (Name, ContainerID, CategoryID)
VALUES ('Sprayer', @BottomShelfID, 4);

-- Pantry
INSERT INTO Item (Name, ContainerID, CategoryID)
VALUES ('Pantry', NULL, 1);

DECLARE @PantryID INT;
SELECT @PantryID = SCOPE_IDENTITY();

INSERT INTO Item (Name, ContainerID, CategoryID)
VALUES ('Cabinet', @PantryID, 2);

-- Pantry -> Cabinet
DECLARE @PantryCabinetID INT;
SELECT @PantryCabinetID = SCOPE_IDENTITY();

INSERT INTO Item (Name, ContainerID, CategoryID)
VALUES ('Right Top Shelf', @PantryCabinetID, 3);

-- Pantry -> Cabinet -> Right Top Shelf
DECLARE @RightTopShelfID INT;
SELECT @RightTopShelfID = SCOPE_IDENTITY();

INSERT INTO Item (Name, ContainerID, CategoryID)
VALUES ('Paper Towels', @RightTopShelfID, 6);

-- Pantry -> Cabinet -> Right Top Shelf
INSERT INTO Item (Name, ContainerID, CategoryID)
VALUES ('Right Middle Shelf', @PantryCabinetID, 3);

DECLARE @RightMiddleShelfID INT;
SELECT @RightMiddleShelfID = SCOPE_IDENTITY();

INSERT INTO Item (Name, ContainerID, CategoryID)
VALUES ('Gloves', @RightMiddleShelfID, 6);

-- Bedroom
INSERT INTO Item (Name, ContainerID, CategoryID)
VALUES ('Bedroom', NULL, 1);

DECLARE @BedroomID INT;
SELECT @BedroomID = SCOPE_IDENTITY();

INSERT INTO Item (Name, ContainerID, CategoryID)
VALUES ('Bed', @BedroomID, 2),
	   ('Wardrobe', @BedroomID, 2);

-- Bedroom -> Wardrobe
DECLARE @WardrobeID INT;
SELECT @WardrobeID = SCOPE_IDENTITY();

INSERT INTO Item (Name, ContainerID, CategoryID)
VALUES ('Right Top Shelf', @WardrobeID, 3);

-- Bedroom -> Wardrobe -> Right Top Shelf
DECLARE @WardrobeTopShelfID INT;
SELECT @WardrobeTopShelfID = SCOPE_IDENTITY();

INSERT INTO Item (Name, ContainerID, CategoryID)
VALUES ('Headache Pill', @WardrobeTopShelfID, 8);

-- Garage -> Tool Cabinet -> Right Bottom Shelf
INSERT INTO Item (Name, ContainerID, CategoryID)
VALUES ('Right Bottom Shelf', @WardrobeID, 3);

DECLARE @WardrobeBottomShelfID INT;
SELECT @WardrobeBottomShelfID = SCOPE_IDENTITY();

INSERT INTO Item (Name, ContainerID, CategoryID)
VALUES ('Book', @WardrobeBottomShelfID, 7);

-- Garage -> Tool Cabinet -> Left Top Shelf
INSERT INTO Item (Name, ContainerID, CategoryID)
VALUES ('Left Top Shelf', @WardrobeID, 3);

DECLARE @LeftTopShelfID INT;
SELECT @LeftTopShelfID = SCOPE_IDENTITY();

INSERT INTO Item (Name, ContainerID, CategoryID)
VALUES ('Bedding', @LeftTopShelfID, 6),
	   ('Towels', @LeftTopShelfID, 6);

