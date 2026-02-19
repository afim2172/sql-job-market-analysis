-- 3_load_data.sql

-- Enable COPY for Postgres (requires superuser or appropriate permissions if using absolute paths, 
-- or use \copy in psql for client-side copy)

-- Method 1: Server-side COPY (Faster, but requires file access on server)
\copy company_dim FROM 'F:/Data engineer Project 1/sql_project/data/company_dim.csv' WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8')
\copy skills_dim FROM 'F:/Data engineer Project 1/sql_project/data/skills_dim.csv' WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8')
\copy job_postings_fact FROM 'F:/Data engineer Project 1/sql_project/data/job_postings_fact.csv' WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8')
\copy skills_job_dim FROM 'F:/Data engineer Project 1/sql_project/data/skills_job_dim.csv' WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8')


