-- 6_optimizations.sql
-- Phase 4: Performance Optimization

/*
----------------------------------------------------------------------
STEP 1: Analyze Current Performance
- We use EXPLAIN ANALYZE to see how the database executes the query.
- Look for "Seq Scan" (Sequential Scan) which means it reads every row.
----------------------------------------------------------------------
*/

-- Analyze Query 1 (Filter by job_title_short and salary)
EXPLAIN ANALYZE
SELECT 
    job_id,
    job_title,
    salary_year_avg
FROM 
    job_postings_fact
WHERE
    job_title_short = 'Data Engineer'
    AND salary_year_avg > 100000;

/*
----------------------------------------------------------------------
STEP 2: Create Indexes
- Indexes act like a book's index, allowing the DB to find rows faster.
- We index columns used frequently in WHERE clauses and JOINs.
----------------------------------------------------------------------
*/

-- Index on job_title_short (used often for filtering)
CREATE INDEX idx_job_title_short ON job_postings_fact(job_title_short);

-- Index on salary_year_avg (used for filtering high salaries)
CREATE INDEX idx_salary_year_avg ON job_postings_fact(salary_year_avg);

-- Composite Index (for queries using both often)
CREATE INDEX idx_title_salary ON job_postings_fact(job_title_short, salary_year_avg);

/*
----------------------------------------------------------------------
STEP 3: Verify Improvement
- Run EXPLAIN ANALYZE again.
- You should see "Index Scan" or "Bitmap Heap Scan" instead of "Seq Scan".
- Execution time should decrease (though with small datasets, it might be negligible).
----------------------------------------------------------------------
*/

EXPLAIN ANALYZE
SELECT 
    job_id,
    job_title,
    salary_year_avg
FROM 
    job_postings_fact
WHERE
    job_title_short = 'Data Engineer'
    AND salary_year_avg > 100000;
