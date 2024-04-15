# Database Localizer Project

This project aims to compare two different approaches for building a database localizer system: relational and recursive. The database localizer system serves as a tool to manage and keep track of various items, their locations, and other relevant information within a home.

1. **Relational Approach**: This approach involves structuring the localizer database using traditional relational database principles, where data is organized into tables with predefined relationships between them.

![Relational Approach](db_relational/db_localizer_relational.png)

2. **Recursive Approach**: The recursive approach utilizes hierarchical or recursive data structures to model the localizer system, allowing for a more flexible and dynamic organization of locations of items and their relationships.

![Recursive Approach](db_recursive/db_localizer_recursive.png)

## All Location Paths
1.  **Relational Approach**:
```sql
SELECT 
	CONCAT( r.Name, '/',
	COALESCE(c.Name + '/',''),
	COALESCE(l.Name + '/',''),
	i.Name) AS LocationPath
FROM Item i
	JOIN Location l ON i.LocationID = l.LocationID
	JOIN Container c ON l.ContainerID = c.ContainerID
	JOIN Room r ON c.RoomID = r.RoomID
```
**Query results:**

|   |Name                   |LocationPath                                       |
|---|-----------------------|---------------------------------------------------|
|1  |Car                    |Garage/Car                                         |
|2  |Bicycle                |Garage/Bicycle                                     |
|3  |Hammer drill           |Garage/Tool Cabinet/Top Shelf/Hammer drill         |
|4  |Electric Screwdriver   |Garage/Tool Cabinet/Top Shelf/Electric Screwdriver |
|5  |Sprayer                |Garage/Tool Cabinet/Bottom Shelf/Sprayer           |
|6  |Paper Towels           |Pantry/Cabinet/Right Top Shelf/Paper Towels        |
|7  |Gloves                 |Pantry/Cabinet/Right Middle Shelf/Gloves           |
|8  |Headache Pill          |Bedroom/Wardrobe/Right Top Shelf/Headache Pill     |
|9  |Books                  |Bedroom/Wardrobe/Right Top Shelf/Books             |
|10 |Bedding                |Bedroom/Wardrobe/Left Top Shelf/Bedding            |
|11 |Towels                 |Bedroom/Wardrobe/Left Top Shelf/Towels             |
|12 |Bed                    |Bedroom/Bed                                        |


2. **Recursive Approach**:
```sql
WITH ContainItem(Name, ItemID, ContainerID, LocationPath) AS
(
    SELECT Name, ItemID, ContainerID, CAST(Name AS NVARCHAR(MAX)) AS LocationPath
    FROM Item 
    WHERE ContainerID IS NULL
    UNION ALL
    SELECT i.Name, i.ItemID, i.ContainerID, c.LocationPath + '/' + CAST(i.Name AS NVARCHAR(MAX))
    FROM Item i
        INNER JOIN ContainItem AS c
        ON i.ContainerID = c.ItemID
)
SELECT Name, LocationPath
FROM ContainItem
```
**Query results:**

|   |Name                   |LocationPath                                       |
|---|-----------------------|---------------------------------------------------|
|1  |Garage                 |Garage                                             |
|2  |Pantry                 |Pantry                                             |
|3  |Bedroom                |Bedroom                                            |
|4  |Bed                    |Bedroom/Bed                                        |
|5  |Cabinet                |Pantry/Cabinet                                     |
|6  |Right Top Shelf        |Pantry/Cabinet/Right Top Shelf                     |
|7  |Right Middle Shelf     |Pantry/Cabinet/Right Middle Shelf                  |
|8  |Gloves                 |Pantry/Cabinet/Right Middle Shelf/Gloves           |
|9  |Paper Towels           |Pantry/Cabinet/Right Top Shelf/Paper Towels        |
|10 |Car                    |Garage/Car                                         |
|11 |Bicycle                |Garage/Bicycle                                     |
|12 |Tool Cabinet           |Garage/Tool Cabinet                                |
|13 |Wardrobe               |Garage/Wardrobe                                    |
|14 |Right Top Shelf        |Garage/Wardrobe/Right Top Shelf                    |
|...|                       |                                                   |


```sql
WITH ContainItem(Name, ItemID, ContainerID, LocationPath) AS
(
    SELECT Name, ItemID, ContainerID, CAST(Name AS NVARCHAR(MAX)) AS LocationPath
    FROM Item 
    WHERE ContainerID IS NULL
    UNION ALL
    SELECT i.Name, i.ItemID, i.ContainerID, c.LocationPath + '/' + CAST(i.Name AS NVARCHAR(MAX))
    FROM Item i
        INNER JOIN ContainItem AS c
        ON i.ContainerID = c.ItemID
)
SELECT Name, LocationPath
FROM ContainItem ci
WHERE NOT EXISTS (
    SELECT 1
    FROM Item i
    WHERE i.ContainerID = ci.ItemID
);
```
**Query results:**

|   |Name                   |LocationPath                                       |
|---|-----------------------|---------------------------------------------------|
|1  |Bed                    |Bedroom/Bed                                        |
|2  |Gloves                 |Pantry/Cabinet/Right Middle Shelf/Gloves           |
|3  |Paper Towels           |Pantry/Cabinet/Right Top Shelf/Paper Towels        |
|4  |Car                    |Garage/Car                                         |
|5  |Bicycle                |Garage/Bicycle                                     |
|6  |Bedding                |Garage/Wardrobe/Left Top Shelf/Bedding             |
|7  |Towels                 |Garage/Wardrobe/Left Top Shelf/Towels              |
|8  |Book                   |Garage/Wardrobe/Right Bottom Shelf/Book            |
|9  |Headache Pill          |Garage/Wardrobe/Right Top Shelf/Headache Pill      |
|10 |Sprayer                |Garage/Tool Cabinet/Bottom Shelf/Sprayer           |
|11 |Hammer Drill           |Garage/Tool Cabinet/Top Shelf/Hammer Drill         |
|12 |Electric Screwdriver   |Garage/Tool Cabinet/Top Shelf/Electric Screwdriver |
