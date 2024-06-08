-- 1
WITH RECURSIVE print_n(p) AS
(
SELECT 20 AS p
UNION ALL
SELECT p-1
FROM print_n
WHERE p > 1
)
SELECT REPEAT('* ', p) AS pattern FROM print_n
;

-- 2
WITH RECURSIVE print_n(p) AS
(
SELECT 1 AS p
UNION ALL
SELECT p+1
FROM print_n
WHERE p < 20
)
SELECT REPEAT('* ', p) AS pattern FROM print_n
;