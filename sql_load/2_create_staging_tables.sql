CREATE TABLE orders_fact_raw(
    order_id INT,
    customer_id INT,
    order_time TIMESTAMP,
    payment_method VARCHAR(12),
    discout_pct INT,
    subtotal_usd NUMERIC,
    total_usd NUMERIC,
    country VARCHAR (4),
    device VARCHAR(12),
    source VARCHAR (12)
)
CREATE TABLE order_items_raw(
    order_id INT,
    product_id INT,
    unit_price_usd NUMERIC,
    quantity INT,
    line_total NUMERIC
)
CREATE TABLE products_raw(
    product_id INT,
    category VARCHAR(20),
    name TEXT,
    price_usd NUMERIC,
    cost_usd NUMERIC,
    margin_usd NUMERIC
)

CREATE TABLE customers_raw(
    customer_id INT,
    name TEXT,
    email TEXT,
    country VARCHAR (4),
    age INT,
    signup_date TIMESTAMP,
    marketing_opt_in BOOLEAN
)

CREATE TABLE sessions_raw(
    session_id INT,
    customer_id INT,
    start_time TIMESTAMP,
    device VARCHAR(12),
    source VARCHAR (12),
    country VARCHAR (4)
)

CREATE TABLE events_raw(
    event_id INT,
    session_id INT,
    time_stamp TIMESTAMP,
    event_type VARCHAR(20),
    product_id NUMERIC,
    quantity NUMERIC,
    cart_size NUMERIC,
    payment_method VARCHAR(12),
    discout_pct NUMERIC,
    amount_usd NUMERIC
)

CREATE TABLE reviews_raw(
    review_id INT,
    order_id INT,
    product_id INT,
    rating INT,
    review_text TEXT,
    review_time TIMESTAMP
)
