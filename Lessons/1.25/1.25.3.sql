-- WFH DE Job Categorization (1.26.3) - Problem
-- 1.26 CASE Expression
-- Problem Statement
-- Analyze remote job volume for "Data Engineer" roles in the data_jobs database by returning a list of companies categorized into tiers based on their total number of Work From Home (WFH) job postings.

USE data_jobs;

SELECT
    cd.name AS company_Name,
    COUNT(jpf.job_id) AS job_count,
    CASE
        WHEN COUNT(jpf.job_id) > 100 THEN '100+ WFH DE Jobs'
        WHEN COUNT(jpf.job_id) >= 50 THEN '50-100 WFH DE Jobs'
        WHEN COUNT(jpf.job_id) >= 25 THEN '25-49 WFH DE Jobs'
        ELSE 'Less than 25 WFH DE Jobs'
    END AS WFH_DE_Job_Category
FROM job_postings_fact AS jpf
INNER JOIN company_dim AS cd
ON jpf.company_id = cd.company_id
WHERE jpf.job_work_from_home = TRUE AND jpf.job_title_short = 'Data Engineer'
GROUP BY cd.name
ORDER BY job_count DESC;

/*
Connect to data_jobs: duckdb md:data_jobs opens a DuckDB session pointing at the shared data_jobs database so all queries run against that dataset.
Filtering for Relevant Jobs: The WHERE clause performs two specific filters:

jpf.job_work_from_home = TRUE: This ensures that only remote (WFH) job postings are included in the aggregation.
jpf.job_title_short = 'Data Engineer': This restricts the analysis to only the "Data Engineer" job title.
An INNER JOIN is used to combine the filtered job postings with the company_dim table to retrieve the company_name for grouping.

Grouping and Counting: The query uses COUNT(jpf.job_id) AS job_count to tally the total number of qualifying jobs (remote Data Engineer postings) for each unique company_name specified in the GROUP BY clause.
Categorizing Aggregated Results: The CASE expression in this query is evaluated after the GROUP BY and COUNT steps are complete. It uses the aggregated column job_count to define the category, effectively categorizing each company based on its remote job volume:

WHEN COUNT(jpf.job_id) > 100: Companies are placed in the highest tier.
WHEN COUNT(jpf.job_id) >= 50: Companies are placed in the next tier, as they have already failed the previous condition.
The remaining conditions and the ELSE clause categorize companies into progressively smaller volume tiers.
This technique is critical when you need to categorize data based on an aggregated summary value.

Ordering: The final result set is ordered by job_count DESC (descending) to show the companies with the most remote Data Engineer job postings first.
*/