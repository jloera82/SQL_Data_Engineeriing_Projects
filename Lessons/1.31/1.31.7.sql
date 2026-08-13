-- 1.31.7

USE data_jobs;

WITH company_skill_list AS (
    SELECT
        jpf.company_id,
        ARRAY_LENGTH(ARRAY_AGG(DISTINCT sjd.skill_id)) AS unique_skills_count
        FROM job_postings_fact AS jpf
        INNER JOIN skills_job_dim AS sjd ON jpf.job_id = sjd.job_id
        GROUP BY jpf.company_id
),
ranked_companies AS (
    SELECT
        cd.name,
        csl.unique_skills_count,
        DENSE_RANK() OVER(ORDER BY csl.unique_skills_count DESC) AS diversity_rank
    FROM company_skill_list AS csl
    INNER JOIN company_dim AS cd ON csl.company_id = cd.company_id
)
SELECT * FROM ranked_companies WHERE diversity_rank <= 10;