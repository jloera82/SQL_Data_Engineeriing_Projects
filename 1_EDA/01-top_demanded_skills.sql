/*
Question: What are the most in-demand skills for data engineers?
- Identify the top 10 in-demand skills for data engineers
- Focus on remote job postings in the United States
- Why? Retrieves the top 10 skills with the highest demand in the remote job market, providing insights into the most valuable skills for data engineers seeking remote work in the United States
*/


SELECT
sd.skills,
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
ORDER BY demand_count DESC
LIMIT 10;


/*

Here's the breakdown of the most demanded skills for data engineers:
SQL and Python are by far the most in-demand skills, with around 8,000+ job postings each - nearly double the next closest skill.
Cloud platforms round out the top skills, with AWS leading at 5,000+ postings, followed by Azure at 4,000+.
Apache Spark completes the top 5 with nearly 3,000+ postings, highlighting the importance of big data processing skills.

Key takeaways:
- SQL and Python remain the foundational skills for data engineers
- Cloud platforms (AWS, Azure) are critical for modern data engineering
- Big data tools like Spark continue to be highly valued
- Data pipeline tools (Airflow, Snowflake, Databricks) show growing demand
- Java and kafka round out the top 10 most requested skills in the United States

┌────────────┬──────────────┐
│   skills   │ demand_count │
│  varchar   │    int64     │
├────────────┼──────────────┤
│ sql        │         8665 │
│ python     │         8118 │
│ aws        │         5269 │
│ azure      │         4419 │
│ spark      │         3766 │
│ snowflake  │         2974 │
│ databricks │         2650 │
│ java       │         2507 │
│ airflow    │         2110 │
│ kafka      │         2018 │
└────────────┴──────────────┘
  10 rows         2 columns

*/