CREATE OR REPLACE TABLE `ml.weather_nhil` AS SELECT
`Date` AS MeasuredDate, CAST(MinTemp AS INT64) MinTemp, CAST(MaxTemp AS INT64) MaxTemp, 
CAST(Rainfall*100 as INT64) AS Rainfall_mm, CAST(WindGustSpeed AS INT64) WindSpeed, 
CAST((Humidity9am + Humidity3pm)/2 AS INT64) Humidity
FROM `ml.weatherAUS` WHERE Location = 'Nhil';