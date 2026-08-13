-- Shared Job Metadata Overlap (1.28.5) - Problem
-- 1.28 SET Operators
-- Problem Statement
-- As a data engineer, it is important to identify records that might appear in multiple datasets unexpectedly. In this task, you will compare the remote_jobs and not_remote_jobs tables to find job postings that share the exact same job_title, company_id, and job_location in both tables.

USE company_jobs;

SELECT job_title,company_id,job_location
FROM work_mode_mart.remote_jobs
INTERSECT
SELECT job_title,company_id,job_location
FROM work_mode_mart.not_remote_jobs
ORDER BY job_location, company_id, job_title;