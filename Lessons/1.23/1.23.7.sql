-- identifying companues w. active postings

SELECT cd.name
FROM company_dim AS cd
WHERE EXISTS (
    SELECT 1
    FROM job_postings_fact AS jpf
    WHERE jpf.company_id = cd.company_id
);