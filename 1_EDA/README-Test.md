# HEADING 1
## HEADING 2
### HEADING 3

Normal Text
**Bold Text**
*Italics Text*

`This is code`

- Bullet 1
- BUllet 2

1. number 1
2. number 2

[LINK TEXT](http:www.google.com)

![Alt Text](https://github.com/lukebarousse/SQL_Data_Engineering_Course/raw/main/Resources/images/1_1_Project1_EDA.png)

### Relatuve path iamge URL path test
![Alt Text](../images/1_1_Project1_EDA.png)

```sql
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
```