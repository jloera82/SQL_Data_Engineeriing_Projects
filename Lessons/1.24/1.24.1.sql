-- Defining Skill Priority Lookup Table (1.24.1) - Problem
-- 1.24 DDL & DML - Pt. 3
-- Problem Statement
-- You will create a lookup table that assigns a priority level to essential technical skills like Python, SQL, and Power BI. By joining this reference table to other tables (as we'll do later), you can instantly filter and rank based on whether they possess these specific qualifications.

USE company_jobs;

CREATE SCHEMA IF NOT EXISTS company_jobs.staging;

CREATE OR REPLACE TABLE staging.priority_skills (
    skill_id        INTEGER PRIMARY KEY, 
    skill_name      VARCHAR,
    priority_lvl    INTEGER
);

INSERT INTO staging.priority_skills (skill_id,skill_name,priority_lvl)
VALUES 
(1,'python',1),
(0,'sql',1),
(183,'tableau',2);

SELECT * FROM information_schema.schemata;

SELECT * FROM staging.priority_skills;