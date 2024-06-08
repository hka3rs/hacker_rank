WITH RECURSIVE gen_numbers AS
(
	SELECT 2 AS n
    UNION ALL
    SELECT n+1 FROM gen_numbers
    WHERE n < 1000
),
gen_pairs AS
(
	SELECT A.n AS n1, B.n AS n2 FROM gen_numbers A INNER JOIN gen_numbers B ON (B.n <= A.n)
),
division AS
(
	SELECT n1, n2, n1*1.0%n2*1.0 AS rem FROM gen_pairs
),
count_rem AS
(
	SELECT n1, COUNT(1) AS cnt FROM division WHERE rem=0.0 GROUP BY n1 HAVING cnt=1
)
SELECT GROUP_CONCAT(n1 separator '&') AS prime_number FROM count_rem;


