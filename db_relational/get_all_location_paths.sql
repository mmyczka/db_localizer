SELECT i.Name,
	CONCAT( r.Name, '/',
	COALESCE(c.Name + '/',''),
	COALESCE(l.Name + '/',''),
	i.Name) AS LocationPath
FROM Item i
	JOIN Location l ON i.LocationID = l.LocationID
	JOIN Container c ON l.ContainerID = c.ContainerID
	JOIN Room r ON c.RoomID = r.RoomID
