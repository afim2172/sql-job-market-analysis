-- 4_verify_data.sql
-- Run this to verify that data was loaded correctly

SELECT 'company_dim' as table_name, COUNT(*) as record_count FROM company_dim
UNION ALL
SELECT 'skills_dim', COUNT(*) FROM skills_dim
UNION ALL
SELECT 'job_postings_fact', COUNT(*) FROM job_postings_fact
UNION ALL
SELECT 'skills_job_dim', COUNT(*) FROM skills_job_dim;

-- Preview a few records to ensure columns aren't shifted
SELECT * FROM job_postings_fact LIMIT 5;
