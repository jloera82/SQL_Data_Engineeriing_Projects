-- Data Engineer Salary Bucketing (1.26.1) - Problem
-- 1.26 CASE Expression
-- Problem Statement
-- For all "Data Engineer" job postings in the data_jobs database with salary information, return certain job details, and a new, derived column that categorizes the yearly salary into three defined tiers.

USE data_jobs;

SELECT 
jpf.job_id,
jpf.job_title,
cd.name AS company_name,
jpf.salary_year_avg,
CASE
    WHEN jpf.salary_year_avg >= 100000 THEN 'High Salary'
    WHEN jpf.salary_year_avg >= 60000 THEN 'Standard Salary'
    WHEN jpf.salary_year_avg < 60000 THEN 'Low Salary'
END AS salary_category
FROM job_postings_fact AS jpf
INNER JOIN company_dim AS cd
ON jpf.company_id = cd.company_id
WHERE jpf.salary_year_avg IS NOT NULL
AND jpf.job_title_short = 'Data Engineer'
ORDER BY jpf.salary_year_avg DESC;

/*
Connect to data_jobs: duckdb md:data_jobs opens a DuckDB session pointing at the shared data_jobs database so all queries run against that dataset.
Creating a Salary Category: The CASE expression is the central component of this query. It allows you to perform conditional logic—similar to an "if-then-else" structure in programming—to evaluate a list of conditions and return a corresponding result. The output of the CASE expression is named salary_category. [Image of CASE expression logic diagram] The conditions are evaluated sequentially:

WHEN jpf.salary_year_avg >= 100000 THEN 'High salary': Assigns "High salary" to any job with an average salary of $100,000 or more.
WHEN jpf.salary_year_avg >= 60000 THEN 'Standard salary': Assigns "Standard salary" to any remaining job with an average salary of $60,000 or more (since the first condition already handled those over $100,000).
WHEN jpf.salary_year_avg < 60000 THEN 'Low salary': Assigns "Low salary" to any job remaining that falls below $60,000.
Joining and Filtering: An INNER JOIN is used to combine job_postings_fact (jpf) with company_dim (cd) on the shared column company_id. This ensures that only job postings with a matching company name are included in the results.
WHERE Clause Conditions: The WHERE clause applies two filters to the data:
jpf.salary_year_avg IS NOT NULL: This ensures that only job postings with recorded salary data are processed and categorized by the CASE expression.
jpf.job_title_short = 'Data Engineer': This restricts the output to only display Data Engineer roles.
Ordering: The final result set is ordered by jpf.salary_year_avg DESC (descending) to easily review the salary categories from highest to lowest.
*/