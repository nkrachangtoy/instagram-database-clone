-- DROP Database before create
DROP DATABASE IF EXISTS ig_clone;
CREATE DATABASE ig_clone;
USE ig_clone; 

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



-- SELECT STATEMENTS ------------------
--SELECT photos.image_url, users.username
--FROM photos
--JOIN users	
--	ON photos.user_id = users.id;