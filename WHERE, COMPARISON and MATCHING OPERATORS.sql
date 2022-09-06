------ 	 WHERE	------
-- filtering rows

-- return teachers 
-- 1. last_name, school, and hire_date 
-- 2. from 'Myers Middle School'
SELECT last_name, school, hire_date
FROM teachers
WHERE school = 'Myers Middle School';

-----	COMPARISON and MATCHING OPERATORS   ----- 

-- 1. = : equal to

-- 2. <> or != : not equal to
SELECT * FROM teachers
WHERE school != 'Myers Middle School';

-- 3. > : greater than
-- 4. < : less than
-- 5. >= / <= greater than or equal / less than or equal
SELECT * FROM teachers 
WHERE salary > 40000;

-- 6. BETWEEN : with in the range including the values 
SELECT * FROM teachers
WHERE salary BETWEEN 40000 AND 65000;

-- 7. IN : if any of the values match
SELECT * FROM teachers
WHERE first_name IN ( 'Lee', 'Samuel' );

-- 8. LIKE : matching a pattern (case sensitive)
-- % : wildcard matching one or more characters
-- _ : wildcard matching just one character
SELECT * FROM teachers
WHERE first_name LIKE 'S%';


-- 9. ILIKE : matching a pattern (case insensitive)
SELECT * FROM teaechers
WHERE first_name ILIKE 'SAM%';

-- NOT : negateing a condition
SELECT * FROM teachers
WHERE first_name NOT ILIKE 's%'



















