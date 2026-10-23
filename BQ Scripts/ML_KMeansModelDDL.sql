CREATE OR REPLACE MODEL `ml.bike_trip`
  TRANSFORM(
    start_station_name,
    end_station_name,
    duration_min,
    usertype,
    CAST(EXTRACT(HOUR FROM starttime) AS STRING) AS ride_hour)
  OPTIONS (
    MODEL_TYPE = 'KMEANS',
    NUM_TRIALS = 6,
    NUM_CLUSTERS = HPARAM_RANGE(2, 10),
    KMEANS_INIT_METHOD = 'KMEANS++')
AS
SELECT
  start_station_name,
  end_station_name,
  tripduration / 60 AS duration_min,
  usertype,
  starttime
FROM `gcp-project-375309.ml.citibike_trips`;


CREATE OR REPLACE MODEL `ml.bike_trip_2`
  TRANSFORM(
    start_station_name,
    end_station_name,
    duration_min,
    usertype,
    CAST(EXTRACT(HOUR FROM starttime) AS STRING) AS ride_hour)
  OPTIONS (
    MODEL_TYPE = 'KMEANS',
    NUM_TRIALS = 6,
    NUM_CLUSTERS = HPARAM_RANGE(2, 10),
    KMEANS_INIT_METHOD = 'KMEANS++',
    DISTANCE_TYPE='COSINE',
    MIN_REL_PROGRESS=0.005)
AS
SELECT
  start_station_name,
  end_station_name,
  tripduration / 60 AS duration_min,
  usertype,
  starttime
FROM `gcp-project-375309.ml.citibike_trips`;