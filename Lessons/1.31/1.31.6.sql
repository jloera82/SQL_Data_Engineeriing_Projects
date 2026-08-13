-- 1.31.6

WITH aggregated_source AS (
    SELECT
        job_id,
        ARRAY_AGG(skill_id) AS skill_id_array
    FROM skills_job_dim
    GROUP BY job_id
),
flattened_source AS (
    SELECT
        job_id,
        UNNEST(skill_id_array) AS skill_id
    FROM aggregated_source
)
SELECT
    fs.job_id,
    sd.skills AS skill_name
FROM flattened_source AS fs
INNER JOIN skills_dim AS sd ON fs.skill_id = sd.skill_id;
