WITH cnt_occupation AS
(
    SELECT COUNT(1) AS cnt, 
           occupation,
           DENSE_RANK() OVER(ORDER BY COUNT(1) ASC, occupation ASC) AS rnk_cnt
    FROM occupations 
    GROUP BY 2
),
name_profession AS
(
SELECT CONCAT(name,'(',LEFT(occupation, 1),')') AS col,
       DENSE_RANK() OVER(ORDER BY name) AS rnk_name
FROM occupations
),
format_cnt_occupation AS
(
SELECT CONCAT('There are a total of ', cnt, 
              CASE WHEN occupation = 'Doctor' THEN ' doctors'
                   WHEN occupation = 'Singer' THEN ' singers'
                   WHEN occupation = 'Actor'  THEN ' actors'
                   WHEN occupation = 'Professor' THEN ' professors'
              END, '.') AS col
FROM cnt_occupation
)
SELECT col from name_profession
UNION
SELECT col from format_cnt_occupation
;