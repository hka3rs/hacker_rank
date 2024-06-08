DROP TABLE IF EXISTS city;

CREATE TABLE city
(
id		NUMERIC,
name	VARCHAR(17),
countrycode	VARCHAR(3),
district	VARCHAR(20),
population	NUMERIC
);

SELECT name FROM city WHERE countrycode = 'JPN';


