/*
Question: what are the top-paying data analyst jobs?
-Identify the top 10 higesht-paying data analyst roles that are available remotely
-Focuses on job postings with specified salries (remove nulls).
-Why?Highlight the top-paying opprotunities for Data Analysts, offering insights into emp
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
LEFT JOIN company_dim on job_postings_fact.company_id = company_dim.company_id
WHERE
    job_title_short = 'Data Analyst' AND
    job_country = 'India' AND
    salary_year_avg IS NOt NULL
ORDER BY
    salary_year_avg 
LIMIT 10