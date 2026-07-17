
-- LEFT JOIN : returns all records from the left table (Table A), and the matching rows from the right table (Table B). 
SELECT jpf.job_id, jpf.job_title_short, cd.company_id, cd.name AS company_name, jpf.job_location
FROM job_postings_fact AS jpf
LEFT JOIN company_dim AS cd
    ON jpf.company_id = cd.company_id
LIMIT 10;


-- RIGHT JOIN : Returns all records from the right table (Table B) and the matching records from the left table (Table A)
SELECT jpf.job_id, jpf.job_title_short, cd.company_id, cd.name AS company_name, jpf.job_location
FROM job_postings_fact AS jpf
RIGHT JOIN company_dim AS cd
    ON jpf.company_id = cd.company_id
LIMIT 10;

-- INNER JOIN : returns rows when there’s a match in both tables being joined.
SELECT jpf.job_id, jpf.job_title_short, cd.company_id, cd.name AS company_name, jpf.job_location
FROM job_postings_fact AS jpf
INNER JOIN company_dim AS cd
    ON jpf.company_id = cd.company_id;


-- OUTER JOIN :  returns all records when there’s a match in the left table (Table A) or right table (Table B) table records. 

SELECT jpf.job_id, jpf.job_title_short, cd.company_id, cd.name AS company_name, jpf.job_location
FROM job_postings_fact AS jpf
FULL OUTER JOIN company_dim AS cd
    ON jpf.company_id = cd.company_id
LIMIT 20;


-- skills

SELECT * FROM skills_job_dim
LIMIT 10;

SELECT * FROM skills_dim
LIMIT 10;

SELECT 
    jpf.job_id,
    jpf.job_title_short,
    sjd.skill_id,
    sd.skills
FROM job_postings_fact AS jpf
LEFT JOIN skills_job_dim AS sjd 
    ON jpf.job_id = sjd.job_id
LEFT JOIN skills_dim AS sd
    ON sjd.skill_id = sd.skill_id
LIMIT 10;