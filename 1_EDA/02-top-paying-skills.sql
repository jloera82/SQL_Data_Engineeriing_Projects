/* 
**Question: What are the highest-paying skills for data engineers?** 

- Calculate the median salary for each skill required in data engineer positions
- Focus on remote positions with specified salaries
- Include skill frequency to identify both salary and demand
- Why?
    - Helps identify which skills command the highest compensation while also showing how common those skills are, providing a more complete picture for skill development priorities.
    - The median is used instead of the average to reduce the impact of outlier salaries.
*/

SELECT
sd.skills,
ROUND(MEDIAN(jpf.salary_year_avg), 0) AS median_salary,
COUNT(jpf.*) AS demand_count
FROM job_postings_fact jpf
INNER JOIN skills_job_dim sjd
    ON jpf.job_id = sjd.job_id
INNER JOIN skills_dim sd
    ON sjd.skill_id = sd.skill_id
WHERE jpf.job_title_short = 'Data Engineer'
AND jpf.job_country = 'United States'
AND jpf.job_work_from_home = TRUE
GROUP BY sd.skills
HAVING COUNT(jpf.*) > 100
ORDER BY median_salary DESC
LIMIT 25;


/*
Here's a breakdown of the highest-paying skills for Data Engineers in United States:

Key Insights:
- Terraform remains the top-paying skill at $192K median salary.
- Jupyter and Golang both have high median salaries at $156K.
- Other notable skills with both high pay and moderate-to-high frequency include:
  - Spring: $175.5K median salary (172 postings)
  - Mongo: $155.5K median salary (111 postings)
  - Typescript: $155K median salary (112 postings)
  - Ruby: $155K median salary (206 postings)
  - Bitbucket: $155K median salary (129 postings)
  - Kubernetes: $150K median salary (960 postings)
- Bitbucket, Ruby, Redis, Ansible, and Jupyter all appear in the top 25 for pay, each with hundreds of postings.

Takeaway: While the very top-paying skill (Terraform) still has less demand than major cloud and data tools, most of the top-paying skills have both solid salaries and significant demand. This suggests that learning tools like Terraform, Golang, Spring, and especially core data engineering tools (Airflow, Kubernetes) provides a strong balance between compensation and marketability.

┌────────────┬───────────────┬──────────────┐
│   skills   │ median_salary │ demand_count │
│  varchar   │    double     │    int64     │
├────────────┼───────────────┼──────────────┤
│ terraform  │      192750.0 │          965 │
│ spring     │      175500.0 │          172 │
│ jupyter    │      156250.0 │          129 │
│ golang     │      156000.0 │          140 │
│ mongo      │      155527.0 │          111 │
│ typescript │      155000.0 │          112 │
│ ruby       │      155000.0 │          206 │
│ bitbucket  │      155000.0 │          129 │
│ kubernetes │      155000.0 │          960 │
│ graphql    │      155000.0 │          109 │
│ gdpr       │      155000.0 │          120 │
│ c          │      154000.0 │          159 │
│ airflow    │      154000.0 │         2110 │
│ ansible    │      153000.0 │          122 │
│ git        │      150500.0 │         1411 │
│ redis      │      150000.0 │          124 │
│ perl       │      148750.0 │          104 │
│ react      │      145750.0 │          138 │
│ looker     │      145000.0 │          426 │
│ dynamodb   │      141250.0 │          368 │
│ kafka      │      140000.0 │         2018 │
│ pandas     │      140000.0 │          422 │
│ docker     │      140000.0 │          868 │
│ word       │      140000.0 │          280 │
│ aws        │      140000.0 │         5269 │
└────────────┴───────────────┴──────────────┘
  25 rows                         3 columns

*/