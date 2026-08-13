-- Complete Work Mode List (1.28.4) - Problem
-- 1.28 SET Operators
-- Problem Statement
-- In this task, you will consolidate the datasets for remote and non-remote jobs into a single list. Unlike previous exercises where you may have filtered for distinct records, the goal here is to ensure every single recorded posting from both tables is included in the final output, even if identical entries exist across the source tables.

USE company_jobs;

SELECT job_title,company_id,job_location
FROM work_mode_mart.remote_jobs
UNION ALL
SELECT job_title,company_id,job_location
FROM work_mode_mart.not_remote_jobs
ORDER BY job_location, company_id, job_title;