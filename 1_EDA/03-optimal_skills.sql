/*
Question: What are the most optimal skills for data engineers—balancing both demand and salary?
- Create a ranking column that combines demand count and median salary to identify the most valuable skills.
- Focus only on remote Data Engineer positions with specified annual salaries.
- Why?
    - This approach highlights skills that balance market demand and financial reward. It weights core skills appropriately instead of letting rare, outlier skills distort the results.
    - The natural log transformation ensures that both high-salary and widely in-demand skills surface as the most practical and valuable to learn for data engineering careers.
*/

SELECT
sd.skills,
ROUND(MEDIAN(jpf.salary_year_avg), 0) AS median_salary,
COUNT(jpf.*) AS demand_count,
ROUND(LN(COUNT(jpf.*)), 1) AS ln_demand_count,
ROUND((MEDIAN(jpf.salary_year_avg) * LN(COUNT(jpf.*))/1000000),2) AS optimal_score
FROM job_postings_fact jpf
INNER JOIN skills_job_dim sjd
    ON jpf.job_id = sjd.job_id
INNER JOIN skills_dim sd
    ON sjd.skill_id = sd.skill_id
WHERE jpf.job_title_short = 'Data Engineer'
AND jpf.job_country = 'United States'
AND jpf.job_work_from_home = TRUE
AND jpf.salary_year_avg IS NOT NULL
GROUP BY sd.skills
HAVING COUNT(jpf.*) > 100
ORDER BY median_salary DESC
LIMIT 25;


/*
Here's a breakdown of the most optimal skills for Data Engineers, based on both high demand and high salaries in the United States:

Top Skills by Optimal Score:
- Terraform leads the list with a $192K median salary and 146 postings, resulting in the highest overall "optimal score".
- Python and SQL dominate demand (over 850 postings each), with strong median salaries of $135K and $130K, respectively.
- AWS (583 postings, $140K median), Spark (369 postings, $140K median), and Airflow (298 postings, $154K median) are all highly sought-after cloud and big data technologies.
- Kafka offers high compensation ($140K median) and solid demand (189 postings).
- Tools like Snowflake, Azure, and Databricks each have 200–358 postings and median salaries between $130–$139.5K.

DevOps & Engineering Tools:
- Airflow ($154K), and Kubernetes ($155K) stand out for their mix of demand and top median salaries.
- Git ($150.5K/176 postings) have broad utility and competitive compensation.

Noteworthy Languages:
- Java (214 postings, $130K median) and Scala (185 postings, $137.5K median) remain strong choices for well-paid data engineering roles.
- R ($135K/116 postings) is another programming language with excellent compensation.

Databases & Cloud:
- Redshift ($130K/198 postings), GCP ($136K/119 postings), Hadoop ($135K/144 postings), and NoSQL ($135.5K/138 postings) add to a well-rounded data engineering skill set.
- R, Pyspark, and BigQuery each deliver competitive salaries and meet the threshold for demand.

Summary:
Skills that consistently appear near the top balance a strong combination of market demand (job security) and financial benefit. Python, SQL, AWS, Spark, Airflow, and Terraform are particularly strategic for both immediate opportunities and longer-term career growth in data engineering.

┌────────────┬───────────────┬──────────────┬─────────────────┬───────────────┐
│   skills   │ median_salary │ demand_count │ ln_demand_count │ optimal_score │
│  varchar   │    double     │    int64     │     double      │    double     │
├────────────┼───────────────┼──────────────┼─────────────────┼───────────────┤
│ terraform  │      192750.0 │          146 │             5.0 │          0.96 │
│ kubernetes │      155000.0 │          101 │             4.6 │          0.72 │
│ airflow    │      154000.0 │          298 │             5.7 │          0.88 │
│ git        │      150500.0 │          176 │             5.2 │          0.78 │
│ aws        │      140000.0 │          583 │             6.4 │          0.89 │
│ kafka      │      140000.0 │          189 │             5.2 │          0.73 │
│ pyspark    │      140000.0 │          120 │             4.8 │          0.67 │
│ spark      │      140000.0 │          369 │             5.9 │          0.83 │
│ snowflake  │      139500.0 │          352 │             5.9 │          0.82 │
│ scala      │      137500.0 │          185 │             5.2 │          0.72 │
│ gcp        │      136000.0 │          119 │             4.8 │          0.65 │
│ nosql      │      135500.0 │          138 │             4.9 │          0.67 │
│ python     │      135500.0 │          853 │             6.7 │          0.91 │
│ databricks │      135500.0 │          202 │             5.3 │          0.72 │
│ r          │      135290.0 │          116 │             4.8 │          0.64 │
│ hadoop     │      135000.0 │          144 │             5.0 │          0.67 │
│ azure      │      130000.0 │          358 │             5.9 │          0.76 │
│ java       │      130000.0 │          214 │             5.4 │           0.7 │
│ sql        │      130000.0 │          850 │             6.7 │          0.88 │
│ redshift   │      130000.0 │          198 │             5.3 │          0.69 │
│ power bi   │      120070.0 │          111 │             4.7 │          0.57 │
│ sql server │      120000.0 │          116 │             4.8 │          0.57 │
│ tableau    │      115000.0 │          133 │             4.9 │          0.56 │
└────────────┴───────────────┴──────────────┴─────────────────┴───────────────┘
  23 rows                                                           5 columns

*/