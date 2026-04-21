WITH user_event AS(
    SELECT
        sd.customer_id,
        MAX(CASE WHEN ef.event_type = 'add_to_cart' THEN 1 ELSE 0 END) as added_to_cart,
        MAX(CASE WHEN ef.event_type = 'purchase' THEN 1 ELSE 0 END) as purchased


    FROM events_fact AS ef
    JOIN sessions_dim AS sd
    ON ef.session_id  = sd.session_id

    GROUP BY
        customer_id
)

SELECT
    COUNT(*) FILTER(WHERE added_to_cart = 0) AS non_cart_users,
    COUNT(*) FILTER(WHERE added_to_cart = 1) AS cart_users,
    COUNT(*) FILTER(WHERE added_to_cart = 1 AND purchased = 1) AS converted_users,
    COUNT(*) FILTER(WHERE added_to_cart = 1 AND purchased = 0) AS abandoned_users,

    COUNT(*) FILTER(WHERE added_to_cart = 1 AND purchased = 0)  * 1.0 / COUNT(*) FILTER(WHERE added_to_cart = 1) AS cart_abandomenet_rate



FROM
    user_event
   
-- Cart abandonment is relatively low (~17%), indicating strong conversion once purchase intent is established. However, the dataset shows extremely low non-cart user activity, suggesting that the primary bottleneck lies earlier in the funnel—likely in converting visitors into active shoppers rather than converting carts into purchases.
