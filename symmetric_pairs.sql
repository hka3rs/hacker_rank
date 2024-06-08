WITH f1 AS
(
SELECT  f1.x, f1.y, ROW_NUMBER() OVER() AS rno
FROM    functions f1
)
SELECT  
        CASE WHEN f11.x <= f11.y THEN f11.x 
             WHEN f12.x <= f12.y THEN f12.x
         END AS x1,
        CASE WHEN f11.x <= f11.y THEN f11.y
             WHEN f12.x <= f12.y THEN f12.y
         END AS y1
FROM    f1 f11 INNER JOIN f1 f12 ON(f11.x = f12.y AND f12.x = f11.y AND f11.rno < f12.rno)
ORDER BY 1
;