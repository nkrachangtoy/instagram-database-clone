# Instagram Clone

Re-building a Instagram clone using ASP.NET Core 3.0 as the Backend, React as Frontend, and MySQL as the database.

## Goals

[x] Build Database with MySQL

[ ] Build RESTful API with .NET Core 3.0

[ ] Build Frontend with React

## Requirement

- [MySQL](https://dev.mysql.com/downloads/)
- ASP.NET 3.0
- React

## Diagram

![ERD](https://i.imgur.com/QL7Rl2F.png)

## Challenges

### 1. Find 5 oldest users

<details>
<summary>Solution</summary>
<p>

```sql=
    SELECT *
    FROM users
    ORDER BY created_at
    LIMIT 5;
```

</p>
<p>
Result
</p>
<img src="https://i.imgur.com/UcVUivX.png" />
</details>

### 2. Find most popular registration date

<details>
<summary>Solution</summary>
<p>

```sql=
    SELECT
	DAYNAME(created_at) AS day,
	COUNT(*) AS total
    FROM users
    GROUP by day
    ORDER BY total DESC;
```

</p>
<p>
Result
</p>
<img src="https://i.imgur.com/t3XmJgo.png" />
</details>

### 3. Find inactive users (signed up but never posted a photo)

<details>
<summary>Solution</summary>
<p>

```sql=
    SELECT username
    FROM users
    LEFT JOIN photos
	ON users.id = photos.user_id
    WHERE photos.id IS NULL;

-- OR --

    SELECT username
    FROM photos
    RIGHT JOIN users
	ON users.id = photos.user_id
    WHERE photos.id IS NULL;
```

</p>
<p>
Result

</p>
<img src="https://i.imgur.com/7iaslkJ.png" />
</details>

### 4. Find the most popular photo and user who posted it

<details>
<summary>Solution</summary>
<p>

```sql=
-- This will get all the photos with total       likes
    SELECT
        photos.id,
        photos.image_url,
        COUNT(*) as Total
    FROM photos
    INNER JOIN likes
	    ON likes.photo_id = photos.id
    GROUP BY photos.id;

-- This will get the photo with the most number of likes
    SELECT
        photos.id,
        photos.image_url,
        COUNT(*) as Total
    FROM photos
    INNER JOIN likes
	    ON likes.photo_id = photos.id
    GROUP BY photos.id
    ORDER BY Total DESC
    LIMIT 1;

-- This will identify the username that posted the photo
    SELECT
        username,
        photos.id AS PhotoId,
        photos.image_url,
        COUNT(*) as Total
    FROM photos
    INNER JOIN likes
	    ON likes.photo_id = photos.id
    INNER JOIN users
	    ON photos.user_id = users.id
    GROUP BY photos.id
    ORDER BY Total DESC
    LIMIT 1;
```

</p>
<p>
Result
</p>
<img src="https://i.imgur.com/XTbR1Un.png" />
</details>

### 5. Calculate average number of photos per user

<details>
<summary>Solution</summary>
<p>

```sql=
    SELECT
	(SELECT COUNT(*) FROM photos) / (SELECT         COUNT(*) FROM users) AS avg;
```

</p>
<p>
Result
</p>
<img src="https://i.imgur.com/CtApF5J.png" />
</details>

### 6. Find five most commonly used hashtags

<details>
<summary>Solution</summary>
<p>

```sql=
    SELECT
        tags.tag_name,
        COUNT(*) AS total
    FROM photo_tags
    JOIN tags
	    ON photo_tags.tag_id = tags.id
    GROUP BY tags.id
    ORDER BY total DESC
    LIMIT 5;
```

</p>
<p>
Result
</p>
<img src="https://i.imgur.com/uyEDYHC.png" />
</details>

### 7. Find bots -> user who liked every single photo

<details>
<summary>Solution</summary>
<p>

```sql=
    SELECT
        username,
        COUNT(*) AS total
    FROM users
    INNER JOIN likes
	    ON users.id = likes.user_id
    GROUP BY likes.user_id
    HAVING total = (SELECT COUNT(*) FROM     photos);
```

</p>
<p>
Result
</p>
<img src="https://i.imgur.com/n75fYt2.png" />
</details>
