-- 1.30.11

USE data_jobs;

WITH company_spending AS (
    SELECT
    company_id,
    job_id,
    salary_year_avg,
    SUM(salary_year_avg) OVER(PARTITION BY company_id) AS total_company_sped
    FROM job_postings_fact
    WHERE salary_year_avg IS NOT NULL
)
SELECT
*,
(salary_year_avg / total_company_sped) * 100 AS percent_of_total_spend
FROM company_spending;