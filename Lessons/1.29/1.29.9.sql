-- Notes

USE data_jobs;

SELECT
job_id,
job_title,
job_location
FROM job_postings_fact
WHERE NULLIF(TRIM(job_title), TRIM(job_location)) IS NULL;