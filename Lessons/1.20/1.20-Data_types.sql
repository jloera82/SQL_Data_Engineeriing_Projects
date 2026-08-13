SELECT table_name, column_name, data_type
FROM information_schema.columns
WHERE table_name = 'job_postings_fact';

DESCRIBE
SELECT job_title_short, salary_year_avg
FROM job_postings_fact;


-- CAST 
SELECT CAST(123 AS VARCHAR);

-- CAST CONVERSION ERROR
SELECT CAST('123DEF' AS INTEGER);

-- CAST WORKING
SELECT CAST('123' AS INTEGER);

SELECT job_id, job_work_from_home, job_posted_date, salary_year_avg
FROM job_postings_fact
LIMIT 10;

-- CAST BOOLEAN job_work_from_home
SELECT 
CAST(job_id AS VARCHAR) || '-' || CAST(company_id AS VARCHAR), 
CAST(job_work_from_home AS INT) AS job_work_from_home, --from boolean to numeric
CAST(job_posted_date AS DATE) AS job_posted_date, -- from timestamp to date only
CAST(salary_year_avg AS DECIMAL(10,0)) -- from double to no decimal places
FROM job_postings_fact
WHERE salary_year_avg IS NOT NULL
LIMIT 10;

-- duckdb 
SELECT 
job_id::VARCHAR || '-' || company_id::VARCHAR, 
job_work_from_home::INT AS job_work_from_home, --from boolean to numeric
job_posted_date::DATE AS job_posted_date, -- from timestamp to date only
salary_year_avg::DECIMAL(10,0) -- from double to no decimal places
FROM job_postings_fact
WHERE salary_year_avg IS NOT NULL
LIMIT 10;