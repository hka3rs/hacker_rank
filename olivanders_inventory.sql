
SELECT  A.id,
        B.age,
        A.coins_needed,
        A.power
FROM    wands A
INNER JOIN
(

SELECT  X.code,
        Y.age,
        X.power,
        MIN(X.coins_needed) AS min_coins_needed
FROM    wands X
        INNER JOIN wands_property Y ON (X.code = Y.code)
WHERE   is_evil = 0
GROUP BY 1, 2, 3

) B ON (A.power = B.power AND A.coins_needed = B.min_coins_needed AND A.code = B.code)
ORDER BY 4 DESC, 2 DESC

;