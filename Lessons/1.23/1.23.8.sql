-- Identifing python - required data engineer roles 

SELECT jpf.job_id,jpf.job_title_short
FROM job_postings_fact AS jpf
WHERE jpf.job_title_short = 'Data Engineer'
AND EXISTS (
    SELECT 1
    FROM skills_job_dim AS sjd
    INNER JOIN skills_dim AS sd ON sjd.skill_id = sd.skill_id
    WHERE sjd.job_id = jpf.job_id
    AND sd.skills = 'python'
);