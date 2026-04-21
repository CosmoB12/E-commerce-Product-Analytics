INSERT INTO products_dim(
    SELECT
        product_id,
        category,
        name,
        price_usd,
        cost_usd,
        margin_usd
    FROM
        products_raw
)

INSERT INTO customers_dim(
    SELECT
        customer_id,
        name,
        email,
        country,
        age,
        signup_date,
        marketing_opt_in
    FROM 
        customers_raw
)

INSERT INTO orders_fact(
    SELECT
        order_id,
        customer_id,
        order_time,
        payment_method,
        discout_pct,
        subtotal_usd,
        total_usd,
        country,
        device,
        source
    FROM 
        orders_fact_raw 
)

INSERT INTO order_items_fact(
    SELECT
        order_id,
        product_id,
        unit_price_usd,
        SUM(quantity),
        SUM(line_total)
    FROM
        order_items_raw
    GROUP BY 
        order_id,
        product_id,
        unit_price_usd
)

INSERT INTO sessions_dim(
    SELECT
        session_id,
        customer_id,
        start_time,
        device,
        source,
        country

    FROM 
        sessions_raw
)

INSERT INTO events_fact(
    SELECT
        event_id,
        session_id,
        time_stamp,
        event_type,
        product_id,
        quantity,
        cart_size,
        payment_method,
        discout_pct,
        amount_usd
    FROM
        events_raw
)

INSERT INTO reviews_fact(
    SELECT
        review_id,
        order_id,
        product_id,
        rating,
        review_text,
        review_time
    FROM
        reviews_raw
)

