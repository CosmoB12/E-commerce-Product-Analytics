WITH sessions_per_week AS (
    SELECT
        customer_id,
        DATE_TRUNC('week',start_time) AS week,
        COUNT(DISTINCT session_id) AS weekly_sessions

    FROM sessions_dim
    GROUP BY
        customer_id,
        DATE_TRUNC('week',start_time) 

    ORDER BY week
)

SELECT
    CASE
        WHEN avg_sessions_per_week  = 1 THEN 'Low'
        WHEN avg_sessions_per_week BETWEEN 2 AND 3 THEN 'Medium'
        
    END  AS user_segment,

    COUNT(customer_id)
FROM(
    SELECT 
        customer_id,
        AVG(weekly_sessions) avg_sessions_per_week
    FROM
        sessions_per_week

    GROUP BY
        customer_id

    ORDER BY customer_id
)
GROUP BY user_segment


-- User engagement is extremely shallow, with the vast majority of users having only one session per week and almost no users exhibiting repeated engagement behavior