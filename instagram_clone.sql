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
IF OBJECT_ID('photos', 'u') IS NOT NULL
DROP TABLE photos
GO

-- Create Tables -- 
CREATE TABLE users
(
	id INT IDENTITY(1,1) PRIMARY KEY,
	username VARCHAR(255) UNIQUE NOT NULL,
	created_at DATETIME DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE photos
(
	id INT IDENTITY(1,1) PRIMARY KEY,
	image_url VARCHAR(255) NOT NULL,
	user_id INT NOT NULL,
		FOREIGN KEY(user_id) REFERENCES users(id),
	created_at DATETIME DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE comments
(
	id INT IDENTITY(1,1) PRIMARY KEY,
	comment_text VARCHAR(255) NOT NULL,
	user_id INT NOT NULL,
		FOREIGN KEY(user_id) REFERENCES users(id),
	photo_id INT NOT NULL,
		FOREIGN KEY(photo_id) REFERENCES photos(id),
	created_at DATETIME DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE likes
(
	-- No need for id because likes table is not being reference anyway
	user_id INT NOT NULL,
		FOREIGN KEY(user_id) REFERENCES users(id),
	photo_id INT NOT NULL,
		FOREIGN KEY(photo_id) REFERENCES photos(id),
	created_at DATETIME DEFAULT CURRENT_TIMESTAMP
	-- This will not allow user to insert more than 1 like with the same user_id and photo_id
	PRIMARY KEY (user_id, photo_id)
);

CREATE TABLE follows
(
	follower_id INT NOT NULL,
		FOREIGN KEY (follower_id) REFERENCES users(id),
	followee_id INT NOT NULL,
		FOREIGN KEY (followee_id) REFERENCES users(id),
	created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
	PRIMARY KEY (follower_id, followee_id)
);

CREATE TABLE tags
(
	id INT IDENTITY(1,1) PRIMARY KEY,
	tag_name VARCHAR(255) UNIQUE,
	created_at DATETIME DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE photo_tags
(
	photo_id INT NOT NULL,
		FOREIGN KEY (photo_id) REFERENCES photos(id),
	tag_id INT NOT NULL,
		FOREIGN KEY (tag_id) REFERENCES tags(id),
	PRIMARY KEY(photo_id, tag_id)
);



-- INSERT STATEMENTS ------------------
INSERT INTO users (username) VALUES ('bambam'),('mark'),('jackson');
INSERT INTO photos (image_url, user_id) VALUES ('/asdfsadf',1),('/afdfdf',2),('/sdasaf',3)
INSERT INTO comments (comment_text, user_id, photo_id) VALUES ('Good shot!', 1, 2),('Nice photo!', 3, 2),('Hi Mark!', 3, 2);
INSERT INTO likes (user_id, photo_id) VALUES (1,1),(2,1),(1,2),(1,3),(3,3);
-- This won't work because of primary key constraint
-- INSERT INTO likes (user_id, photo_id) VALUES (1,1);
INSERT INTO follows (follower_id, followee_id) VALUES (1,2),(1,3),(2,1),(2,3);
INSERT INTO tags (tag_name) VALUES ('food'),('cat'),('travel');
INSERT INTO photo_tags(photo_id,tag_id) VALUES (1,1),(1,2),(1,3),(2,3);











-- SELECT STATEMENTS ------------------
--SELECT photos.image_url, users.username
--FROM photos
--JOIN users	
--	ON photos.user_id = users.id;