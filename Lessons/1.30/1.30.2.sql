-- 1.30.2

USE data_jobs;

SELECT
job_id,
job_location,
salary_year_avg,
AVG(salary_year_avg) OVER(PARTITION BY job_location) AS location_job_salary
FROM job_postings_fact
WHERE salary_year_avg IS NOT NULL;