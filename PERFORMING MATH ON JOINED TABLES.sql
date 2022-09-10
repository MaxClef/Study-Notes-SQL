-----	Perfrming Math on Joined Table Columns	-----

-- check tables us_counties_2010 and us_counties_2000
SELECT * FROM us_counties_2000;
SELECT * FROM us_counties_2010;


-- calculate how the population grew or declined 
-- (don't show counties where the population stayed the same)
-- in each county between 2000 and 2010
-- show numer and percentage
-- order by percentage descending
SELECT DISTINCT c2010.geo_name,
	   c2010.state_us_abbreviation AS state,
	   c2010.p0010001 AS population_2010,
	   c2000.p0010001 AS population_2000,
	   c2010.p0010001 - c2000.p0010001 AS raw_difference,
	   round( (CAST(c2010.p0010001 AS numeric(8,1)) - c2000.p0010001)
           / c2000.p0010001 * 100, 2 ) AS pct_difference
FROM us_counties_2010 AS c2010 INNER JOIN us_counties_2000 AS c2000
ON c2010.state_fips = c2000.state_fips
	AND c2010.county_fips = c2000.county_fips
	AND c2010.p0010001 <> c2000.p0010001
ORDER BY pct_difference DESC;



-- search what counties didn't exist in 2000 but exist in 2010
SELECT c2010.geo_name,
	   c2010.state_us_abbreviation,
       c2000.geo_name
FROM us_counties_2010 AS c2010 FULL JOIN us_counties_2000 AS c2000
ON c2010.state_fips = c2000.state_fips
	AND c2010.county_fips = c2000.county_fips
WHERE c2000.geo_name IS NULL;




-- calculate the median of the percent change in county population
SELECT percentile_cont(.5)
	WITHIN GROUP( ORDER BY round( ( CAST (c2010.p0010001 AS numeric(8,1)) -  c2000.p0010001)
				/ c2000.p0010001 * 100, 2 )) AS median_pct_change
FROM us_counties_2010 AS c2010 INNER JOIN us_counties_2000 AS c2000
ON c2010.state_fips = c2000.state_fips
	AND c2010.county_fips = c2000.county_fips;


-- which county has the greatest percentage loss of population
SELECT DISTINCT c2010.geo_name,
	   c2010.state_us_abbreviation AS state,
	   c2000.p0010001 AS population_2000,
	   c2010.p0010001 AS population_2010,
	   round ( (CAST (c2010.p0010001 AS numeric (8,1)) - c2000.p0010001)
	   			/ c2000.p0010001 * 100, 2 ) AS pct_difference
FROM us_counties_2010 AS c2010 LEFT JOIN us_counties_2000 AS c2000
ON c2010.state_fips = c2000.state_fips
	AND c2010.county_fips = c2000.county_fips
ORDER BY pct_difference;