-- 1.30.10

USE data_jobs;

WITH salary_trends AS (
    SELECT
    job_title_short,
    salary_year_avg,
    LEAD(salary_year_avg) OVER(PARTITION BY job_title_short ORDER BY job_posted_date) AS next_salary
    FROM job_postings_fact
    WHERE salary_year_avg IS NOT NULL
)
SELECT *,
CASE
    WHEN salary_year_avg > next_salary THEN 'Decreasing'
    WHEN salary_year_avg < next_salary THEN 'Increasing'
END AS trend_direction
FROM salary_trends;