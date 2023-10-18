/*
3) Для этой задачи вам нужно создать простой оператор SELECT, который вернет все столбцы из people таблицы,
и присоединиться к sales таблице, чтобы вы могли вернуть COUNT всех продаж и
ранжировать каждого человека по их количеству продаж.

    Таблица people
        id
        name


    Таблица sales
        id
        people_id
        sale
        price

Вы должны вернуть все поля людей, а также количество продаж как «sale_count» и рейтинг как «sale_rank».
*/

/*
DROP TABLE IF EXISTS people;

CREATE TABLE people (
  id INTEGER NOT NULL PRIMARY KEY AUTO_INCREMENT,
  name VARCHAR(255)
  );
  
INSERT INTO people (name)
VALUES 
  ('Иванов Иван Иванович'),
  ('Петр Петр Петрович');
  
CREATE TABLE sales (
  id INTEGER NOT NULL PRIMARY KEY AUTO_INCREMENT,
  people_id INTEGER references people(id),
  sale BIGINT UNSIGNED,
  price DECIMAL(65, 2)
  );

  
INSERT INTO sales (people_id, sale, price)
VALUES 
  (1, 20, 123.123),
  (2, 25, 456.456),
  (2, 30, 678.910);

SELECT * FROM people;
SELECT * FROM sales;
*/

SELECT
  people.name,
  count(sales.sale) AS 'sale_count',
  ROW_NUMBER() OVER(ORDER BY people.name DESC) AS 'sale_rank'
FROM people
LEFT JOIN sales ON people.id = sales.people_id
GROUP BY people.name
ORDER BY 'sale_count' DESC;
