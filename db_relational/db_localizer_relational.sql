IF EXISTS (SELECT * FROM sys.databases WHERE NAME = 'db_localizer_relational')
    DROP DATABASE db_localizer_relational;
GO

CREATE DATABASE db_localizer_relational;
GO

USE db_localizer_relational;
GO

CREATE TABLE [Room](
	[RoomID] [int] IDENTITY(1,1) PRIMARY KEY,
	[Name] [nvarchar](30) NOT NULL
)

CREATE TABLE [Container](
	[ContainerID] [int] IDENTITY(1,1) PRIMARY KEY,
	[Name] [nvarchar](30),
	[RoomID] [int] NOT NULL,
	CONSTRAINT FK_Furniture_Room FOREIGN KEY (RoomID)
		REFERENCES Room (RoomID)
		ON DELETE CASCADE
		ON UPDATE CASCADE,
	CONSTRAINT Unique_Name_RoomID UNIQUE ([Name], [RoomID])
)

CREATE TABLE [Location](
	[LocationID] [int] IDENTITY(1,1) PRIMARY KEY,
	[Name] [nvarchar](30),
	[ContainerID] [int] NOT NULL,
	CONSTRAINT FK_Location_Container FOREIGN KEY (ContainerID)
		REFERENCES Container (ContainerID)
		ON DELETE CASCADE
		ON UPDATE CASCADE,
	CONSTRAINT Unique_Name_ContainerID UNIQUE ([Name], [ContainerID])
)

CREATE TABLE [Category](
	[CategoryID] [int] IDENTITY(1,1) PRIMARY KEY,
	[Name] [nvarchar](30) NOT NULL,
)

CREATE TABLE [Item](
	[ItemID] [int] IDENTITY(1,1) PRIMARY KEY,
	[Name] [nvarchar](50) NOT NULL,
	[LocationID] [int] NOT NULL,
	[CategoryID] [int] NOT NULL,
	CONSTRAINT FK_Item_Location FOREIGN KEY (LocationID)
		REFERENCES dbo.Location (LocationID)
		ON DELETE CASCADE
		ON UPDATE CASCADE,
	CONSTRAINT FK_Item_Category FOREIGN KEY(CategoryID)
		REFERENCES Category (CategoryID)
		ON DELETE CASCADE
		ON UPDATE CASCADE
)