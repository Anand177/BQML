CREATE OR REPLACE MODEL
`gcp-project-375309.ml.housing_prices` OPTIONS(model_type='linear_reg', input_label_cols=['price'])
AS SELECT 
AVG_HOUSE_AGE, AVG_TOTAL_ROOMS, AVG_TOTAL_BEDROOMS, AVG_HOUSE_AREA, ZIP, HOUSE_PRICE/100 AS PRICE 
FROM `gcp-project-375309.ml.housing_detail_avgd`;

CREATE OR REPLACE MODEL
`gcp-project-375309.ml.housing_prices_2` 
OPTIONS(model_type='linear_reg', input_label_cols=['price'], l2_reg=0.1, early_stop=false, max_iterations=15, optimize_strategy='batch_gradient_descent')
AS SELECT 
HOUSE_AGE, TOTAL_ROOMS, TOTAL_BEDROOMS, HOUSE_AREA, POPULATION, OWNER_INCOME, ZIP, HOUSE_PRICE/100 AS PRICE 
FROM `gcp-project-375309.ml.housing_detail_raw`;


# Hyper Parm tuning, the model selected 2 as best l2 and got created with it
CREATE OR REPLACE MODEL
`gcp-project-375309.ml.housing_prices_hpt`
OPTIONS(model_type='linear_reg', input_label_cols=['price'], early_stop=false, max_iterations=15,
NUM_TRIALS=10, l2_reg = HPARAM_RANGE(0.9,2))
AS SELECT 
HOUSE_AGE, TOTAL_ROOMS, TOTAL_BEDROOMS, HOUSE_AREA, POPULATION, OWNER_INCOME, ZIP, HOUSE_PRICE/100 AS PRICE 
FROM `gcp-project-375309.ml.housing_detail_raw`;

# Enabling GLobal Explain
CREATE OR REPLACE MODEL
`gcp-project-375309.ml.housing_prices_2` 
OPTIONS(model_type='linear_reg', input_label_cols=['price'], l2_reg=0.1, early_stop=false, max_iterations=15, optimize_strategy='batch_gradient_descent')
AS SELECT 
HOUSE_AGE, TOTAL_ROOMS, TOTAL_BEDROOMS, HOUSE_AREA, POPULATION, OWNER_INCOME, ZIP, HOUSE_PRICE/100 AS PRICE 
FROM `gcp-project-375309.ml.housing_detail_raw`;

