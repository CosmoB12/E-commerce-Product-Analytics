    WITH sessions AS (
        SELECT 
            customer_id,
            sd.session_id,
            COUNT(event_id) AS no_of_events
        FROM sessions_dim AS sd
        JOIN events_fact AS ef
        ON ef.session_id = sd.session_id

        GROUP BY
            customer_id,
            sd.session_id
    )

    SELECT
        CASE 
        WHEN no_of_events = 1 THEN '1 events'
        WHEN no_of_events BETWEEN 2 AND 3 THEN '2-3 events'
        WHEN no_of_events BETWEEN 4 AND 6  THEN '4-6 events'
        ELSE '7+ events'
        END AS sessions_depth,
        COUNT(*) AS sessions

    FROM sessions
    GROUP BY sessions_depth

    -- “Despite strong in-session engagement, with over 70% of sessions involving multiple interactions, users fail to convert or return, suggesting that the primary friction occurs at the decision or post-engagement stage rather than during initial exploration.”