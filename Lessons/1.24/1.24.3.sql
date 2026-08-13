-- Updating Skill Status to Urgent (1.24.3) - Problem
-- 1.24 DDL & DML - Pt. 3
-- Problem : In the previous exercise, you populated the job_skill_priorities tracking table and set the initial status to 'ACTIVE'. You've been tasked to escalate these specific skills for an immediate hiring push. You must update the existing active records in your table to reflect this new, highly critical status.

USE company_jobs;

UPDATE job_skill_priorities
SET status = 'URGENT'
WHERE status = 'ACTIVE';

SELECT * FROM job_skill_priorities;