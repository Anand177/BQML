SELECT * FROM ML.EVALUATE (MODEL `gcp-project-375309.ml.bike_trip_2`);

SELECT * FROM ML.TRIAL_INFO (MODEL `gcp-project-375309.ml.bike_trip_2`);

SELECT * FROM ML.FEATURE_INFO (MODEL `gcp-project-375309.ml.bike_trip_2`);

SELECT * FROM ML.PREDICT (MODEL `gcp-project-375309.ml.bike_trip`, (SELECT start_station_name,
  end_station_name,
  tripduration / 60 AS duration_min,
  usertype,
  starttime FROM `ml.citibike_trips`LIMIT 20) );

SELECT avg(analysis.duration_min), centroid_id
FROM
( SELECT * FROM ML.PREDICT (MODEL `gcp-project-375309.ml.bike_trip`, (SELECT start_station_name,
  end_station_name,
  tripduration / 60 AS duration_min,
  usertype,
  starttime FROM `ml.citibike_trips` LIMIT 200) )) analysis
  group by centroid_id; 