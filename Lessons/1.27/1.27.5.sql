-- Truncating Job Dates to Quarters (1.27.5) - Problem
-- 1.27 Date Functions
-- Problem Statement
-- -- Aggregate job postings by quarter using date truncation. Unlike extraction, which separates date parts, truncation rounds a timestamp down to a specific precision (like the first day of a quarter), preserving the year and date format automatically.

SELECT
  DATE_TRUNC('quarter', job_posted_date) AS job_quarter,
  COUNT(job_id) AS job_count
FROM job_postings_fact
WHERE
  DATE_TRUNC('year', job_posted_date) BETWEEN '2023-01-01' AND '2024-12-31'
GROUP BY job_quarter
ORDER BY job_quarter;