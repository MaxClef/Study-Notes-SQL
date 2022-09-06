t-- check out teachers table
SELECT * FROM teachers;

-- return lsat_name, first_name, salary
SELECT last_name, first_name, salary FROM teachers;


--------    DISTINCT    --------

-- return unique schools
SELECT DISTINCT school
FROM teachers;

-- return unique school and salaries
SELECT DISTINCT school, salary
FROM teachers;

------   ORDER BY 	-----------
-- ASC: ascending order
-- DESC: descending order

SELECT last_name, first_name, salary
FROM teachers
ORDER BY salary DESC;

-- sort by school ASSC and hire_date DESC
SELECT last_name, school, hire_date
FROM teachers
ORDER BY school ASC, hire_date DESC;