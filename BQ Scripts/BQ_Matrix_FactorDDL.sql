CREATE OR REPLACE TABLE `gcp-project-375309.ml.amazon_product_recommendation_final` AS
SELECT
  s.product_id,
  s.product_name,
  s.discounted_price,
  s.actual_price,
  s.discount_percentage,
  CAST(s.rating AS NUMERIC) rating,
  s.rating_count,
  s.about_product,
  TRIM(uid)  AS user_id,
  TRIM(name) AS user_name,
  TRIM(rid)  AS review_id
FROM `gcp-project-375309.ml.amazon_product_recommendation_raw` AS s,
UNNEST(GENERATE_ARRAY(0, ARRAY_LENGTH(SPLIT(s.user_id, ',')) - 1)) AS idx
CROSS JOIN UNNEST(SPLIT(s.user_id, ','))   AS uid  WITH OFFSET AS o1
CROSS JOIN UNNEST(SPLIT(s.user_name, ',')) AS name WITH OFFSET AS o2
CROSS JOIN UNNEST(SPLIT(s.review_id, ',')) AS rid  WITH OFFSET AS o3
WHERE o1 = idx AND o2 = idx AND o3 = idx AND s.rating <> TRIM('|');