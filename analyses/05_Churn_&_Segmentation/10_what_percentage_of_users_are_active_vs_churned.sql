
WITH all_users AS(
    SELECT
    source,
    customer_id
    FROM sessions_dim

),
customer_last_activity AS(
    SELECT
        sd.customer_id,
        MAX(ef.time_stamp) last_purchase
        
    FROM events_fact AS ef

    JOIN sessions_dim AS sd
    ON ef.session_id = sd.session_id
    WHERE event_type = 'purchase'

    GROUP BY
        sd.customer_id

),
user_status AS(
    SELECT 
        au.customer_id,
        CASE 
        WHEN last_purchase IS NULL THEN 'Never Purchased'
        WHEN last_purchase::DATE <= '2025-11-01'::DATE - 90 THEN 'Churned' ELSE 'Active' 

        END AS status

    FROM customer_last_activity AS cl
    RIGHT JOIN all_users AS au
    ON cl.customer_id = au.customer_id 
    GROUP BY
        au.customer_id,
        last_purchase
    
),
user_engagement AS(
    SELECT
        customer_id,
        COUNT(*) FILTER(WHERE ef.event_type = 'add_to_cart') AS add_to_cart,
        COUNT(*) FILTER(WHERE ef.event_type = 'checkout') AS checkout,
        COUNT(*) FILTER(WHERE ef.event_type = 'purchase') AS purchase


    FROM events_fact AS ef
    JOIN sessions_dim AS sd
    ON sd.session_id = ef.session_id
    GROUP BY
    sd.customer_id
)
SELECT 
    us.status,
    ROUND(AVG(ue.add_to_cart),0) AS avg_add_to_cart,
    ROUND(AVG(ue.checkout),0) AS avg_checkout,
    ROUND(AVG(ue.purchase),0) AS avg_purchase

FROM user_status AS us

JOIN user_engagement AS ue
ON ue.customer_id = us.customer_id
GROUP BY
    status

