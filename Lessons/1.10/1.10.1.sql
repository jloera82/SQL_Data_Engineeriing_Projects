-- duckdb md:data_jobs

SELECT * FROM information_schema.tables
WHERE table_name LIKE '%dim%';