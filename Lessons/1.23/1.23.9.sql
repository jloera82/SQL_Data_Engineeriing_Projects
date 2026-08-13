-- SKills Missing from snedio data Engineer

SELECT sd.skills
FROM skills_dim AS sd
WHERE NOT EXISTS (
    SELECT 1
    FROM skills_job_dim AS sjd
    INNER JOIN job_postings_fact AS jpf ON sjd.job_id = jpf.job_id
    WHERE sjd.skill_id = sd.skill_id
    AND jpf.job_title_short = 'Senior Data Engineer'
);