/*
 * При сдаче лабораторной работы необходимо ОБЯЗАТЕЛЬНО ВОСПРОИЗВЕСТИ результат.
 * Просьба создать полные копии таблиц Customer и Employee и в дальнейшем работать с ними
 */
 
DROP TABLE m_Customer;

CREATE TABLE m_Customer AS
SELECT * FROM Customer;
-- Вообще это НЕ ПОЛНЫЕ КОПИИ (метаданные/ограничения не копируются)

DROP TABLE m_Employee;

CREATE TABLE m_Employee AS
SELECT * FROM Employee;
-- Вообще это НЕ ПОЛНЫЕ КОПИИ (метаданные/ограничения не копируются)

/*
 * 1) Проанализировать созданную альтернативную таблицу Customer, 
 * вывести страны и количества записей для каждой из них (1 запросом)
 */
SELECT Country,
	   count(*) as "Count"
FROM m_Customer
GROUP BY Country;

/*
 * 2) Для страны с самым большим количеством записей удалить из 
 * таблицы строку(ки) имеющую(ие) информацию о компании
 */
DELETE FROM m_Customer
WHERE CustomerId in
	(SELECT mc.CustomerId
		FROM m_Customer mc
		WHERE Country in
			(SELECT Country
				FROM m_Customer
				GROUP BY Country
				ORDER BY count(*) DESC
				LIMIT 1
			)
		AND Company NOTNULL
	);
 
/*
 * 3) Вставить данные из таблицы Employee в таблицу полученную в задании 2, отсутствующие данные заполнить NULL
 */
INSERT INTO m_Customer(
	FirstName, LastName,
	Address, City, State,
	Country, PostalCode,
	Phone, Fax, Email)
SELECT
	FirstName, LastName,
	Address, City, State,
	Country, PostalCode,
	Phone, Fax, Email
FROM m_Employee;

SELECT * FROM m_Customer;

/*
 * 4) Добавить пользователя Evangeline Lilly 
 */
INSERT INTO m_Customer(FirstName, LastName)
VALUES ("Evangeline", "Lilly");

/*
 * 5) Исправить ошибку возникникшую в данных (подсказка задание 2 и 4)
 * Упрощение: в пятом задании достаточно показать адекватную таблицу содержащую не все данные из предыдущей
 * а только 'FirstName','LastName' и исправленную колонку с ошибкой.
 */

