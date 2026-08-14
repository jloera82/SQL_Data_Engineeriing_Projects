SELECT job_id, COUNT() FROM job_postings_fact GROUP BY job_id HAVING COUNT() > 1;
