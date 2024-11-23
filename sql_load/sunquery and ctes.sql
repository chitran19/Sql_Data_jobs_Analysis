 with january_jobs AS (
        SELECT *
        FROM job_postings_fact
        WHERE EXTRACT(MONTH FROM job_posted_date) = 1
 )

 SELECT * 
 FROM january_jobs;

SELECT name AS company_name 
FROM company_dim
WHERE company_id IN (
    SELECT
        company_id
        
    FROM 
        job_postings_fact
    WHERE 
        job_no_degree_mention = TRUE
        AND 
        job_location = 'India'
    ORDER BY
        company_id
)


WITH company_job_count AS (
SELECT
        company_id,
        job_title_short,
        count(*) AS total_jobs

FROM
        job_postings_fact
WHERE
        job_location = 'India'
        AND job_title_short IN ('Data Analyst', 'Business Analyst')

group BY
    company_id, job_title_short
)

SELECT 
    company_dim.name as company_name,
    company_job_count.job_title_short,
    company_job_count.total_jobs

FROM company_dim
LEFT JOIN company_job_count on company_job_count.company_id = company_dim.company_id
WHERE company_job_count.total_jobs IS NOT NUll
ORDER BY
    total_jobs DESC;
