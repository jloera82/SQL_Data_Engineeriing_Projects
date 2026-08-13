-- 1.31.8

USE data_jobs;

WITH company_salaries AS (
    SELECT 
        company_id,
        ARRAY_AGG(salary_year_avg) AS salary_array,
        AVG(salary_year_avg) AS avg_company_salary
    FROM job_postings_fact
    WHERE salary_year_avg IS NOT NULL
    GROUP BY company_id
),
flattened_salaries AS (
    SELECT 
        company_id,
        avg_company_salary,
        UNNEST(salary_array) AS unnested_result
    FROM company_salaries
)
SELECT 
    company_id,
    unnested_result AS specific_salary,
    avg_company_salary
FROM flattened_salaries
WHERE unnested_result > (avg_company_salary * 1.5);