SELECT
    ef.event_type,
    COUNT(*) AS total_events,
    COUNT(DISTINCT sd.customer_id) AS total_users,
    COUNT(*) * 1.0 /  COUNT(DISTINCT sd.customer_id) AS average_events_per_user
 
FROM 
    events_fact as ef
JOIN sessions_dim AS sd
ON ef.session_id = sd.session_id

WHERE event_type IN ('add_to_cart','checkout','purchase')

GROUP BY
    
    ef.event_type