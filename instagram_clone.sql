USE master
GO
-- If the database doesn't exist create a new one
IF NOT EXISTS (
	SELECT name
	FROM sys.databases
	WHERE name = 'Instagram_Database_Clone'
)
BEGIN
CREATE DATABASE Instagram_Database_Clone
END
GO

USE Instagram_Database_Clone
GO

-- DROP TABLE Before creating
IF OBJECT_ID('users', 'u') IS NOT NULL
DROP TABLE users
GO

-- Create Tables -- 
CREATE TABLE users
(
	id UNIQUEIDENTIFIER PRIMARY KEY,
	username VARCHAR(255) UNIQUE NOT NULL,
	created_at DATETIME DEFAULT CURRENT_TIMESTAMP
);
