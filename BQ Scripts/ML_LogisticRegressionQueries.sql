-- Print Precision, Recall, Accuracy, F1 Score, Log Loss, and AUC for the model 
SELECT * FROM ML.EVALUATE(MODEL `gcp-project-375309.ml.weather_predict`, TABLE `ml.weatherAUS` );

-- Print Precision, Recall, Accuracy, F1 Score, Log Loss, and AUC for the model for given threshold
SELECT * FROM ML.EVALUATE(MODEL `gcp-project-375309.ml.weather_predict`, TABLE `ml.weatherAUS`, STRUCT(0.55 AS threshold) );

-- Print Recall, FP, TP, FN, TN for threshold range between 0.3 & 0.7 stepping up by 0.1
SELECT * FROM ML.ROC_CURVE(MODEL `gcp-project-375309.ml.weather_predict`, TABLE `ml.weatherAUS`, GENERATE_ARRAY (0.3, 0.7, 0.1));

-- Print COnfusion Matrix for given threshold
SELECT * FROM ML.CONFUSION_MATRIX(MODEL `gcp-project-375309.ml.weather_predict`, TABLE `ml.weatherAUS`, STRUCT(0.65 AS threshold));

-- ML Predict
SELECT * FROM ML.PREDICT(MODEL `gcp-project-375309.ml.weather_predict`, TABLE `ml.weatherAUS`, STRUCT(0.65 AS threshold));
/*
predicted_RainTomorrow	predicted_RainTomorrow_probs	Date	Location	WindGustDir	WindDir9am	WindDir3pm	RainToday	RainTomorrow	MinTemp	MaxTemp	Rainfall	Evaporation	Sunshine	WindGustSpeed	WindSpeed9am	WindSpeed3pm	Humidity9am	Humidity3pm	Pressure9am	Pressure3pm	Cloud9am	Cloud3pm	Temp9am	Temp3pm
No	"{
  ""predicted_RainTomorrow_probs"": [{
    ""label"": ""Yes"",
    ""prob"": ""0.06707553501500399""
  }, {
    ""label"": ""No"",
    ""prob"": ""0.932924464984996""
  }]
}"	2015-09-25	Adelaide	E	ENE	E	No	No	10.6	20.0	0.0			37.0	9.0	11.0	40.0	32.0	1032.4	1028.2			16.1	19.6
*/
/*
predicted_RainTomorrow -> Predicted value
predicted_RainTomorrow_probs -> Dict of possible Outputs and probabilitiy assigned
*/

-- Detail on how prediction was made with weights for each feature
SELECT * FROM ML.EXPLAIN_PREDICT(MODEL `gcp-project-375309.ml.weather_predict`, TABLE `ml.weatherAUS`, STRUCT(0.65 AS threshold));

--Weights assigned to each feature
SELECT * FROM ML.EXPLAIN_PREDICT(MODEL `gcp-project-375309.ml.weather_predict`, TABLE `ml.weatherAUS`, STRUCT(0.65 AS threshold));

-- Weights assigned to each feature for all possible outcome
SELECT * FROM ML.EXPLAIN_PREDICT(MODEL `gcp-project-375309.ml.weather_predict`, TABLE `ml.weatherAUS`, STRUCT(0.65 AS threshold));

-- Weight assigned to each Input
SELECT * FROM ML.GLOBAL_EXPLAIN(MODEL `gcp-project-375309.ml.weather_predict`, STRUCT(TRUE AS class_level_explain));
