WITH pivot_occupation AS
(
    SELECT CASE WHEN occupation = 'Doctor' THEN name END AS doctor,
           CASE WHEN occupation = 'Professor' THEN name END AS professor,
           CASE WHEN occupation = 'Singer' THEN name END AS singer,
           CASE WHEN occupation = 'Actor' THEN name END as actor
    FROM    occupations
),
doctors AS
(
    SELECT DENSE_RANK() OVER(ORDER BY doctor) AS rnk_col,
           doctor FROM pivot_occupation 
    WHERE doctor IS NOT NULL
),
professors AS
(
    SELECT DENSE_RANK() OVER(ORDER BY professor) AS rnk_col,
           professor FROM pivot_occupation 
    WHERE professor IS NOT NULL
),
singers AS
(
        SELECT DENSE_RANK() OVER(ORDER BY singer) AS rnk_col,
           singer FROM pivot_occupation 
    WHERE singer IS NOT NULL
),
actors AS
(
        SELECT DENSE_RANK() OVER(ORDER BY actor) AS rnk_col,
           actor FROM pivot_occupation 
    WHERE actor IS NOT NULL
),
join_doctor_professor AS
(
    SELECT rnk_col, doctor, professor
    FROM doctors LEFT JOIN professors USING(rnk_col)
    UNION
    SELECT rnk_col, doctor, professor
    FROM doctors RIGHT JOIN professors USING(rnk_col)
),
join_doctor_professor_singer AS
(
    SELECT rnk_col, doctor, professor, singer FROM join_doctor_professor LEFT JOIN singers USING(rnk_col)
    UNION
    SELECT rnk_col, doctor, professor, singer FROM join_doctor_professor RIGHT JOIN singers USING(rnk_col)
),
join_doctor_professor_singer_actor AS
(
    SELECT doctor, professor, singer, actor FROM join_doctor_professor_singer LEFT JOIN actors USING(rnk_col)
    UNION
    SELECT doctor, professor, singer, actor FROM join_doctor_professor_singer RIGHT JOIN actors USING(rnk_col)   
)
SELECT * FROM join_doctor_professor_singer_actor;