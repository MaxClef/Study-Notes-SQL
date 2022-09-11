-----	PRIMARY KEY SINTAX	-----


--- ONE COLUMN AS PRIMERY KEY	---
CREATE TABLE natural_key_example (
	license_id varchar(10) CONSTRAINT license_key PRIMARY KEY,
	first_name varchar(50),
	last_name varchar(50)
);

INSERT INTO natural_key_example (license_id, first_name, last_name)
VALUES ('T229901', 'Lynn', 'Marelo');

-- Inserting the data below will not work
-- license_id can not have duplicates in its column
INSERT INTO natural_key_example (license_id, first_name, last_name)
VALUES ('T229901', 'Lynn', 'Marelo');

-- deleting the table
DROP TABLE natural_key_example;

------------------------------------------------------------------------

---	COMPOSITE PRIMERY KEY	---

-- creating a table with two primary keys
-- student_id will be unique for each day
CREATE TABLE natural_key_composite_example (
	student_id varchar(10),
	school_day date,
	present boolean,
	CONSTRAINT student_key PRIMARY KEY(student_id, school_day)
);

-- insert that will work
INSERT INTO natural_key_composite_example
	(student_id, school_day, present)
VALUES (775, '1/1/2022', 'Y');


-- insert that will work
INSERT INTO natural_key_composite_example
	(student_id, school_day, present)
VALUES (775, '1/2/2022', 'Y');

-- insert that will not work (existing student_id on this day)
INSERT INTO natural_key_composite_example
	(student_id, school_day, present)
VALUES (775, '1/2/2022', 'Y');


-- deleting the table
DROP TABLE natural_key_composite_example;

---------------------------------------------------------------

----- AUTO-INCREMENTING SURROGATE KEY	-----
-- creates a column with unique id key

CREATE TABLE surrogate_key_example (
	order_number bigserial,
	product_name varchar(50),
	order_date date,
	CONSTRAINT order_key PRIMARY KEY(order_number)
);

INSERT INTO surrogate_key_example
	(product_name, order_date)
VALUES 
	('Beachball Hat', '2022-01-20'),
	('Baseball Hat', '2022-01-20'),
	('Football Hat', '2022-01-26');
	
SELECT * FROM surrogate_key_example;
-- bigserial is:
-- adding one each time a new column is created
-- does not fill gaps if a row is deleted

DROP TABLE surrogate_key_example;

--------------------------------------------------------------

----- FOREIGN KEYS	-----
-- One or more oclumns in a table that mach
-- the primary key of another table.

-- Values entered must exist in the primary key of the other table.

-- Cannot delete rows from the table that hold the 
-- primary key,without first deleting the rows from 
-- the table that holds the roreign key. To prevent
-- this issue need to use ON DELETE CASCADE keyword.

CREATE TABLE licenses (
	license_id varchar(10),
	first_name varchar(50),
	last_name varchar(50),
	CONSTRAINT licenses_key PRIMARY KEY(license_id)
);

CREATE TABLE registrations(
	registration_id varchar(10),
	registration_date date,
	license_id varchar(10) REFERENCES licenses(license_id) ON DELETE CASCADE,
	CONSTRAINT registration_key PRIMARY KEY(registration_id, license_id)
);

INSERT INTO licenses
	(license_id, first_name, last_name)
VALUES 
	('T229901', 'Lynn', 'Malero');

INSERT INTO registrations
	(registration_id, registration_date, license_id)
VALUES
	('A12345', '1/20/2022', 'T229901');

-- the insert below will not work
-- because 'T000001' is not present in table licenses/license_id
INSERT INTO registrations
	(registration_id, registration_date, license_id)
VALUES
	('A12345', '1/20/2022', 'T000001');
	
SELECT * 
FROM licenses AS l LEFT JOIN registrations AS r
ON l.license_id = r.license_id;

DROP TABLE registrations;
DROP TABLE licenses;

-----------------------------------------------------------------

-----	CHECK	-----
-- evaluating if the data added to a column meets 
-- the expected criteria


-- below creating a table while chacking that:
-- the role is either 'Admin' or 'Staff'
-- the salary is >= 0
-- if the conditions are not met, the data will not be inserted
CREATE TABLE check_constraint_example (
	user_id bigserial,
	user_role varchar(50),
	salary numeric(8,1),
	CONSTRAINT user_id_key PRIMARY KEY(user_id),
	CONSTRAINT check_role CHECK (user_role IN('Admin', 'Staff')),
	CONSTRAINT check_salary CHECK(salary >= 0)
);

-- insert below will not work
-- 'admin' must start with a capital letter
INSERT INTO check_constraint_example
	(user_role, salary)
VALUES
	('admin', 0);

-------------------------------------------------------------------

-----	UNIQUE	-----
-- esures unique having unique values

CREATE TABLE unique_cosntraint_example (
	contact_id bigserial,
	first_name varchar(50),
	last_name varchar(50),
	email varchar(50),
	CONSTRAINT contact_id_key PRIMARY KEY(contact_id),
	CONSTRAINT email_unique UNIQUE(email)
);

INSERT INTO unique_cosntraint_example
	(first_name, last_name, email)
VALUES
	('Sam', 'Lee', 'samlee@mail.com');


INSERT INTO unique_cosntraint_example
	(first_name, last_name, email)
VALUES
	('Tom', 'Lee', 'tomlee@mail.com');

-- insert below will not work
-- 'tomlee@mail.com' alredy exists in the column
INSERT INTO unique_cosntraint_example
	(first_name, last_name, email)
VALUES
	('Tom', 'Smith Lee', 'tomlee@mail.com');

DROP TABLE unique_cosntraint_example;

------------------------------------------------------------

-----	REMOVING/ADDING CONSTRAINTS	-----

CREATE TABLE students (
	student_id bigserial,
	first_name varchar(50) NOT NULL,
	last_name varchar(50) NOT NULL,
	CONSTRAINT student_id_key PRIMARY KEY(student_id)
);

SELECT * FROM students;

-- removing primary key constraint
ALTER TABLE students DROP CONSTRAINT student_id_key;

-- adding primary key constraint
ALTER TABLE students ADD CONSTRAINT student_id_key PRIMARY KEY(student_id);

-- removing not null constraint
ALTER TABLE students ALTER COLUMN first_name DROP NOT NULL;

-- adding not null constraint
ALTER TABLE students ALTER COLUMN first_name SET NOT NULL;

DROP TABLE students;

-------------------------------------------------------------------

----- 	INDEX	-----

SELECT * FROM new_york_addresses;

-- execution time is: 110.9ms
EXPLAIN ANALYZE 
SELECT * FROM new_york_addresses
WHERE street = 'BROADWAY';


-- adding the index
CREATE INDEX street_idx ON new_york_addresses (street);

-- execution time is: 2.146ms
EXPLAIN ANALYZE 
SELECT * FROM new_york_addresses
WHERE street = 'BROADWAY';

DROP INDEX street_idx;

-- CONSIDER:
-- Adding index foregn keys (primary keys are indexed automatically in PostgreSQL).
-- Index columns frequently used in the WHERE clause.
-- Indexes enlarge the database and impose a 
-- maintenance cost on writing data.