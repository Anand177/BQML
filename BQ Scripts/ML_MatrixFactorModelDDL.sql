CREATE OR REPLACE MODEL `ml.product_reco` OPTIONS (
  model_type='matrix_factorization',
  user_col='user_id', item_col='product_id', 
  num_factors=35, l2_reg=9
) AS SELECT user_id, product_id, rating FROM `gcp-project-375309.ml.amazon_product_recommendation_final`