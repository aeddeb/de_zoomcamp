-- q1
SELECT COUNT(1) 
FROM `sinuous-gist-339116.dbt_aeddeb.fact_trips`
WHERE DATE(pickup_datetime) BETWEEN '2019-01-01' AND '2020-12-31';

-- q2
WITH green AS (
    SELECT COUNT(1) AS num_trips
    FROM `sinuous-gist-339116.dbt_aeddeb.fact_trips`
    WHERE DATE(pickup_datetime) BETWEEN '2019-01-01' AND '2020-12-31'
    AND service_type = 'Green'),
yellow AS(    
    SELECT COUNT(1) AS num_trips
    FROM `sinuous-gist-339116.dbt_aeddeb.fact_trips`
    WHERE DATE(pickup_datetime) BETWEEN '2019-01-01' AND '2020-12-31'
    AND service_type = 'Yellow')
SELECT yellow.num_trips / green.num_trips as ratio FROM yellow, green;

-- q3
SELECT COUNT(1) 
FROM `sinuous-gist-339116.dbt_aeddeb.stg_fhv_tripdata`
WHERE DATE(pickup_datetime) BETWEEN '2019-01-01' AND '2019-12-31';

-- q4
SELECT COUNT(1) 
FROM `sinuous-gist-339116.dbt_aeddeb.fact_fhv_trips`
WHERE DATE(pickup_datetime) BETWEEN '2019-01-01' AND '2019-12-31';

-- q5
SELECT 
    EXTRACT(YEAR from pickup_datetime) as year,
    EXTRACT(MONTH from pickup_datetime) as month,
    COUNT(*) AS num_trips
FROM `sinuous-gist-339116.dbt_aeddeb.fact_fhv_trips`
GROUP BY year, month
ORDER BY num_trips DESC;

