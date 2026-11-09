CREATE OR REPLACE MODEL `ml.weather_arima` OPTIONS (
  MODEL_TYPE='ARIMA_PLUS',
  TIME_SERIES_TIMESTAMP_COL='MeasuredDate',
  TIME_SERIES_DATA_COL='Humidity',
  TIME_SERIES_ID_COL = ['Location'],
  AUTO_ARIMA=TRUE,
  DATA_FREQUENCY = 'DAILY'
) AS SELECT MeasuredDate, Humidity, 'Nhil' as Location 
FROM `ml.weather_nhil`
ORDER BY MeasuredDate;

CREATE OR REPLACE MODEL `ml.weather_arima_complete` OPTIONS (
  MODEL_TYPE='ARIMA_PLUS',
  TIME_SERIES_TIMESTAMP_COL='MeasuredDate',
  TIME_SERIES_DATA_COL='Humidity',
  TIME_SERIES_ID_COL = ['Location'],
  AUTO_ARIMA=TRUE,
  DATA_FREQUENCY = 'DAILY',
  CLEAN_SPIKES_AND_DIPS = TRUE
) AS SELECT `Date` AS MeasuredDate, CAST((Humidity9am + Humidity3pm)/2 AS INT64) Humidity, Location 
FROM `ml.weatherAUS` 
ORDER BY MeasuredDate;