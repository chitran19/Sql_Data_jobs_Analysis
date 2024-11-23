SELECT
    count(job_id) AS number_of_jobs,
    CASE
        WHEN job_location = 'Anywhere' THEN 'Remote'
        when job_location = 'New York, NY' THEN 'LOcal'
        Else 'On-site'
    END as location_category
FROM job_postings_fact
GROUP BY location_category;

