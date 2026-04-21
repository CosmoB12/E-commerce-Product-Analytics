WITH first_event AS( 
    SELECT
        sd.session_id,
        sd.customer_id,
        MIN(ef.time_stamp) AS first_event,
        MIN(CASE WHEN ef.event_type = 'purchase' THEN time_stamp END) AS first_purchase

    FROM events_fact AS ef

    JOIN sessions_dim AS sd
    ON ef.session_id = sd.session_id
    WHERE ef.time_stamp IS NOT NULL
    GROUP BY 
    customer_id,
    sd.session_id
)


SELECT
    AVG(first_purchase - first_event) AS avg_time_to_purchase
    FROM
        first_event
    WHERE
        first_event IS NOT NULL AND
        first_purchase IS NOT NULL AND
        first_purchase > first_event





