SELECT

    COUNT(CASE WHEN number_of_purchases = 1 THEN 'one_time'  END) AS one_time,
    COUNT(CASE WHEN number_of_purchases > 1 THEN 'repeat' END) AS repeat

FROM(
    SELECT 
        sd.customer_id,
        COUNT(ef.event_type) as number_of_purchases
        
    FROM events_fact AS ef

    JOIN sessions_dim AS sd
    ON ef.session_id = sd.session_id

    WHERE event_type = 'purchase'
    GROUP BY sd.customer_id
    ORDER BY customer_id
) AS sub

