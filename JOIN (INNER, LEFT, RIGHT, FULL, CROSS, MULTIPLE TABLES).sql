-----	 JOIN	-----

-- createing tables school_left and school_right
CREATE TABLE school_left (
	id integer CONSTRAINT left_key_id PRIMARY KEY,
	left_school varchar(50)
);

CREATE TABLE school_right (
	id integer CONSTRAINT right_id_key PRIMARY KEY,
	right_school varchar(50)
);

-- inserting data into tables
INSERT INTO school_left VALUES 
	(1, 'Oak Street School'),
    (2, 'Roosevelt High School'),
    (5, 'Washington Middle School'),
    (6, 'Jefferson High School');


INSERT INTO school_right VALUES
	(1, 'Oak Street School'),
    (2, 'Roosevelt High School'),
    (3, 'Morrison Elementary'),
    (4, 'Chase Magnet Academy'),
    (6, 'Jefferson High School');
	
	
CREATE TABLE school_enrollment (
	id integer,
	enrollment integer
);

CREATE TABLE school_grades(
	id integer,
	grades varchar(10)
);

INSERT INTO school_enrollment VALUES
	(1, 360),
    (2, 1001),
    (5, 450),
    (6, 927);
	
INSERT INTO school_grades VALUES
    (1, 'K-3'),
    (2, '9-12'),
    (5, '6-8'),
    (6, '9-12');
	
	

-- checking tables
SELECT * FROM school_left;

SELECT * FROM school_right;

SELECT * FROM school_enrollment;

SELECT * FROM school_grades;


---	JOIN (INNER JOIN)	---
-- returns rows from both tables where matching values are found
SELECT * 
FROM school_left JOIN school_right
ON school_left.id = school_right.id;

--- LEFT JOIN	---
-- returns all the rows from the left table plus rows that match 
-- the key value from the right table
SELECT * 
FROM school_left LEFT JOIN school_right
ON school_left.id = school_right.id;

--- RIGHT JOIN	---
-- retuns all the rows from the right table pluts rows that
-- match the key value from the left table
SELECT *
FROM school_left RIGHT JOIN school_right
ON school_left.id = school_right.id;

---	FULL OUTER JOIN	---
-- returns all rows from both tables and matches
-- the once that have the same key value
SELECT *
FROM school_left FULL OUTER JOIN school_right
ON school_left.id = school_right.id;

---	CROSS JOIN	---
-- returns every possible combination of rows
-- from both tables
SELECT *
FROM school_left CROSS JOIN school_right;

---	FINDING MISSING DATA	---

-- find columns with missing data in the right table
SELECT *
FROM school_left LEFT JOIN school_right
ON school_left.id = school_right.id
WHERE school_right.id IS NULL;

-- find data that is not missing in the right table
SELECT *
FROM school_left FULL JOIN school_right
ON school_left.id = school_right.id
WHERE school_right.id IS NOT NULL;

-- return all rows from the left table and rows from 
-- the right table that match the left table
-- all columns except id from the right table
-- simplify table aliases
SELECT lt.id,
	   lt.left_school,
	   rt.right_school
FROM school_left as lt LEFT JOIN school_right as rt
ON lt.id = rt.id;

--- JOINING MULTIPLE TABLES	---
-- return all the rows from left school
-- values that match from school_enrollment and school_grades
SELECT lt.id, lt.left_school, en.enrollment, gr.grades
FROM school_left AS lt LEFT JOIN school_enrollment AS en
	ON lt.id = en.id
LEFT JOIN school_grades AS gr
	ON lt.id = gr.id;
