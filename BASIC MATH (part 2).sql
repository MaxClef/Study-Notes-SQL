-- FINDING PERCENTAGES OF THE WHOLE

-- return:
-- 1. geo_name
-- 2. state_us_abbreviation
-- 3. percetage of asian for each county
-- 4. order by percentade descending
SELECT geo_name,
	state_us_abbreviation AS st,
	(CAST(p0010006 AS numeric(8,1)) / p0010001) * 100 AS percentage_asian
FROM us_counties_2010
ORDER BY percentage_asian DESC;


-- TRACKING PERCENTAGE CHANGE
-- (new_number - old_number) / old_number

-- creating table
CREATE TABLE percent_change (
    department varchar(20),
    spend_2014 numeric(10,2),
    spend_2017 numeric(10,2)
);

-- adding values 
INSERT INTO percent_change
VALUES
    ('Building', 250000, 289000),
    ('Assessor', 178556, 179500),
    ('Library', 87777, 90001),
    ('Clerk', 451980, 650000),
    ('Police', 250000, 223000),
    ('Recreation', 199000, 195000);
	
-- return
-- table + percentage difference spent 
-- order by percentage spent descending
SELECT *, round( (spend_2017 - spend_2014) / spend_2014 * 100, 2) AS pct_spend
FROM percent_change
ORDER BY pct_spend DESC;

