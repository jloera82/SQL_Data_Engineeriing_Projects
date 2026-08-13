-- Categorizing Experience and Remote Status (1.26.4) - Problem
-- 1.26 CASE Expression
-- Problem Statement
-- For all job postings in the data_jobs database that include salary information, analyze the job_title to categorize the role's experience level and determine if the job offers a remote option, returning both classifications as new, derived columns.

USE data_jobs;

SELECT
jpf.job_id,
jpf.job_title,
jpf.salary_year_avg,
    CASE
        WHEN jpf.job_title LIKE '%Senior%' THEN 'Senior'
        WHEN jpf.job_title LIKE '%Manager%' OR jpf.job_title LIKE '%Lead%' THEN 'Lead/Manager'
        WHEN jpf.job_title LIKE '%Junior%' OR jpf.job_title LIKE '%Entry%' THEN 'Junior/Entry'
        ELSE 'Not Specified'
    END AS experience_level,
    CASE
        WHEN jpf.job_work_from_home = TRUE THEN 'Yes'
        ELSE 'No'
    END AS remote_option
FROM job_postings_fact AS jpf
WHERE jpf.salary_year_avg IS NOT NULL
ORDER BY jpf.job_id;