SELECT
job_title_short,
salary_hour_avg,
CASE
    WHEN salary_hour_avg < 25 THEN 'Low'
    WHEN salary_hour_avg < 50 THEN 'Medium'
    ELSE 'High'
END AS salary_category
FROM job_postings_fact
WHERE salary_hour_avg IS NOT NULL
LIMIT 10;

-- Handling Nulls

SELECT
job_title_short,
salary_hour_avg,
CASE
    WHEN salary_hour_avg IS NULL THEN 'MIssing'
    WHEN salary_hour_avg < 25 THEN 'Low'
    WHEN salary_hour_avg < 50 THEN 'Medium'
    ELSE 'High'
END AS salary_category
FROM job_postings_fact
--WHERE salary_hour_avg IS NOT NULL
LIMIT 10;

-- categorizing categorical values

SELECT
    job_title,
    CASE
        WHEN job_title LIKE '%Data%' AND job_title LIKE '%Analyst%' THEN 'Data Analyst'
        WHEN job_title LIKE '%Data%' AND job_title LIKE '%Engineer%' THEN 'Data Endgineer'
        WHEN job_title LIKE '%Data%' AND job_title LIKE '%Scientist%' THEN 'Data Scientist'
        ELSE 'Other'
    END AS job_title_category,
    job_title_short
FROM job_postings_fact
ORDER BY RANDOM()
LIMIT 20;


-- conditional Aggregation

SELECT
job_title_short,
COUNT(*) AS total_postings,
MEDIAN(
    CASE
        WHEN salary_year_avg < 100000 THEN salary_year_avg
    END
) AS median_log_salary,
MEDIAN(
    CASE
        WHEN salary_year_avg >= 100000 THEN salary_year_avg
    END
) AS median_high_salary,
FROM job_postings_fact
WHERE salary_year_avg IS NOT NULL
GROUP BY job_title_short;

-- Categorize salaries into tiers of low, medium, high

WITH salaries AS (
SELECT
job_title_short,
salary_hour_avg,
salary_year_avg,
CASE
    WHEN salary_year_avg IS NOT NULL THEN salary_year_avg
    WHEN salary_hour_avg IS NOT NULL THEN salary_hour_avg*2080
END AS standardized_salary
FROM job_postings_fact
WHERE salary_year_avg IS NOT NULL OR salary_hour_avg IS NOT NULL
--LIMIT 10;
)

SELECT *,
CASE
    WHEN standardized_salary IS NULL THEN 'Missing'
    WHEN standardized_salary < 75000 THEN 'Low'
    WHEN standardized_salary < 150000 THEN 'Medium'
    ELSE 'High'
END AS salary_bucket
FROM salaries
ORDER BY standardized_salary
LIMIT 10;