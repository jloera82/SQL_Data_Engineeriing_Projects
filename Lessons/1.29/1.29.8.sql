-- Notes

USE data_jobs;

SELECT 
j.job_id,
UPPER(COALESCE(c.name, 'Unknown')) AS company_name_standardized
FROM job_postings_fact AS j
LEFT JOIN company_dim AS c ON j.company_id = c.company_id
WHERE c.name IS NULL;