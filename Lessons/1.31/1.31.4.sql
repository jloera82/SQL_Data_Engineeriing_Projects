-- 1.31.4

WITH job_skill_counts AS (
    SELECT
        jpf.job_id,
        jpf.job_title_short,
        ARRAY_LENGTH(ARRAY_AGG(sjd.skill_id)) AS num_skills
    FROM job_postings_fact AS jpf
    INNER JOIN skills_job_dim AS sjd ON jpf.job_id = sjd.job_id
    WHERE jpf.job_title_short IN ('Data Engineer', 'Data Analyst')
    GROUP BY jpf.job_id, jpf.job_title_short
)

SELECT job_title_short, AVG(num_skills) AS avg_skills_required
FROM job_skill_counts
GROUP BY job_title_short;