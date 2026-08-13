-- Timezone Abbreviation Count (1.27.1) - Problem
-- 1.27 Date Functions
-- Problem Statement
-- Explore the built-in timezone data in DuckDB. You will first view the raw timezone names and abbreviations, and then aggregate the data to count how many specific locations share the same timezone abbreviation.

USE data_jobs;

SELECT * FROM pg_timezone_names();

SELECT abbrev,COUNT(name) AS record_count
FROM pg_timezone_names()
GROUP BY abbrev
ORDER BY record_count DESC;