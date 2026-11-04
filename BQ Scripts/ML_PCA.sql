CREATE OR REPLACE MODEL ml.weather_pca OPTIONS (
  MODEL_TYPE='PCA',
  NUM_PRINCIPAL_COMPONENTS=4
) AS SELECT * EXCEPT (RainTomorrow, RainToday) FROM `gcp-project-375309.ml.weatherAUS`;

SELECT *
FROM ML.PREDICT(MODEL `gcp-project-375309.ml.weather_pca`, (
  SELECT
     Date, Location, WindGustDir, WindDir9am, WindDir3pm, MinTemp, MaxTemp, Rainfall, Evaporation, Sunshine, WindGustSpeed, WindSpeed9am, WindSpeed3pm, Humidity9am, Humidity3pm, Pressure9am, Pressure3pm, Cloud9am, Cloud3pm, Temp9am, Temp3pm
  FROM `gcp-project-375309.ml.weatherAUS` LIMIT 10
))