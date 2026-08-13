-- Quarterly Job Posting Trends (1.27.4) - Problem
-- 1.27 Date Functions
-- Problem Statement
-- Analyze the volume of job postings on a quarterly basis. You will explicitly use the EXTRACT function to isolate the year and quarter from the date, and then combine them to create a custom time period label for your report.

SELECT
  EXTRACT(QUARTER FROM job_posted_date) AS job_posted_quarter,
  EXTRACT(YEAR FROM job_posted_date) AS job_posted_year,
  EXTRACT(YEAR FROM job_posted_date) || '-' || EXTRACT(QUARTER FROM job_posted_date) AS job_posted_year_quarter,
  COUNT(job_id) AS job_posts
FROM job_postings_fact
WHERE
  EXTRACT(YEAR FROM job_posted_date) BETWEEN 2023 AND 2024
GROUP BY
  job_posted_quarter,
  job_posted_year,
  job_posted_year_quarter
ORDER BY
  job_posted_year_quarter ASC;