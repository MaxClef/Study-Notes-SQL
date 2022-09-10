-- AVERAGE, SUM and MEDIAN

-- return
-- 1. sum of the total population
-- 2. average 
SELECT sum(p0010001) AS sum_population,
	round( avg(p0010001), 0) avg_population,
	percentile_cont(.5)
	WITHIN GROUP (ORDER BY p0010001) as county_median
FROM us_counties_2010;

-- return
-- 1. quantiles
SELECT unnest(percentile_cont(array[.25, .5, .75])
	WITHIN GROUP (ORDER BY p0010001)) AS quantiles
FROM us_counties_2010;

-- return 
-- 1. mode of population
SELECT mode() WITHIN GROUP( ORDER BY p0010001 ) 
	AS population_mode
FROM us_counties_2010;


-----	EXERCISES	-----

-- 1. return:
-- area of a circle with a radius of 5 inches
SELECT pi() * ( 5 ^ 2 );


-- 2. return:
-- which New York countie has the highest percentage of "American Indian/Alaska Native Alone"
SELECT geo_name, 
	state_us_abbreviation, 
	p0010001,
	p0010005,
	CAST ( p0010005 AS NUMERIC (8,1)) / p0010001 * 100 AS pct_found
FROM us_counties_2010
WHERE state_us_abbreviation = 'NY'
ORDER BY pct_found DESC;


-- 3. return:
-- median in California and New York
SELECT percentile_cont(.5)
		WITHIN GROUP(ORDER BY p0010001)
FROM us_counties_2010
WHERE state_us_abbreviation IN ('CA', 'NY')
GROUP BY state_us_abbreviation;
