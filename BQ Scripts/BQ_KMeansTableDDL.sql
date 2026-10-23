EXPORT DATA
  OPTIONS (
    uri = 'gs://anand12345/Biketrip/biketrip_*.csv',
    format = 'CSV',
    overwrite = TRUE,
    header = TRUE,
    field_delimiter = ',')
AS
SELECT
  tripduration,
  starttime,
  stoptime,
  start_station_id,
  start_station_name,
  end_station_id,
  end_station_name,
  bikeid,
  usertype,
  birth_year,
  gender,
  customer_plan
FROM
  `bigquery-public-data.new_york_citibike.citibike_trips`
WHERE
  start_station_name IS NOT NULL
  AND end_station_name IS NOT NULL
  AND tripduration > 0
  AND usertype IS NOT NULL
  AND starttime IS NOT NULL
LIMIT 200000;

LOAD DATA INTO `gcp-project-375309.ml.citibike_trips`
FROM
  FILES(
    format = 'CSV',
    uris = ['gs://anand12345/Biketrip/biketrip_*.csv'],
    skip_leading_rows = 1);
