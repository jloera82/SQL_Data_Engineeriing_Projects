-- Delete Staging Discrepancies (1.24.7) - Problem
-- 1.24 DDL & DML - Pt. 3
-- Problem Statement
-- After marking skills as INACTIVE in previous steps, you've been tasked to perform a physical cleanup of the database. To maintain a lean and accurate system, you must perform a hard delete of any records in the job_skill_priorities production table that no longer have a corresponding entry in the staging.priority_skills table. This ensures the environment only contains currently valid priority skills.

USE company_jobs;

DELETE FROM job_skill_priorities AS tgt
WHERE NOT EXISTS (
    SELECT 1
    FROM staging.priority_skills AS src
    WHERE src.skill_id = tgt.skill_id
);

SELECT * FROM job_skill_priorities WHERE skill_id = 183;

/*
The NOT EXISTS Subquery:
This is a powerful logical filter used for "anti-joins." The subquery looks for a match between the tgt (target) and src (source) tables based on skill_id. If the subquery finds no match, NOT EXISTS evaluates to true, and the row is deleted from the target table.

Aliasing for Clarity:
Using AS tgt and AS src makes the query more readable and prevents column name ambiguity. It clearly distinguishes between the table being modified and the table being used as a reference point.

Validation Step:
In a production environment, it is best practice to verify a DELETE operation by querying for a known deleted ID (like 183). If the query returns zero rows, the cleanup was successful.

Data Integrity:
Unlike a soft delete (where you simply change a status flag), this Hard Delete physically removes the data to ensure the job_skill_priorities table remains a lean, 1:1 reflection of current business priorities.
*/