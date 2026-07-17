SELECT job_id,job_title_short,salary_year_avg,company_id
FROM job_postings_fact
LIMIT 10;

SELECT company_id, name AS company_name
FROM company_dim
LIMIT 10;


select * from information_schema.tables
where table_catalog = 'data_jobs';
