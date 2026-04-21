
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
    
)

SELECT 
    au.source,
    COUNT(us.customer_id) AS total_customers,
    SUM(CASE WHEN us.status = 'Churned' THEN 1 ELSE 0  END) AS Churned_customers,
    SUM(CASE WHEN us.status = 'Active' THEN 1 ELSE 0  END) AS active_customers,
    SUM(CASE WHEN us.status = 'Never Purchased' THEN 1 ELSE 0  END) AS Never_purchased

FROM user_status AS us

JOIN all_users AS au
ON au.customer_id = us.customer_id
GROUP BY au.source
ORDER BY total_customers DESC  

-- Despite differences in acquisition channels, user lifecycle outcomes remain consistent, suggesting that improving post-acquisition experience presents the greatest opportunity for growth.