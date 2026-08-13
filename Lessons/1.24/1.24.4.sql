-- Syncing Skill Priorities from Staging (1.24.4) - Problem
-- 1.24 DDL & DML - Pt. 3
-- Problem : When you initially populated the job_skill_priorities table, the skill_name and priority_lvl columns were left blank (NULL). You've been tasked to fill in these missing values by pulling them directly from your priority_skills staging table. A MERGE statement is the perfect tool to match the records and update the empty columns in one step.


USE company_jobs;

MERGE INTO job_skill_priorities AS tgt
USING staging.priority_skills AS src
ON tgt.skill_id = src.skill_id

WHEN MATCHED THEN
    UPDATE SET
        skill_name = src.skill_name,
        priority_lvl = src.priority_lvl;

SELECT * FROM job_skill_priorities;

-- Connect to company_jobs: duckdb md:company_jobs opens a DuckDB session pointing at the shared company_jobs database so all queries run against that dataset.
-- The MERGE statement: This statement allows you to perform conditional updates or inserts by comparing a target table (job_skill_priorities) with a source table (staging.priority_skills).
-- Using AS tgt and AS src provides shorthand aliases that make the query more readable when referencing columns from both tables.

-- The ON condition: The ON tgt.skill_id = src.skill_id clause defines the relationship between the tables. It tells the database to look for matching skill_id values to determine which rows in the target table need to be updated.
-- The WHEN MATCHED clause: This logic handles existing records.
-- If a skill_id from the source is already present in the target, the WHEN MATCHED condition evaluates to TRUE.
-- The UPDATE SET command then modifies the existing skill_name and priority_lvl in the target table to match the values provided by the staging table.