-- Work Mode List (1.28.3) - Problem
-- 1.28 SET Operators
-- Problem Statement
-- In the previous exercises, you separated job postings into distinct tables based on their work-from-home status. Now, you need to consolidate these datasets back into a single, unified view to see the complete list of available roles across all work modes.

USE company_jobs;

SELECT
job_title,
company_id,
job_location
FROM work_mode_mart.remote_jobs
UNION
SELECT
job_title,
company_id,
job_location
FROM work_mode_mart.not_remote_jobs
ORDER BY job_location, company_id, job_title;