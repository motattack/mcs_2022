UPDATE Animals
SET Sex = CASE
	WHEN Sex = 'male' THEN 'm'
	WHEN Sex = 'female' THEN 'w'
	WHEN Sex NOTNULL THEN 'unknown'
END;
