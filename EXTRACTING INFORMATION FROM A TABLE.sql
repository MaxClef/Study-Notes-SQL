-- public libraries data from 2009
SELECT * FROM pls_fy2009_pupld09a;

-- public libraries data from 2014
SELECT * FROM pls_fy2014_pupld14a;


---    COUNT	---

-- 2009
SELECT count(*) FROM pls_fy2009_pupld09a;
"count"
9299

-- 2014
SELECT count(*) FROM pls_fy2014_pupld14a;
"count"
9305


-- counting values in a column salaries

-- 2009
SELECT count(salaries) FROM pls_fy2009_pupld09a;
"count"
5938

-- 2014
SELECT count(salaries) FROM pls_fy2014_pupld14a;
"count"
5983

-- looks like there is missing data in 'salaries'
-- checking:
-- 2009
SELECT count(*) AS missing_in_salaires_2009
FROM pls_fy2009_pupld09a
WHERE salaries IS NULL;
"missing_in_salaires_2009"
3361

-- 2014
SELECT count(*) AS missing_in_slaries_2014
FROM pls_fy2014_pupld14a
WHERE salaries IS NULL;
"missing_in_slaries_2014"
3322

----------------------------------------------------------------

---    DISTINCT    ---
-- used to omit duplicates of values in a column

-- counting the number of unique library names 
-- 2009
SELECT count(DISTINCT(libname)) FROM pls_fy2009_pupld09a;
"count"
8501

-- 2014
SELECT count(DISTINCT(libname)) FROM pls_fy2014_pupld14a;
"count"
8515

-- looks like there are duplicate values in 'library name' column
-- for both 2009 and 2014

-----------------------------------------------------------------

---    MIN and MAX	---

--return minimum and maximum values from 
-- column 'visits' for both 2009 and 2014
-- 2009
SELECT min(visits) AS minimum_visits,
	   max(visits) AS maximum_visits
FROM pls_fy2009_pupld09a;
"minimum_visits"	"maximum_visits"
-3				17941990
	
-- 2014
SELECT min(visits) AS minimum_visits,
	   max(visits) AS maximum_visits
FROM pls_fy2014_pupld14a;
"minimum_visits"  	"maximum_visits"
-3				17729020

-- -3 might be a mistake or have a meaning behind it
-- somthing that might need to be checked with the
-- creators of the survey

---------------------------------------------------------------

---    SUM	---
-- calculating the sum of the row

-- return:
-- 1. total visits for 2009 and 2014
-- omit values < 0
SELECT sum(data_2009.visits) AS visits_2009,
	   sum(data_2014.visits) AS visits_2014
FROM pls_fy2009_pupld09a AS data_2009 
	 JOIN pls_fy2014_pupld14a AS data_2014
ON data_2009.fscskey = data_2014.fscskey
WHERE data_2009.visits >= 0 AND data_2014.visits >= 0

-- return:
-- 1. sum of visits by states 2009 and 2014
-- 2. difference of visits number in percentage
-- 3. order by percentge change descending
SELECT data_2009.stabr AS state_abbreviation,
	   sum(data_2009.visits) AS visits_2009,
	   sum(data_2014.visits) AS visits_2014,
	   round( (CAST(sum(data_2014.visits) AS decimal(10,1)) - sum(data_2009.visits))
			/ sum(data_2009.visits) * 100, 2) AS pct_change
FROM pls_fy2009_pupld09a AS data_2009 
	 JOIN pls_fy2014_pupld14a AS data_2014 
ON data_2009.fscskey = data_2014.fscskey
WHERE data_2009.visits >= 0 AND data_2014.visits >= 0
GROUP BY data_2009.stabr
ORDER BY pct_change DESC;

---------------------------------------------------------------

---    GROUP BY	---
-- grouping results according to values in one or more columns

-- return:
-- state code 'stabr'
-- 2. group by state
-- 3. order ascending
SELECT stabr FROM pls_fy2014_pupld14a
GROUP BY stabr
ORDER BY stabr ASC;

-- return:
-- 1. city and state code
-- 2. group by city and state code
-- 3. order by city and state code ascending
-- data from 2014
SELECT city, stabr AS state_abb
FROM pls_fy2014_pupld14a
GROUP BY city, stabr
ORDER BY city, stabr;

-- return:
-- 1. each state and the number of library agencies
-- 2. order descending by the number of library agencies
-- data from 2014
SELECT stabr AS state_abb, count(*) AS number_of_libraries
FROM pls_fy2014_pupld14a
GROUP BY state_abb
ORDER BY number_of_libraries DESC;

-- return:
-- 1. counting the number agencies in each state that moved or didn't
-- 'stataddr' = address change code:
--		a. 00 - no change from last year
--		b. 07 - moved to a new location
--		c. 15 - minor address change
-- 2. order by state ascending and count descending
-- data from 2014
SELECT stabr AS state_abb, 
	   stataddr AS address_chage, 
	   count(*) AS num_agencies_that_changed
FROM pls_fy2014_pupld14a
GROUP BY state_abb, address_chage
ORDER BY state_abb ASC, num_agencies_that_changed DESC;

--------------------------------------------------------------

---    HAVING	---
-- unlike WHERE, HAVING places conditions on groups created
-- by aggregating

SELECT data_2009.stabr AS state_abbreviation,
	   sum(data_2009.visits) AS visits_2009,
	   sum(data_2014.visits) AS visits_2014,
	   round( (CAST(sum(data_2014.visits) AS decimal(10,1)) - sum(data_2009.visits))
			/ sum(data_2009.visits) * 100, 2) AS pct_change
FROM pls_fy2009_pupld09a AS data_2009 
	 JOIN pls_fy2014_pupld14a AS data_2014 
ON data_2009.fscskey = data_2014.fscskey
WHERE data_2009.visits >= 0 AND data_2014.visits >= 0
GROUP BY data_2009.stabr
HAVING sum(data_2014.visits) > 50000000
ORDER BY pct_change DESC;

--------------------------------------------------------------

---	EXERCISES 1.	---

-- return:
-- persentage by state of each public internet usage betweeen 2009 and 2014

-- checking for irregularities in the numerical columns:
--	a. gpterms = the number of innternet-connected computers used by the public
--  b. pitusr = internet computers used by general public

SELECT data_2009.libname AS library_name,
	   data_2009.stabr AS state_abbreviation, 
	   min(data_2009.gpterms) AS gpt_2009_min,
	   min(data_2014.gpterms) AS gpt_2014_min
FROM pls_fy2009_pupld09a AS data_2009 
	 INNER JOIN pls_fy2014_pupld14a AS data_2014 
ON data_2009.fscskey = data_2014.fscskey
GROUP BY library_name, state_abbreviation
HAVING min(data_2009.gpterms) < 0 
OR min(data_2014.gpterms) < 0
ORDER BY library_name;

-- looks like there are 42 rows (combined 2009 and 2014)
-- where negative values are present in column 'gpterms'

SELECT data_2009.libname AS library_name,
	   data_2009.stabr AS state_abbreviation, 
	   min(data_2009.pitusr) AS pitusr_2009_min,
	   min(data_2014.pitusr) AS pitusr_2014_min
FROM pls_fy2009_pupld09a AS data_2009 
	 INNER JOIN pls_fy2014_pupld14a AS data_2014 
ON data_2009.fscskey = data_2014.fscskey
GROUP BY library_name, state_abbreviation
HAVING min(data_2009.pitusr) < 0 
OR min(data_2014.pitusr) < 0
ORDER BY library_name;

-- looks like there are 46 rows (combined 2009 and 2014)
-- where negative values are present in column 'pitusr'


-- will omit negative values
SELECT data_2009.stabr AS state_abbreviation,
	   sum(data_2009.gpterms) AS pgterms_2009,
	   sum(data_2014.gpterms) AS pgterms_2014,
	   round( (CAST(sum(data_2014.gpterms) AS decimal(10,1)) - sum(data_2009.gpterms)) /
			 sum(data_2009.gpterms) * 100, 2) AS pgterms_pct_change,
	   sum(data_2009.pitusr) AS pitusr_2009,
	   sum(data_2014.pitusr) AS pitusr_2014,
	   round( (CAST(sum(data_2014.pitusr) AS decimal(10,1)) - sum(data_2009.pitusr)) /
			 sum(data_2009.pitusr) * 100, 2) AS pitusr_pct_change
FROM pls_fy2009_pupld09a AS data_2009 
	 INNER JOIN pls_fy2014_pupld14a AS data_2014 
ON data_2009.fscskey = data_2014.fscskey
GROUP BY state_abbreviation
HAVING min(data_2009.gpterms) >= 0 AND min(data_2014.gpterms) >= 0
OR (min(data_2009.pitusr) >= 0 
	AND min(data_2014.pitusr) >= 0)
ORDER BY state_abbreviation; 
	 
	 
---	EXERCISES 2.	---

-- return:
-- all the data that is missing in one or the other table
SELECT *
FROM pls_fy2009_pupld09a AS data_2009 
	 FULL OUTER JOIN pls_fy2014_pupld14a AS data_2014 
ON data_2009.fscskey = data_2014.fscskey
WHERE data_2009.fscskey IS NULL OR data_2014.fscskey IS NULL;