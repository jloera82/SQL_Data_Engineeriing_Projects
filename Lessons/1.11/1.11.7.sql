SELECT
cd.name AS company_name,
COUNT(jpf.job_id) AS posting_count
FROM job_postings_fact AS jpf
LEFt JOIN company_dim AS cd
    ON jpf.company_id = cd.company_id
WHERE jpf.job_country = 'United States'
GROUP BY cd.name
HAVING COUNT(jpf.job_id) > 300000
ORDER BY jpf.job_id DESC
LIMIT 10

SELECT 
job_title_short,
AVG(salary_year_avg)
FROM job_postings_fact
WHERE avg(salary_year_avg) > 100000
GROUP BY job_title_short;

SELECT job_title_short
FROM job_postings_fact
HAVING salary_year_avg > 100000;