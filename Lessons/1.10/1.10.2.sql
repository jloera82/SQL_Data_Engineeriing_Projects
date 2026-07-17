-- duckdb md:data_jobs

SELECT table_name, constraint_name, COUNT(constraint_name) AS constraint_name_count 
FROM information_schema.key_column_usage
WHERE table_catalog = 'data_jobs'
GROUP BY table_name, constraint_name
HAVING COUNT(constraint_name) > 1;

/* -- Explanation
Connect to data_jobs: duckdb md:data_jobs opens a DuckDB session pointing at the shared data_jobs database so all queries run against that dataset.
Querying Constraint Usage: The query targets information_schema.key_column_usage. Unlike table_constraints (which just lists the rule itself), this view lists every column that a constraint applies to. If a single Primary Key spans two columns, it will appear as two rows in this table.

Grouping by Constraint: The GROUP BY table_name, constraint_name clause aggregates the data so that we can calculate statistics for each specific constraint, rather than for each individual column.
Identifying Composite Keys: The core logic lies in the HAVING count(constraint_name) > 1 clause.

A standard Primary Key or Foreign Key usually applies to a single column (Count = 1).
A Composite Key spans multiple columns. By filtering for counts greater than 1, we isolate only those constraints that enforce uniqueness or referential integrity across a combination of columns.
*/