/* 1 */
SELECT city, state FROM station;
/* 3 */
SELECT city FROM station WHERE id%2 = 0 GROUP BY 1;
/* 4 */
SELECT COUNT(city) - COUNT(DISTINCT city) FROM station;
/* 5 */
WITH asc_city AS
(
    SELECT city,
        LENGTH(city) AS l_city,
        DENSE_RANK() OVER(ORDER BY LENGTH(city) ASC, city ASC) AS rnk_city
    FROM    station
),
desc_city AS
(
    SELECT city,
            LENGTH(city) AS l_city,
            DENSE_RANK() OVER(ORDER BY LENGTH(city) DESC, city ASC) AS rnk_city
    FROM station
)
SELECT city, l_city FROM asc_city WHERE rnk_city = 1
UNION
SELECT city, l_city FROM desc_city WHERE rnk_city = 1
;
/* 6 */
SELECT city FROM station WHERE REGEXP_LIKE(city, '^[aeiou]', 'i') GROUP BY 1;
/* 7 */
SELECT city FROM station WHERE REGEXP_LIKE(city, '[aeiou]$', 'i') GROUP BY 1;
/* 8 */
SELECT city FROM station WHERE REGEXP_LIKE(city, '^[aeiou].*[aeiou]$')
-- INTERSECT
-- SELECT city FROM station WHERE REGEXP_LIKE(city, '[aeiou]$')
;
-- 9
SELECT city FROM station WHERE NOT REGEXP_LIKE(city, '^[aeiou]') GROUP BY 1;
-- 10
SELECT city FROM station WHERE NOT REGEXP_LIKE(city, '[aeiou]$') GROUP BY 1;
-- 11
SELECT city FROM station WHERE NOT REGEXP_LIKE(city, '^[aeiou].*[aeiou]$') GROUP BY 1;
-- 12
SELECT city FROM station WHERE NOT REGEXP_LIKE(city, '^[aeiou]') AND NOT REGEXP_LIKE(city, '[aeiou]$') GROUP BY 1;

-- 18 
WITH abcd AS
(
    SELECT  MIN(LAT_N) AS a, MIN(LONG_W) AS b, MAX(LAT_N) AS c, MAX(LONG_W) AS d
    FROM    station
)
SELECT ROUND(ABS(a-c) + ABS(b-d),4) AS dist FROM abcd
;
-- 	19
WITH abcd AS
(
    SELECT MIN(LAT_N) AS a, MAX(LAT_N) AS c, MIN(LONG_W) AS b, MAX(LONG_W) AS d
    FROM    station
)
SELECT ROUND(SQRT(POW((a-c),2) + POW((b-d),2)), 4) AS dist FROM abcd
;
-- 20
WITH rowcount AS
(
    SELECT  LAT_N, ROW_NUMBER() OVER(ORDER BY LAT_N) AS rno, PERCENT_RANK() OVER(ORDER BY LAT_N) AS pct_rnk 
    FROM station
)
SELECT ROUND(LAT_N, 4) AS median FROM rowcount WHERE pct_rnk = 0.5
-- SELECT ROUND(LAT_N,4) AS median FROM rowcount WHERE rno = (SELECT CEIL(COUNT(1) / 2) AS mid FROM station);
;



