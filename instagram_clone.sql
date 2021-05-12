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