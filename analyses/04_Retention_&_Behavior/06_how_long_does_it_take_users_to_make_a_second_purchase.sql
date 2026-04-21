WITH ranked_purchases AS (
    SELECT 
    customer_id,
    time_stamp,
    RANK() OVER( PARTITION BY customer_id ORDER BY time_stamp ) AS purchase_order

    FROM events_fact AS ef

    JOIN sessions_dim AS sd
    ON ef.session_id = sd.session_id

    WHERE event_type = 'purchase' AND
        time_stamp IS NOT NULL

  
),
first_second  AS (
    SELECT  
        p1.customer_id,
        p1.time_stamp AS first_purchase,
        p2.time_stamp AS second_purchase
        
    FROM
        ranked_purchases p1
    JOIN ranked_purchases AS p2
    ON p1.customer_id = p2.customer_id
    AND p1.purchase_order = 1
    AND p2.purchase_order = 2
    WHERE p2.time_stamp <= p1.time_stamp + INTERVAL '90 days'  


)

SELECT
    PERCENTILE_CONT(0.5)
    WITHIN GROUP (ORDER BY (second_purchase - first_purchase))
FROM
    first_second

-- Repeat purchases are not impulsive but occur after a moderate delay, suggesting users return based on need or periodic demand rather than continuous engagement
-- While a majority of purchasers return, the median time to repeat purchase is approximately 45 days, indicating that user engagement does not translate into frequent transactions and that opportunities exist to shorten the purchase cycle