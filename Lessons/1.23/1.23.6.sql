-- Programming vs Database job volume

WITH core_skills AS (
    SELECT skill_id, type AS skill_type
    FROM skills_dim
    WHERE type IN ('programming','databases')
)

SELECT cs.skill_type, COUNT(DISTINCT sjd.job_id) AS distinct_jobs_count
FROM skills_job_dim AS sjd
INNER JOIN core_skills AS cs ON sjd.skill_id = cs.skill_id
GROUP BY cs.skill_type
ORDER BY distinct_jobs_count DESC;