-- Week 3 Homework

-- Q1. What is count for fhv vehicles data for year 2019?

-- Create table first
CREATE OR REPLACE EXTERNAL TABLE sinuous-gist-339116.ny_taxi.external_fhv_trips
OPTIONS (
    format = 'PARQUET',
    uris = ['gs://dtc_data_lake_sinuous-gist-339116/raw/fhv_tripdata_2019_*.parquet']
);

SELECT COUNT(1) FROM sinuous-gist-339116.ny_taxi.external_fhv_trips;
-- count: 42084899


-- Q2. How many distinct dispatching_base_num we have in fhv for 2019?
SELECT COUNT(DISTINCT(dispatching_base_num)) FROM `sinuous-gist-339116.ny_taxi.external_fhv_trips`;
-- Answer: 792


-- Q3. Best strategy to optimise if query always filter by dropoff_datetime and order by dispatching_base_num?
-- Partition by dropoff_datetime and cluster by dispatching_base_num


-- Q4. What is the count, estimated and actual data processed for query which counts trip between 2019/01/01 
--      and 2019/03/31 for dispatching_base_num B00987, B02060, B02279 

-- First, create table with clustering and partitioning
CREATE OR REPLACE TABLE sinuous-gist-339116.ny_taxi.fhv_trips_partitoned_clustered
PARTITION BY DATE(pickup_datetime)
CLUSTER BY dispatching_base_num AS
SELECT * FROM sinuous-gist-339116.ny_taxi.external_fhv_trips;

SELECT 
    COUNT(1) AS num_trips
FROM sinuous-gist-339116.ny_taxi.fhv_trips_partitoned_clustered
WHERE (DATE(pickup_datetime) BETWEEN '2019-01-01' AND '2019-03-31') AND
    (dispatching_base_num IN ('B00987', 'B02060', 'B02279'));
-- estimated: 400 MB
-- actual: 139.6 MB

