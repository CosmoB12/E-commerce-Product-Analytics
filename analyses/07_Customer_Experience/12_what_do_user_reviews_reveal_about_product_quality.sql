SELECT
    review_text,
    rating,
    
    COUNT(DISTINCT(customer_id)) as count
   
FROM reviews_fact rf
JOIN orders_fact as of
ON rf.order_id = of.order_id
GROUP BY
    review_text,
    rf.rating

-- User feedback is largely positive, indicating that users who complete purchases are generally satisfied with the product
-- Despite high satisfaction among purchasers, overall user retention remains low.
-- A subset of users express dissatisfaction related to product quality, which may contribute to churn among purchasers.”