WITH first_purchase AS (
    SELECT
        sd.customer_id,
        MIN(ef.time_stamp) AS first_purchase
    FROM events_fact ef
    JOIN sessions_dim sd
        ON ef.session_id = sd.session_id
    WHERE ef.event_type = 'purchase'
    GROUP BY sd.customer_id
),
sessions_to_purchase AS (
    SELECT
        fp.customer_id,
        COUNT(DISTINCT sd.session_id) AS sessions_to_purchase
    FROM first_purchase fp
    LEFT JOIN sessions_dim sd
        ON fp.customer_id = sd.customer_id
       AND sd.start_time < fp.first_purchase
    GROUP BY fp.customer_id
)
SELECT
    CASE
        WHEN sessions_to_purchase = 0 THEN '0 sessions'
        WHEN sessions_to_purchase = 1 THEN '1 session'
        WHEN sessions_to_purchase BETWEEN 2 AND 3 THEN '2-3 sessions'
        WHEN sessions_to_purchase BETWEEN 4 AND 6 THEN '4-6 sessions'
        ELSE '7+ sessions'
    END AS session_segment,
    COUNT(*) AS users
FROM sessions_to_purchase
GROUP BY session_segment
ORDER BY users DESC;