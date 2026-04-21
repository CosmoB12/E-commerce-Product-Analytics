WITH user_status AS (
    SELECT 
        sd.customer_id,
        CASE 
            WHEN MAX(CASE WHEN ef.event_type = 'purchase' THEN ef.time_stamp END) IS NULL 
                THEN 'Never Purchased'
            WHEN MAX(CASE WHEN ef.event_type = 'purchase' THEN ef.time_stamp END)::DATE 
                <= '2025-11-01'::DATE - 90 
                THEN 'Churned' 
            ELSE 'Active' 
        END AS status
    FROM sessions_dim sd
    LEFT JOIN events_fact ef
        ON sd.session_id = ef.session_id
    GROUP BY sd.customer_id
),

sessions_per_week AS (
    SELECT
        customer_id,
        DATE_TRUNC('week', start_time) AS week,
        COUNT(DISTINCT session_id) AS weekly_sessions
    FROM sessions_dim
    GROUP BY customer_id, DATE_TRUNC('week', start_time)
),

avg_sessions AS (
    SELECT
        customer_id,
        AVG(weekly_sessions) AS avg_sessions_per_week
    FROM sessions_per_week
    GROUP BY customer_id
),

segmented_users AS (
    SELECT
        customer_id,
        avg_sessions_per_week,
        CASE
            WHEN avg_sessions_per_week < 1 THEN 'Very Low'
            WHEN avg_sessions_per_week BETWEEN 1 AND 2 THEN 'Low'
            WHEN avg_sessions_per_week BETWEEN 3 AND 5 THEN 'Medium'
            ELSE 'High'
        END AS user_segment
    FROM avg_sessions
)

SELECT
    su.user_segment,
    us.status,
    COUNT(*) AS users
FROM segmented_users su
JOIN user_status us
    ON su.customer_id = us.customer_id
GROUP BY su.user_segment, us.status
ORDER BY su.user_segment, us.status;

-- User engagement is extremely shallow across the platform, with nearly all users averaging ≤1–2 sessions per week. This lack of repeated interaction likely contributes to high churn, but further segmentation is required to isolate its impact.