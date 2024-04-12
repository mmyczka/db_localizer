-- Drop the database if it exists
IF EXISTS (SELECT * FROM sys.databases WHERE NAME = 'db_localizer_recursive')
    DROP DATABASE db_localizer_recursive;
GO

-- Create the database
CREATE DATABASE db_localizer_recursive;
GO

USE db_localizer_recursive;
GO

CREATE TABLE [Category](
	[CategoryID] [int] IDENTITY(1,1) PRIMARY KEY,
	[Name] [nvarchar](30)
)

CREATE TABLE [Item](
	[ItemID] [int] IDENTITY(1,1) PRIMARY KEY,
	[Name] [nvarchar](50) NOT NULL,
	[ContainerID] [int],
	[CategoryID] [int] NOT NULL,
	CONSTRAINT FK_Item_Category FOREIGN KEY(CategoryID)
		REFERENCES Category (CategoryID)
		ON DELETE CASCADE
		ON UPDATE CASCADE
)
GO

ALTER TABLE Item  WITH CHECK ADD FOREIGN KEY([ContainerID])
REFERENCES Item ([ItemID])
GO