-----	 CAST	-----
-- transforming values from one type to another

-- transforming timestamp values into a string
SELECT timestamp_col, CAST(timestamp_col AS varchar(10))
FROM date_time_types;

