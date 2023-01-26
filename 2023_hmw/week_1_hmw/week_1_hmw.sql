SELECT * FROM green_taxi_trips LIMIT 5;

-- Q3. count records
SELECT COUNT(*) 
FROM green_taxi_trips
WHERE cast(lpep_pickup_datetime as date) = '2019-01-15' 
	and cast(lpep_dropoff_datetime as date) = '2019-01-15';

-- Q4. Day with Largest trip
SELECT lpep_pickup_datetime, MAX(trip_distance) 
FROM green_taxi_trips
group by lpep_pickup_datetime
ORDER by MAX(trip_distance) DESC
LIMIT 1; 

-- q5. Num of trips by passenger_count
SELECT passenger_count, COUNT(*) FROM green_taxi_trips
WHERE (passenger_count = 2 OR passenger_count = 3)
	AND cast(lpep_pickup_datetime as date) = '2019-01-01'
GROUP BY passenger_count;
	

SELECT * FROM zones LIMIT 5;
select * from zones where zone = 'Astoria';

-- q6. Largest tip
SELECT zdo.zone as do_zone, MAX(tip_amount) as max_tip
FROM green_taxi_trips as gtt
	LEFT JOIN zones as zpu
		ON gtt.pulocationid = zpu.locationid
	LEFT JOIN zones as zdo
		ON gtt.dolocationid = zdo.locationid
WHERE zpu.zone = 'Astoria'
GROUP BY zdo.zone
ORDER BY max_tip DESC
LIMIT 1;
