-- Creating Not Remote Jobs Table (1.28.2) - Problem
-- 1.28 SET Operators
-- Problem Statement
-- Create a dedicated table for analyzing non-remote job postings. You will use the CTAS (Create Table As Select) statement to create a new table within a specific schema, populate it with joined data from existing tables, and filter it for a specific date range.

USE company_jobs;

CREATE TABLE work_mode_mart.not_remote_jobs AS
SELECT
job_title,
company_id,
job_location
FROM data_jobs.job_postings_fact
WHERE job_work_from_home <> TRUE 
OR job_work_from_home IS NULL;

SELECT COUNT(*) AS not_remote_rows
FROM work_mode_mart.not_remote_jobs;