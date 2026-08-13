-- 1.31.9

USE data_jobs;

WITH job_skills_count AS (
    SELECT 
        jpf.job_id,
        jpf.company_id,
        ARRAY_LENGTH(ARRAY_AGG(DISTINCT sjd.skill_id)) AS skill_count
    FROM job_postings_fact AS jpf
    INNER JOIN skills_job_dim AS sjd ON jpf.job_id = sjd.job_id
    GROUP BY jpf.job_id, jpf.company_id
),
company_averages AS (
    SELECT 
        company_id,
        AVG(skill_count) AS avg_skills_per_company
    FROM job_skills_count
    GROUP BY company_id
)
SELECT 
    jsc.job_id,
    jsc.skill_count,
    ca.avg_skills_per_company
FROM job_skills_count AS jsc
INNER JOIN company_averages AS ca ON jsc.company_id = ca.company_id
WHERE jsc.skill_count > ca.avg_skills_per_company
ORDER BY jsc.skill_count DESC
LIMIT 100;