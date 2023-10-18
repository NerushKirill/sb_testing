-- CREATE DATABASE zuzex_test
--     WITH
--     OWNER = postgres
--     ENCODING = 'UTF8'
--     CONNECTION LIMIT = -1
--     IS_TEMPLATE = False;

DROP TABLE 
  Users,
  Posts,
  Votes,
  Comments;

/* create */
CREATE TABLE IF NOT EXISTS Users (
  Id SERIAL PRIMARY KEY,
  Reputation INTEGER NOT NULL,
  CreationDate DATE NOT NULL,
  DisplayName TEXT,
  LastAcessDate DATE,
  WebSiteUrl TEXT,
  Location TEXT,
  Age INTEGER,
  AboutMe TEXT,
  Views INTEGER,
  UpVotes INTEGER,
  DownVotes INTEGER
);

CREATE TABLE IF NOT EXISTS Posts (
  Id SERIAL PRIMARY KEY,
  CreationDate DATE,
  Score INTEGER,
  ViewCount INTEGER,
  Body TEXT,
  OwnerUserId INTEGER REFERENCES Users(Id),
  LastEditorUserId INTEGER REFERENCES Users(Id),
  LastEditDate DATE,
  LastActivityDate DATE,
  Title TEXT,
  Tags TEXT,
  ClosedDate DATE
);

CREATE TABLE IF NOT EXISTS Votes (
  Id SERIAL PRIMARY KEY,
  PostId INTEGER REFERENCES Posts(Id),
  CreationDate DATE,
  UserId INTEGER REFERENCES Users(Id)
);

CREATE TABLE IF NOT EXISTS Comments (
  Id SERIAL PRIMARY KEY,
  PostId INTEGER REFERENCES Posts(Id),
  Text TEXT,
  CreationDate DATE,
  UserId INTEGER REFERENCES Users(Id)
);


/* insert */
INSERT INTO Users (Reputation, CreationDate, DisplayName, LastAcessDate, WebSiteUrl, Location, Age, AboutMe, Views, UpVotes, DownVotes)
VALUES (10, '2023-06-01', 'Vasya', '2023-06-12', 'vk.com/id1234567890', 'Rostov', 23, 'Hello, world!', 5, 2, 1),
       (2, '2023-06-02', 'Misha', '2023-06-05', 'vk.com/id0987654321', 'Rostov', 27, '*Hello, world!*', 1, 1, 0),
       (0, '2023-06-07', 'Petya', '2023-06-13', 'vk.com/id1122334455', 'Moscow', 21, '', 0, 0, 0),
       (0, '2023-06-09', 'Stepan', '2023-06-12', 'vk.com/id5544332211', 'Rostow', 18, '', 0, 0, 0);
	   
INSERT INTO Posts (CreationDate, Score, ViewCount, Body, OwnerUserId, LastEditorUserId, LastEditDate, LastActivityDate, Title, Tags, ClosedDate)
VALUES ('2023-06-02', 3, 3, 'This is post #1', 1, 1, '2023-06-02', '2023-06-02', 'My New Post', 'new_post', '2023-06-02'),
       ('2023-06-04', 1, 4, 'This is post #2', 1, 1, '2023-06-04', '2023-06-05', 'My Second Post', 'second_post', '2023-06-05'),
	     ('2023-06-11', 6, 8, 'This is post #3', 1, 1, '2023-06-12', '2023-06-12', 'My Best Post', 'best_post', '2023-06-12'),
	     ('2023-06-05', 2, 3, 'This is post #1', 2, 2, '2023-06-05', '2023-06-05', 'My First Post', 'first_post', '2023-06-05'),
	     ('2022-06-05', 2, 3, 'This is post #1', 2, 2, '2023-06-05', '2023-06-05', 'My First Post', 'first_post', '2023-06-05'),
	     ('2021-06-05', 2, 3, 'This is post #1', 2, 2, '2023-06-05', '2023-06-05', 'My First Post', 'first_post', '2023-06-05');

INSERT INTO Votes (PostId, CreationDate, UserId)
VALUES (1, '2023-06-02', 2),
       (4, '2023-06-05', 1);
	   
INSERT INTO Comments (PostId, Text, CreationDate, UserId)
VALUES (1, 'BEST POST!!!', '2023-06-02', 2),
       (1, '*_*', '2023-06-02', 4),
       (4, 'Not bad))', '2023-06-05', 1),
	     (4, '*****))', '2023-06-05', 3),
	     (4, 'Funny))', '2023-06-05', 3);
	   

-- SELECT * FROM Users;
-- SELECT * FROM Posts;
-- SELECT * FROM Votes;
-- SELECT * FROM Comments;

/*
1 Написать запрос для вывода пользователей, которые не создали ни одного
поста и не оставили ни одного коммента. (несколько вариантов запроса)
*/
/* Самый простой вариант, на мой взгляд */
SELECT
  u.Id,
  u.Reputation,
  u.Displayname,
  p.OwnerUserId AS post,
  c.UserId AS comment
FROM Users u
LEFT JOIN Posts p ON u.Id = p.OwnerUserId
LEFT JOIN Comments c ON u.Id = c.UserId
WHERE p.OwnerUserId IS NULL AND c.UserId IS NULL;

/* Так можно до бесконечности :) */
WITH post AS (
	SELECT
	  u.Id,
	  u.Reputation,
      u.Displayname,
      p.OwnerUserId
	FROM Users u
	LEFT JOIN Posts p ON u.Id = p.OwnerUserId
	WHERE p.OwnerUserId IS NULL),
comm AS (
	SELECT
	  u.Id,
	  u.Reputation,
      u.Displayname,
      c.UserId
	FROM Users u
	LEFT JOIN Comments c ON u.Id = c.UserId
	WHERE c.UserId IS NULL
)
SELECT
  p.id,
  p.displayname,
  p.OwnerUserId,
  c.UserId
FROM post p
JOIN comm c ON p.id = c.id;

/*
2. Написать запрос для вывода года, кол-ва постов за год и кол-во комментов за
год.
*/
WITH post AS (
  SELECT
	EXTRACT(YEAR FROM CreationDate) AS age_posts,
	COUNT(Id) AS count_post
  FROM Posts
  GROUP BY age_posts
),
comm AS (
  SELECT
	EXTRACT(YEAR FROM CreationDate) AS age_comments,
	COUNT(Id) AS count_comm
  FROM Comments
  GROUP BY age_comments
)
SELECT 
  age_posts AS age,
  count_post,
  count_comm
FROM post p
FULL OUTER JOIN comm c ON p.age_posts = c.age_comments;

/*
3. Вывести 3 самых активных (по кол-ву комментариев) пользователей (display
name) и их кол-во комментариев
*/
SELECT
  us.DisplayName,
  comment_count
FROM 
  (SELECT
     c.UserId AS user_,
     COUNT(c.UserId) AS comment_count
   FROM Comments c
   GROUP BY user_) com
LEFT JOIN Users us ON com.user_ = us.Id
ORDER BY comment_count DESC
LIMIT 3;

/*
4. Расширить п.3, добавив процент кол-ва комментариев пользователя от общего
кол-ва
*/
SELECT
  us.DisplayName,
  com.comment_count,
  CONCAT(com.comment_count::float / (SELECT COUNT(*) FROM Comments) * 100, '%') AS percentage_total
FROM 
  (SELECT
     c.UserId AS user_,
     COUNT(c.UserId) AS comment_count
   FROM Comments c
   GROUP BY user_) com
LEFT JOIN Users us ON com.user_ = us.Id
ORDER BY comment_count DESC
LIMIT 3;
