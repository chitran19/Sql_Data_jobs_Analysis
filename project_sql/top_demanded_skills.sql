SELECT 
    skills,
    count(skills_job_dim.job_id) AS demand_count,
    job_title  
FROM job_postings_fact
INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim on skills_job_dim.skill_id = skills_dim.skill_id
WHERE
    job_title_short = 'Data Analyst' AND
    job_country = 'India'
GROUP BY 
    skills,
    job_title
ORDER BY
    demand_count DESC

