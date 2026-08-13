-- Extracting Job Date Parts (1.27.3) - Problem
-- 1.27 Date Functions
-- Problem Statement
-- Analyze job posting trends by breaking down the posting date into its individual components. You will use the EXTRACT function to isolate the year, month, day, and quarter from the timestamp, allowing for more granular time-based analysis.

SELECT
job_id,
job_title_short,
job_location,
job_posted_date,
EXTRACT(YEAR FROM job_posted_date) AS job_Posted_year,
EXTRACT(MONTH FROM job_posted_date) AS job_posted_month,
EXTRACT(DAY FROM job_posted_date) AS job_Posted_day,
EXTRACT(QUARTER FROM job_posted_date) AS job_Posted_quarter
FROM job_postings_fact
WHERE job_posted_date::DATE BETWEEN '2023-01-01' AND '2024-12-31';