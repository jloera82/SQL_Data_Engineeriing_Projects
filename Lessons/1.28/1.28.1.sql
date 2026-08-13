-- Creating Remote Jobs Table (1.28.1) - Problem
-- 1.28 SET Operators
-- Problem Statement
-- Create a dedicated table for analyzing remote job postings. You will use the CTAS (Create Table As Select) statement to create a new table within a specific schema, populate it with joined data from existing tables, and filter it for a specific date range.

USE company_jobs;

CREATE SCHEMA work_mode_mart;

CREATE TABLE work_mode_mart.remote_jobs AS
SELECT
j.job_title,
j.company_id,
j.job_location
FROM data_jobs.job_postings_fact AS j
WHERE j.job_work_from_home = TRUE
AND j.job_location = 'Anywhere';

SELECT COUNT(*) AS remote_rows
FROM work_mode_mart.remote_jobs;