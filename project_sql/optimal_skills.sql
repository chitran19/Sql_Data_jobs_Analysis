WITH skills_demand AS (
    SELECT
        skills_job_dim.skill_id, -- Fully qualify skill_id
        skills_dim.skills,
        COUNT(skills_job_dim.job_id) AS demand_count  
    FROM job_postings_fact
    INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
    INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
    WHERE
        job_title_short = 'Data Analyst' AND
        salary_year_avg IS NOT NULL AND
        job_country = 'India'
    GROUP BY 
        skills_job_dim.skill_id, skills_dim.skills
),
average_salary AS (
    SELECT 
        skills_job_dim.skill_id, -- Fully qualify skill_id
        skills_dim.skills,
        ROUND(AVG(job_postings_fact.salary_year_avg), 0) AS avg_salary 
    FROM job_postings_fact
    INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
    INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
    WHERE
        job_title_short = 'Data Analyst' AND
        job_country = 'India' AND
        job_postings_fact.salary_year_avg IS NOT NULL
    GROUP BY 
        skills_job_dim.skill_id, skills_dim.skills
)
SELECT 
    skills_demand.skill_id,
    skills_demand.skills,
    skills_demand.demand_count,
    average_salary.avg_salary
FROM
    skills_demand
INNER JOIN average_salary ON skills_demand.skill_id = average_salary.skill_id
WHERE
    skills_demand.demand_count > 10
ORDER BY 
    average_salary.avg_salary DESC,
    skills_demand.demand_count DESC
LIMIT 25;

