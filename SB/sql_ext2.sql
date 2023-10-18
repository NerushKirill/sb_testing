/*
2) Вы будете использовать таблицу людей, но сосредоточитесь исключительно на name столбце

            name
            Васильев Петр Геннадьевич
            Греф Герман Оскарович

вам будет предоставлено полное имя, и вы должны вернуть имя в столбцах следующим образом.

            Имя         Фамилия     Отчество
            Петр        Васильев    Геннадьевич
            Герман      Греф        Оскарович

Примечание. Не забудьте удалить пробелы вокруг имен в результатах поиска.
*/

/*
DROP TABLE IF EXISTS people;

CREATE TABLE people (
  id INTEGER NOT NULL PRIMARY KEY AUTO_INCREMENT,
  name VARCHAR(255)
  );

INSERT INTO people (name)
VALUES
  ('Васильев Петр Геннадьевич'),
  ('Греф Герман Оскарович');

SELECT * FROM people;
*/

SELECT
  SUBSTRING_INDEX(SUBSTRING_INDEX(name, ' ', 2), ' ', -1) as имя,
  SUBSTRING_INDEX(name, ' ', 1) as фамилия,
  SUBSTRING_INDEX(name, ' ', -1) as отчество
FROM people;
