-- Custom Quarter Labels via Text (1.27.6) - Problem
-- 1.27 Date Functions
-- Problem Statement
-- Create a custom quarter label by analyzing the text representation of a date. You will combine date truncation with a conditional CASE expression and data type conversion to manually assign a quarter number (1, 2, 3, or 4) based on the month found in the timestamp string.

SELECT
  DATE_TRUNC('quarter', job_posted_date) AS job_quarter,
  CASE
    WHEN DATE_TRUNC('quarter', job_posted_date)::VARCHAR LIKE '%-01-%' THEN '1'
    WHEN DATE_TRUNC('quarter', job_posted_date)::VARCHAR LIKE '%-04-%' THEN '2'
    WHEN DATE_TRUNC('quarter', job_posted_date)::VARCHAR LIKE '%-07-%' THEN '3'
    ELSE '4'
  END AS formatted_quarter,
  COUNT(job_id) AS job_count
FROM job_postings_fact
WHERE
  DATE_TRUNC('year', job_posted_date) BETWEEN '2023-01-01' AND '2024-12-31'
GROUP BY job_quarter,formatted_quarter
ORDER BY job_quarter;