-- NOTES

USE data_jobs;

WITH location_stage AS (
    SELECT job_id, LOWER(TRIM(job_location)) AS loc_clean
    FROM job_postings_fact
)
SELECT 
job_id,
loc_clean,
CASE
    WHEN loc_clean LIKE '%remote%' THEN 'Remote'
    WHEN loc_clean LIKE '%anywhere%' THEN 'Remote'
    WHEN NULLIF(loc_clean, '') IS NULL THEN 'Global'
    ELSE 'On-Site/Hybrid'
END AS location_category
FROM location_stage;