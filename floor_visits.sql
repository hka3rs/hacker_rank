CREATE TABLE floor_visits
(
name VARCHAR(100),
address VARCHAR(100),
email VARCHAR(100),
floor INT,
resources VARCHAR(100)
);

INSERT INTO floor_visits VALUES('A', 'Bangalore', 'A@gmail.com', 1, 'CPU');
INSERT INTO floor_visits VALUES('A', 'Bangalore', 'A1@gmail.com', 1, 'CPU');
INSERT INTO floor_visits VALUES('A', 'Bangalore', 'A2@gmail.com', 2, 'Desktop');
INSERT INTO floor_visits VALUES('B', 'Bangalore', 'B@gmail.com', 2, 'Desktop');
INSERT INTO floor_visits VALUES('B', 'Bangalore', 'B1@gmail.com', 2, 'Desktop');
INSERT INTO floor_visits VALUES('B', 'Bangalore', 'B2@gmail.com', 1, 'Monitor');

SELECT * FROM floor_visits;

/* the user's total_visits, most_visited_floor, and total resources used by them */

WITH floors_count AS
(
SELECT	name,
		floor,
        COUNT(1) OVER(PARTITION BY name) AS total_visits,
        COUNT(1) OVER(PARTITION BY name, floor) AS floor_counts
FROM	floor_visits
),
max_visited_floor AS
(
SELECT name, total_visits, floor AS most_visited_floor FROM floors_count WHERE floor_counts = (SELECT MAX(floor_counts) FROM floors_count) GROUP BY 1,2,3
),
resources_used AS
(
SELECT name, GROUP_CONCAT(DISTINCT resources SEPARATOR ',') AS resources_used FROM floor_visits GROUP BY name
)
SELECT name, total_visits, most_visited_floor, resources_used FROM max_visited_floor INNER JOIN resources_used USING(name);