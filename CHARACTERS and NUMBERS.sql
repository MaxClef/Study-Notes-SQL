-----	CHARACTERS	-----

-- char(n) : doesn't use the empty space
-- varchar(n): uses the empty space (usually the best option just need the apropriate n value)
-- text : doesn't use the empty space
--e.g., :
-- varchar_col | text_col | char_col |
-- abc|			abc|	   abc		 |



-----	NUMBERS	-----

--- INTEGERS ---
-- smallint (2 bytes): -327,68 to +327,67
-- integer (4 bytes): -2,147,483,648 to +2,147,483,647
--bigint (8bytes): -9,223,372,036,854,775,808 to +9,223,372,036,854,775,807


--- AUTO-INCREMENTING INTEGERS (usially used for the column ID) ---
-- smallserial (2 bytes): 1 to 32,767
-- serial (4 bytes): 1 to 2,147,483,647
-- bigserial (8 bytes): 1 to 9,223,372,036,854,775,807 

---	DECIMAL	---
CREATE TABLE decimal_data_types (
	numeric_col numeric(20, 5),
	real_col real,
	double_col double precision
);

INSERT INTO decimal_data_types
VALUES
	(.7, .7, .7),
	(2.13579, 2.13579, 2.13579),
	(2.1357987654, 2.1357987654, 2.1357987654);

SELECT * FROM decimal_data_types;
--result:
"numeric_col"	"real_col"	"double_col"
0.70000 |	0.7	  |   0.7
2.13579	|  2.13579|  2.13579
2.13580	|2.1357987|	2.1357987654

-- 1. use integers when possible
-- 2. use numeric or decimal for exact calculations










