-- UNIONS

--UNION : removes duplicates
SELECT UNNEST([1,1,1,2])
UNION
SELECT UNNEST([1,1,3]);


-- UNION ALL Shows all data from both tables
SELECT UNNEST([1,1,1,2])
UNION ALL
SELECT UNNEST([1,1,3]);

--INTERSECTS

--INTERSECT
SELECT UNNEST([1,1,1,2])
INTERSECT
SELECT UNNEST([1,1,3]);

--INTERSECT ALL : duplicates preserved
SELECT UNNEST([1,1,1,2])
INTERSECT ALL
SELECT UNNEST([1,1,3]);

-- EXCEPTS

-- EXCEPT : duplicates are removed
SELECT UNNEST([1,1,1,2])
EXCEPT
SELECT UNNEST([1,1,3]);

-- EXCEPT ALL : one for one duplicate removal

SELECT UNNEST([1,1,1,2])
EXCEPT ALL
SELECT UNNEST([1,1,3]);

CREATE TEMP TABLE jobs_2023 AS
--DESCRIBE
SELECT * EXCLUDE(job_id,job_posted_date)
FROM job_postings_fact
WHERE EXTRACT(YEAR FROM job_posted_date) = 2023;

SELECT * FROM jobs_2023;


CREATE TEMP TABLE jobs_2024 AS
--DESCRIBE
SELECT * EXCLUDE(job_id,job_posted_date)
FROM job_postings_fact
WHERE EXTRACT(YEAR FROM job_posted_date) = 2024;

SELECT * FROM jobs_2024;


SELECT 'jobs_2023' AS table_name,COUNT(*) FROM jobs_2023
UNION
SELECT 'jobs_2024' AS table_name,COUNT(*) FROM jobs_2024;

SELECT 'jobs_2023' AS table_name,COUNT(*) FROM jobs_2023
UNION ALL
SELECT 'jobs_2024' AS table_name,COUNT(*) FROM jobs_2024;