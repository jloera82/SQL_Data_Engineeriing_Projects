-- Duplicate Record Overlap Analysis (1.28.6) - Problem
-- 1.28 SET Operators
-- Problem Statement
-- In your previous analysis, you found unique rows that appeared in both the remote and non-remote datasets. However, to truly understand data quality, you need to see every instance of overlap. If a specific job posting appears multiple times in both tables, you need to see those duplicates reflected in your results.

USE company_jobs;

SELECT job_title,company_id,job_location
FROM work_mode_mart.remote_jobs
INTERSECT ALL
SELECT job_title,company_id,job_location
FROM work_mode_mart.not_remote_jobs
ORDER BY job_location, company_id, job_title;