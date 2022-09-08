-----	BASIC MATH AND STATS	-----

-- addition
SELECT 2 + 2 AS addition;


-- subtraction
SELECT 4 - 1 AS subtraction;


-- multiplication
SELECT 2 * 2 AS multipliction;


-- division
SELECT 11 / 6 AS division; -- result is 1
SELECT CAST(11 AS numeric(3,1)) / 6; -- result 1.833...


-- modulo/remainder
SELECT 11 % 6 AS remainder;


-- exponential
SELECT 4 ^ 2 AS exponential;


-- square root
SELECT |/ 16 AS square_root;
-- or
SELECT sqrt(16) AS square_root;


-- cube root
SELECT ||/ 16 AS cube_root;


-- factorial
SELECT factorial(4) AS factorial_number;


-- order of operations
CREATE TABLE order_results (
	no_parentheses numeric (10,3),
	yes_parentheses numeric (10,3)
);

INSERT INTO order_results
VALUES (7 + 8 * 9, (7 + 8) * 9),
	   (3 ^ 3 - 1, 3 ^ (3 - 1));
	   
SELECT * FROM order_results;
"no_parentheses"	|	"yes_parentheses"
-------------------------------------------
79.000				|	135.000
26.000				|	9.000



-----	MATH ACROSS TABLE COLUMNS	-----

-- checking data
SELECT geo_name,
       state_us_abbreviation AS "st",
       p0010001 AS "Total Population",
       p0010003 AS "White Alone",
       p0010004 AS "Black or African American Alone",
       p0010005 AS "Am Indian/Alaska Native Alone",
       p0010006 AS "Asian Alone",
       p0010007 AS "Native Hawaiian and Other Pacific Islander Alone",
       p0010008 AS "Some Other Race Alone",
       p0010009 AS "Two or More Races"
FROM us_counties_2010;

-- return:
-- 1. geo_name
-- 2. state_us_abbreviation
-- 3. white alone
-- 4. black alone
-- 5. total white and black
SELECT geo_name, 
	state_us_abbreviation as st,
	p0010003 AS white_alone,
	p0010004 AS black_alone,
	p0010003 + p0010004 AS white_and_black
FROM us_counties_2010;

-- return:
-- 1. geo_name
-- 2. state_us_abbreviation
-- 3. total_population
-- 4. asian_alone
-- 5. total population except asian_alone
SELECT geo_name,
	state_us_abbreviation AS st,
	p0010001 AS total_population,
	p0010006 AS asian_alone,
	p0010001 - p0010006 AS total_without_asian
FROM us_counties_2010;