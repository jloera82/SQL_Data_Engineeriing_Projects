-- 1.30.12

USE data_jobs;

WITH salary_ranges AS (
    SELECT
    job_id,
    job_title_short,
    salary_year_avg,
    MIN(salary_year_avg) OVER(PARTITION BY job_title_short) AS min_s,
    MAX(salary_year_avg) OVER(PARTITION BY job_title_short) AS max_s
    FROM job_postings_fact
    WHERE salary_year_avg IS NOT NULL
)
SELECT *,
(salary_year_avg - min_s) / NULLIF(max_s - min_s, 0) AS normalized_salary_score
FROM salary_ranges;