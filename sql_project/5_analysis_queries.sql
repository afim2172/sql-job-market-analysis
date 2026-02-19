-- 5_analysis_queries.sql
-- Phase 3: SQL Analysis - Answering Business Questions

/*
----------------------------------------------------------------------
QUESTION 1: Top Paying Jobs for Data Engineers
- Identify the top 10 highest-paying Data Engineer roles that are available remotely.
- Why? To spot outliers to target.
----------------------------------------------------------------------
*/
SELECT 
    job_id,
    job_title,
    job_location,
    job_schedule_type,
    salary_year_avg,
    job_posted_date,
    name as company_name
FROM 
    job_postings_fact
LEFT JOIN company_dim ON job_postings_fact.company_id = company_dim.company_id
WHERE
    job_title_short = 'Data Engineer'
    AND salary_year_avg IS NOT NULL
    AND job_work_from_home = TRUE
ORDER BY
    salary_year_avg DESC
LIMIT 10;

/*
----------------------------------------------------------------------
QUESTION 2: Top Skills for Data Engineers
- What skills are required for the top-paying Data Engineer jobs?
- Use the first query as a CTE (Common Table Expression) to find the skills associated with them.
- Why? Provides a detailed look at which high-paying jobs demand specific skills.
----------------------------------------------------------------------
*/
WITH top_paying_jobs AS (
    SELECT 
        job_id,
        job_title,
        salary_year_avg,
        name as company_name
    FROM 
        job_postings_fact
    LEFT JOIN company_dim ON job_postings_fact.company_id = company_dim.company_id
    WHERE
        job_title_short = 'Data Engineer'
        AND salary_year_avg IS NOT NULL
        AND job_work_from_home = TRUE
    ORDER BY
        salary_year_avg DESC
    LIMIT 10
)
SELECT 
    top_paying_jobs.*,
    skills_dim.skills
FROM top_paying_jobs
INNER JOIN skills_job_dim ON top_paying_jobs.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
ORDER BY
    salary_year_avg DESC;

/*
----------------------------------------------------------------------
QUESTION 3: Top Demand Skills
- What are the most in-demand skills for Data Analysts?
- Why? Helpful for job seekers to know what skills to prioritize for employability.
----------------------------------------------------------------------
*/
SELECT 
    skills,
    COUNT(skills_job_dim.job_id) as demand_count
FROM job_postings_fact
INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE
    job_title_short = 'Data Analyst'
    OR job_title_short = 'Data Engineer' 
GROUP BY
    skills
ORDER BY
    demand_count DESC
LIMIT 5;

/*
----------------------------------------------------------------------
QUESTION 4: Top Paying Skills (Unrelated to job title)
- What are the top skills based on average salary?
- Why? It reveals financial value of specific skills.
----------------------------------------------------------------------
*/
SELECT 
    skills,
    ROUND(AVG(salary_year_avg), 0) as avg_salary
FROM job_postings_fact
INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE
    salary_year_avg IS NOT NULL
    AND job_title_short = 'Data Analyst'
GROUP BY
    skills
ORDER BY
    avg_salary DESC
LIMIT 10;

/*
----------------------------------------------------------------------
QUESTION 5: Optimal Skills (High Demand + High Salary)
- What are the most optimal skills to learn (aka it’s in high demand and a high-paying skill)?
- Target: Data Analysts
- Why? Targets skills that offer job security (high demand) and financial benefits (high salaries).
----------------------------------------------------------------------
*/
WITH skills_demand AS (
    SELECT
        skills_dim.skill_id,
        skills_dim.skills,
        COUNT(skills_job_dim.job_id) AS demand_count
    FROM job_postings_fact
    INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
    INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
    WHERE
        job_title_short = 'Data Analyst' 
        AND salary_year_avg IS NOT NULL
    GROUP BY
        skills_dim.skill_id, skills_dim.skills
), 
average_salary AS (
    SELECT
        skills_dim.skill_id,
        skills_dim.skills,
        ROUND(AVG(salary_year_avg), 0) AS avg_salary
    FROM job_postings_fact
    INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
    INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
    WHERE
        job_title_short = 'Data Analyst'
        AND salary_year_avg IS NOT NULL
    GROUP BY
        skills_dim.skill_id, skills_dim.skills
)
SELECT
    skills_demand.skill_id,
    skills_demand.skills,
    demand_count,
    avg_salary
FROM
    skills_demand
INNER JOIN  average_salary ON skills_demand.skill_id = average_salary.skill_id
WHERE
    demand_count > 10 -- Only significant demand
ORDER BY
    avg_salary DESC,
    demand_count DESC
LIMIT 25;
