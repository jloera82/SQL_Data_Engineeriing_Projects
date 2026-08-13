-- Synchronizing Skill Priority Updates (1.24.5) - Problem
-- 1.24 DDL & DML - Pt. 3
-- Problem : Maintaining data integrity and synchronization between staging and production tables is a critical skill for data engineers. In this exercise, you need to update priority rankings for specific technical skills in a staging environment and then synchronize those changes into the main production table while tracking the update status.

USE company_jobs;

UPDATE staging.priority_skills
SET priority_lvl = 1
WHERE skill_id = 0;

UPDATE staging.priority_skills
SET priority_lvl = 2
WHERE skill_id = 1;

MERGE INTO main.job_skill_priorities AS tgt
USING staging.priority_skills AS src
ON tgt.skill_id = src.skill_id
WHEN MATCHED AND (tgt.priority_lvl <> src.priority_lvl OR tgt.priority_lvl IS NULL) THEN
    UPDATE SET
        priority_lvl = src.priority_lvl,
        status = 'PRIORITY_CHANGE';

SELECT * FROM staging.priority_skills;

SELECT * FROM job_skill_priorities;


-- Connect to company_jobs: duckdb md:company_jobs opens a DuckDB session pointing at the shared company_jobs database so all queries run against that dataset.
-- Staging Data Preparation:
-- Before performing the synchronization, we update the source data within the staging.priority_skills table to reflect the correct priority levels for specific skills.

-- The UPDATE statements modify skill_id 0 (SQL) and skill_id 1 (Python) to set their respective priority_lvl values.
-- The MERGE Operation:
-- The MERGE statement is used to synchronize the main.job_skill_priorities target table with the staging.priority_skills source table.

-- Join Condition: The ON tgt.skill_id = src.skill_id clause matches records between the target and source based on the unique skill identifier.
-- Change Detection: The WHEN MATCHED clause is paired with a filter: tgt.priority_lvl <> src.priority_lvl OR tgt.priority_lvl IS NULL. This logic ensures that an update is only performed if the data has actually changed or if the target value is currently empty, avoiding unnecessary writes to the database.
-- Update and Audit: When the conditions are met, the priority_lvl is updated from the source, and the status column is set to 'PRIORITY_CHANGE', allowing data engineers to easily track which records were modified during this process.