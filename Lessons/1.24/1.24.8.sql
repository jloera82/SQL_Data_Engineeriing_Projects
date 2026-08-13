-- Synchronizing Skill Priority Levels (1.24.8) - Problem
-- 1.24 DDL & DML - Pt. 3
-- Problem Statement
-- After successfully cleaning up stale records in the previous exercise, the priority rankings for various technical skills have been finalized in the staging environment. You've been tasked to synchronize these rankings with the production job_skill_priorities table. Because new high-priority skills like 'aws' have been identified, you must handle both updating existing records and inserting new associations for jobs that require these skills.

USE company_jobs;

INSERT INTO staging.priority_skills (skill_id,skill_name,priority_lvl)
VALUES (77, 'aws', 3);

MERGE INTO job_skill_priorities AS tgt
USING (
    SELECT
    sjd.job_id,
    ps.skill_id,
    ps.skill_name,
    ps.priority_lvl
    FROM data_jobs.skills_job_dim AS sjd
    INNER JOIN staging.priority_skills AS ps
    ON sjd.skill_id = ps.skill_id
) AS src
ON tgt.job_id = src.job_id
AND tgt.skill_id = src.skill_id

WHEN MATCHED THEN
    UPDATE SET
        priority_lvl = src.priority_lvl,
        skill_name = src.skill_name

WHEN NOT MATCHED THEN
    INSERT (job_id,skill_id, skill_name, priority_lvl, status)
    VALUES 
    (src.job_id, src.skill_id, src.skill_name, src.priority_lvl, 'NEW_SKILL');


SELECT * FROM staging.priority_skills;

SELECT * FROM job_skill_priorities
ORDER BY job_id;

/*
Connect to company_jobs: duckdb md:company_jobs opens a DuckDB session pointing at the shared company_jobs database so all queries run against that dataset.
Staging Data Preparation:
The query begins by populating the staging.priority_skills table with a new record for 'aws' using an INSERT INTO statement. By assigning skill_id 77 and priority_lvl 3, we establish the requirements that will be pushed to the production table.

Synchronization Logic (MERGE with Subquery):
The MERGE statement synchronizes the job_skill_priorities target table using a source subquery. This subquery joins data_jobs.skills_job_dim with our staging table to identify every unique job that requires a priority skill.

Composite Join Condition: To ensure data integrity, the merge matches records based on both job_id and skill_id. This prevents overlapping skill updates across different job listings.
Handling Matches: When a job-skill pair already exists (WHEN MATCHED), the UPDATE clause synchronizes the priority_lvl and skill_name to match the latest staging definitions.
Handling New Records: When a priority skill is found in a job but is missing from the target table (WHEN NOT MATCHED), the INSERT clause adds the new record and flags it with a status of 'NEW_SKILL'.
*/