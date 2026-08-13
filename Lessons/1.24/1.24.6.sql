-- Synchronizing Source Deletions via Merge (1.24.6) - Problem
-- 1.24 DDL & DML - Pt. 3
-- Problem Statement
-- Maintain the integrity of the job skills priority list by ensuring that deletions in the staging environment are reflected in your production data. You need to simulate a record removal and then perform a synchronization that updates the job_skill_priorities table, marking missing source records as inactive rather than deleting them permanently.

USE company_jobs;

DELETE FROM staging.priority_skills WHERE skill_id = 183;

MERGE INTO main.job_skill_priorities AS tgt
USING staging.priority_skills AS src
ON tgt.skill_id = src.skill_id
WHEN NOT MATCHED BY SOURCE THEN
UPDATE SET status = 'INACTIVE';

SELECT * FROM staging.priority_skills;

SELECT * FROM job_skill_priorities
ORDER BY job_id;

-- Connect to company_jobs: duckdb md:company_jobs opens a DuckDB session pointing at the shared company_jobs database so all queries run against that dataset.
-- Targeted Deletion in Staging:
-- The DELETE statement removes the record with skill_id = 183 from the staging.priority_skills table. In a data engineering pipeline, this simulates a scenario where a record is removed from the upstream source, making the staging table the Source of Truth for the subsequent synchronization step.

-- MERGE Architecture:
-- The MERGE statement uses main.job_skill_priorities as the tgt (target) and staging.priority_skills as the src (source). By joining these on the skill_id, the engine can determine which records exist in both, which are new, and which have been removed from the source.

-- Soft Delete via NOT MATCHED BY SOURCE:
-- The WHEN NOT MATCHED BY SOURCE clause specifically handles records that exist in the target table but are missing from the staging table (like the skill we deleted in step 1). Rather than performing a physical DELETE on the production table, we UPDATE the status to 'INACTIVE'. This Soft Delete pattern is a best practice in data warehousing to preserve historical data and maintain referential integrity.