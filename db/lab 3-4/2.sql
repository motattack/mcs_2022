-- 1) Из таблицы Customer получить новый столбец 'location' описывающий страну и штат Customer'a
SELECT Country || " " || State as location
FROM Customer;


-- 2) Отсортировать Customer по второму символу в почте
SELECT *
FROM Customer
ORDER BY SUBSTRING(Email, 2, 1);


-- 3) Отсортировать Customer по 4 последним цифрам телефона
SELECT *
FROM Customer
-- ORDER BY SUBSTRING(Phone, -1, -4); 
ORDER BY SUBSTRING(replace(replace(replace(replace(replace(Phone, '+', ''), ' ', ''), '-', ''), '(', ''), ')', ''), -4);


/* 4) Отсортировать всех Customer из USA чтобы:
 * NULL по Company были в конце, 
 * SupportRepId были отсортированы по убыванию
 */
SELECT CustomerId,
	   FirstName,
	   LastName,
	   Company,
	   Country,
	   SupportRepId
FROM Customer
WHERE Country = 'USA'
ORDER BY Company IS NULL, SupportRepId DESC;


/* 5) Вывести таблицу Customer, отсортированную по следующим правилам:
 * State = {SP,QC,RJ},
 * страна Denmark,
 * далее все остальные строки.
 * NULL по State указать в конце таблицы
 */
SELECT CustomerId,
	   FirstName,
	   LastName,
	   Company,
	   State,
	   Country,
	   State NOTNULL as is_null
FROM Customer
ORDER BY
	CASE
		WHEN State IN ('SP', 'QC', 'RJ') THEN 1
		WHEN Country = 'Denmark' THEN 2
		WHEN State NOTNULL THEN 3
		ELSE 4
	END
;

