-- 1.29 Text NULL Functions

SELECT name, LOWER(TRIM(name)) AS normalized_name
FROM company_dim;