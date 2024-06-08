SELECT * FROM binary_tree;

SELECT	node,
		CASE WHEN parent IS NULL THEN 'Root'
			 WHEN node IN (SELECT parent FROM binary_tree) THEN 'Inner'
             ELSE 'Leaf'
		END AS node_type
FROM	binary_tree
ORDER BY 1
;
