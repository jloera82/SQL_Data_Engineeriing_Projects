-- Exclusive Remote Job Listings (1.28.7) - Problem
-- 1.28 SET Operators
-- Problem Statement
-- In this exercise, you want to ensure that your remote job listings are truly unique. You will compare the remote_jobs table against the not_remote_jobs table to identify any records that exist in the remote dataset but do not have a matching entry in the non-remote dataset.

USE company_jobs;

SELECT job_title,company_id,job_location
FROM work_mode_mart.remote_jobs
EXCEPT
SELECT job_title,company_id,job_location
FROM work_mode_mart.not_remote_jobs
ORDER BY job_location, company_id, job_title;