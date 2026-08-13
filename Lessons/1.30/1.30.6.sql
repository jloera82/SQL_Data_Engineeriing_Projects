-- 1.30.6

USE data_jobs;

SELECT *
FROM (
    SELECT
    job_id,
    job_title_short,
    salary_year_avg,
    RANK() OVER(PARTITION BY job_title_short ORDER BY salary_year_avg DESC) AS salary_rank
    FROM job_postings_fact
    WHERE salary_year_avg IS NOT NULL
) AS ranked_salaries
WHERE salary_rank <= 3;