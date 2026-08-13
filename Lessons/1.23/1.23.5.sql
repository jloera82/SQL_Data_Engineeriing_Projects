-- Jobs in Above Average Countries

SELECT jpf.job_id,jpf.job_title_short,jpf.job_location
FROM job_postings_fact AS jpf
WHERE jpf.job_country IN (
    SELECT job_country
    FROM job_postings_fact
    GROUP BY job_country
    HAVING COUNT(job_id) > (
        SELECT AVG(country_count)
        FROM (
            SELECT COUNT(job_id) AS country_count
            FROM job_postings_fact
            GROUP BY job_country
        ) AS country_counts
    )
)
ORDER BY jpf.job_country,jpf.job_id;
