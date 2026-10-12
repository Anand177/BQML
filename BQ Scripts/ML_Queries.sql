select * from ML.EVALUATE (MODEL `gcp-project-375309.ml.housing_prices`, (SELECT AVG_HOUSE_AGE, AVG_TOTAL_ROOMS, AVG_TOTAL_BEDROOMS, AVG_HOUSE_AREA, ZIP, HOUSE_PRICE as price FROM `gcp-project-375309.ml.housing_detail_avgd` limit 1000)) ;

SELECT * FROM ML.PREDICT(MODEL `gcp-project-375309.ml.housing_prices`, (
  SELECT
     HOUSE_AGE as AVG_HOUSE_AGE, TOTAL_ROOMS AS AVG_TOTAL_ROOMS, TOTAL_BEDROOMS AS AVG_TOTAL_BEDROOMS, HOUSE_AREA as AVG_HOUSE_AREA, ZIP
  FROM `ml.housing_detail_raw` WHERE id between 1 and 10
));

SELECT * FROM ML.TRAINING_INFO(MODEL `gcp-project-375309.ml.housing_prices_2`);
SELECT * FROM ML.FEATURE_INFO(MODEL `gcp-project-375309.ml.housing_prices_2`)
SELECT * FROM ML.WEIGHTS(MODEL `gcp-project-375309.ml.housing_prices_2`);

# Review Predicted vs actual Values
select * from 
ML.PREDICT(MODEL `gcp-project-375309.ml.housing_prices_2`, 
(SELECT * FROM ML.PREDICT(MODEL `gcp-project-375309.ml.housing_prices_2`, (SELECT
     HOUSE_AGE, TOTAL_ROOMS, TOTAL_BEDROOMS, HOUSE_AREA, ZIP, POPULATION, OWNER_INCOME, HOUSE_PRICE/100
  FROM `ml.housing_detail_raw` WHERE id between 1 and 10)
  
)))

#HP Tuning
select * FROM ML.EVALUATE(MODEL `ml.housing_prices_hpt`)
select * from ML.TRIAL_INFO(MODEL `ml.housing_prices_hpt`)

# Explain how model arrived @ prediction
SELECT * FROM ML.EXPLAIN_PREDICT(MODEL `gcp-project-375309.ml.housing_prices_hpt`, 
(SELECT HOUSE_AGE, TOTAL_ROOMS, TOTAL_BEDROOMS, HOUSE_AREA, POPULATION, OWNER_INCOME, ZIP 
FROM `gcp-project-375309.ml.housing_detail_raw` where id =100), 
STRUCT(10 AS top_k_features));

#GLobal Explain
SELECT * from ML.GLOBAL_Explain (MODEL `gcp-project-375309.ml.housing_prices_glbl`)