WITH sgrades_one AS
(
SELECT  name, 
        grade, 
        marks,
        ROW_NUMBER() OVER(ORDER BY grade DESC, 
                          name ASC) AS rno
FROM    students
        INNER JOIN grades ON (students.marks BETWEEN min_mark AND max_mark)
WHERE   grade BETWEEN 8 AND 10
),
sgrades_two AS
(
    SELECT  NULL AS name, 
        grade, 
        marks,
        ROW_NUMBER() OVER(ORDER BY grade DESC, 
                          marks ASC) AS rno
FROM    students
        INNER JOIN grades ON (students.marks BETWEEN min_mark AND max_mark)
WHERE   grade BETWEEN 1 AND 7
)
SELECT name, grade, marks FROM sgrades_one
UNION ALL
SELECT name, grade, marks FROM sgrades_two
;