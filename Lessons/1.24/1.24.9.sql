-- Automating Record Deletion (1.24.9) - Problem
-- 1.24 DDL & DML - Pt. 3
-- Problem Statement
-- In this scenario, you are optimizing your ETL pipeline by replacing a multi-step "Update then Delete" process with a single, atomic command. You will use a MERGE statement to synchronize the job_skill_priorities table, ensuring it automatically handles new records, updates existing ones, and removes entries that no longer exist in your source data.

USE company_jobs;

DELETE FROM staging.priority_skills
WHERE skill_id = 1;

SELECT * FROM staging.priority_skills;

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

WHEN NOT MATCHED THEN 
INSERT (job_id, skill_id, skill_name, priority_lvl, status)
VALUES 
(src.job_id,src.skill_id,src.skill_name,src.priority_lvl, 'NEW SKILL')

WHEN NOT MATCHED BY SOURCE THEN
DELETE;

SELECT * FROM job_skill_priorities WHERE skill_id = 1;

/*
Database Connection: We use duckdb md:company_jobs to access the database where our fact and dimension tables are stored.
Simulating Source Changes: By deleting the 'python' skill from staging.priority_skills, we create a scenario where the target table is now "out of sync" with our desired source state.
The Source Subquery: Instead of merging with a single table, we use a subquery that joins skills_job_dim with our staging data. This creates a source dataset containing only the skills we currently want to prioritize.
The Composite Key: The ON clause uses both job_id and skill_id. This is essential because a single job can have multiple skills; we need both IDs to uniquely identify which specific record to update or delete.
Automated Purging:
WHEN MATCHED and WHEN NOT MATCHED handle standard synchronization (updates and inserts).
WHEN NOT MATCHED BY SOURCE is the cleanup mechanism. It identifies any row in job_skill_priorities that doesn't exist in our source subquery and removes it, ensuring the table stays "clean" without a separate DELETE script.
*/