CREATE TABLE binary_tree
(
node INT,
parent INT
);

INSERT INTO binary_tree VALUES(1,2);
INSERT INTO binary_tree VALUES(3,2);
INSERT INTO binary_tree VALUES(6,8);
INSERT INTO binary_tree VALUES(9,8);
INSERT INTO binary_tree VALUES(2,5);
INSERT INTO binary_tree VALUES(8,5);
INSERT INTO binary_tree VALUES(5,NULL);

SELECT * FROM binary_tree;

SELECT	node,
		CASE WHEN parent IS NULL THEN 'Root'
			WHEN node IN (SELECT parent FROM binary_tree) THEN 'Inner'
            ELSE 'Leaf'
		END AS node_type
FROM	binary_tree
ORDER 	BY node;

WITH RECURSIVE tree_enlist(node, node_type) AS
(
SELECT node, CAST('Root' AS CHAR(10)) AS node_type FROM binary_tree WHERE parent IS NULL
UNION ALL
SELECT bt.node, CAST('Inner' AS CHAR(10)) AS node_type FROM binary_tree bt, tree_enlist te WHERE bt.parent = te.node AND EXISTS (SELECT 1 FROM binary_tree btt WHERE bt.node = btt.parent)
UNION ALL
SELECT bt.node, CAST('Leaf' AS CHAR(10)) AS node_type FROM binary_tree bt, tree_enlist te WHERE bt.parent = te.node AND NOT EXISTS (SELECT 1 FROM binary_tree btt WHERE bt.node = btt.parent)
)
SELECT * FROM tree_enlist ORDER BY node;

/* Level Order Traversal */
WITH RECURSIVE tree_traverse(node, tree_level, parent, node_path) AS
(
SELECT node, 
		1 AS tree_level, 
		CAST(NULL AS UNSIGNED) AS parent, 
        CONCAT("/", node) AS node_path 
FROM binary_tree 
WHERE parent IS NULL

UNION ALL

SELECT bt.node, 
		tt.tree_level + 1 AS tree_level, 
        tt.node AS parent, 
        CONCAT(tt.node_path, "/", bt.node) AS node_path 
FROM binary_tree bt, tree_traverse tt 
WHERE bt.parent = tt.node
)
SELECT * FROM tree_traverse;

		




