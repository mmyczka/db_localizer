WITH ItemContainer(Name, ItemID, ContainerID, LocationPath) AS
(
    SELECT Name, ItemID, ContainerID, CAST(Name AS NVARCHAR(MAX)) AS LocationPath
    FROM Item 
    WHERE Name = 'Towels'
    UNION ALL
    SELECT i.Name, i.ItemID, i.ContainerID, CAST(i.Name AS NVARCHAR(MAX)) + '/' + c.LocationPath
    FROM Item i
        INNER JOIN ItemContainer AS c
        ON i.ItemID = c.ContainerID
)
SELECT LocationPath
FROM ItemContainer
WHERE ContainerID IS NULL