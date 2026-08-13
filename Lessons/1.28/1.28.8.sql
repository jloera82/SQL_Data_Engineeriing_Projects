-- Unmatched Remote Record Frequency (1.28.8) - Problem
-- 1.28 SET Operators
-- Problem Statement
-- In the final step of our data audit, we need to identify the exact count of discrepancies between our tables. While a standard subtraction removes duplicates, we now need to find records in remote_jobs that do not have a corresponding 1-to-1 match in not_remote_jobs.

USE company_jobs;

SELECT job_title,company_id,job_location
FROM work_mode_mart.remote_jobs
EXCEPT ALL
SELECT job_title,company_id,job_location
FROM work_mode_mart.not_remote_jobs
ORDER BY job_location, company_id, job_title;