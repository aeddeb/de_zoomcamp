SELECT COUNT(1) FROM yellow_taxi_trips;
SELECT COUNT(1) FROM zones;

SELECT * FROM yellow_taxi_trips LIMIT 10;
SELECT * FROM zones LIMIT 15;

-- Q3 How many trips were there on jan 15
SELECT 
	tpep_pickup_datetime,
	tpep_dropoff_datetime
FROM
	yellow_taxi_trips
WHERE
	DATE(tpep_pickup_datetime) = '2021-01-15';
	
SELECT 
	COUNT(*)
FROM
	yellow_taxi_trips
WHERE
	DATE(tpep_pickup_datetime) = '2021-01-15';



--Q4 Find the day in january with the largest tip
SELECT 
	DATE(tpep_pickup_datetime) as day,
	MAX(tip_amount) as largest_tip
FROM
	yellow_taxi_trips
GROUP BY
	day
ORDER BY
	largest_tip DESC;
	
	
-- Q5 what was the most popular destination for passengers pick up in Central Park?
SELECT *
FROM zones
WHERE "Zone" = 'Central Park';
-- Location ID 43 is central Park

SELECT 
	y."DOLocationID",
	COUNT(1) as num_trips
FROM 
	yellow_taxi_trips y
		LEFT JOIN zones z ON y."PULocationID" = z."LocationID"
WHERE y."PULocationID" = 43
GROUP BY y."DOLocationID"
ORDER BY num_trips DESC;
-- Top Destination has locationID of 236

-- Answer:
SELECT *
FROM zones
WHERE "LocationID" = 236;


-- Q6 Grouping with largest average price (total amount)?
SELECT
	"PULocationID",
	"DOLocationID",
	AVG(total_amount) as avg_amount
FROM
	yellow_taxi_trips
GROUP BY
	"PULocationID",
	"DOLocationID"
ORDER BY avg_amount DESC;

SELECT
	"PULocationID",
	"DOLocationID",
	total_amount
FROM
	yellow_taxi_trips
WHERE
	"PULocationID" = 4 AND
	"DOLocationID" = 265;

SELECT
	"LocationID",
	"Zone"
FROM
	zones
WHERE "LocationID" IN (4, 265);