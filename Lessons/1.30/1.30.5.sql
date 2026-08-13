-- 1.30.5 

USE data_jobs;

WITH ranked_postings AS (
    SELECT
    company_id,
    job_id,
    job_posted_date,
    ROW_NUMBER() OVER(PARTITION BY company_id ORDER BY job_posted_date DESC) AS recency_rank
    FROM job_postings_fact
)

SELECT * FROM ranked_postings WHERE recency_rank = 1;
