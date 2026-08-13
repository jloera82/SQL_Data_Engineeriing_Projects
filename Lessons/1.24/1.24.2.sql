-- Populating Active Job Skill Priorities (1.24.2) - Problem
-- 1.24 DDL & DML - Pt. 3
-- Problem : You have access to the shared company_jobs MotherDuck catalog, which includes a staging.priority_skills table listing skill IDs your company has flagged as high priority.

-- Your task is to build a curated table in the main schema that pairs job postings with their associated skills — but only for skills that appear on the priority list.

USE company_jobs;

CREATE TABLE IF NOT EXISTS job_skill_priorities (
    job_id INT,
    skill_id INT,
    skill_name VARCHAR,
    priority_lvl INT,
    status VARCHAR
);

INSERT INTO job_skill_priorities (job_id,skill_id,status)
SELECT
sjd.job_id,
sjd.skill_id,
'ACTIVE' AS status
FROM data_jobs.skills_job_dim AS sjd
INNER JOIN staging.priority_skills AS ps
ON sjd.skill_id = ps.skill_id;

SELECT * FROM job_skill_priorities;
