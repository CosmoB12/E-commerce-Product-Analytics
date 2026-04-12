CREATE TABLE products_dim(
    product_id INT PRIMARY KEY,
    category VARCHAR(20),
    name TEXT,
    price_usd NUMERIC,
    cost_usd NUMERIC,
    margin_usd NUMERIC
)

CREATE TABLE customers_dim(
    customer_id INT PRIMARY KEY,
    name TEXT,
    email TEXT,
    country VARCHAR(4),
    age INT,
    signup_date TIMESTAMP,
    marketing_opt_in BOOLEAN
)

CREATE TABLE orders_fact(
    order_id INT PRIMARY KEY,
    customer_id INT,
    order_time TIMESTAMP,
    payment_method VARCHAR(12),
    discount_pct INT,
    subtotal_usd NUMERIC,
    total_usd NUMERIC,
    country VARCHAR (4),
    device VARCHAR(12),
    source VARCHAR (12),
    FOREIGN KEY(customer_id) REFERENCES customers_dim(customer_id)
)
CREATE TABLE order_items_fact(
    order_id INT,
    product_id INT,
    unit_price_usd NUMERIC,
    quantity INT,
    line_total NUMERIC,
    PRIMARY KEY(order_id,product_id),
    FOREIGN KEY (product_id) REFERENCES products_dim(product_id)
)


CREATE TABLE sessions_dim(
    session_id INT PRIMARY KEY,
    customer_id INT,
    start_time TIMESTAMP,
    device VARCHAR(12),
    source VARCHAR (12),
    country VARCHAR (4),
    FOREIGN KEY (customer_id) REFERENCES customers_dim(customer_id)
)

CREATE TABLE events_fact(
    event_id INT PRIMARY KEY,
    session_id INT,
    time_stamp TIMESTAMP,
    event_type VARCHAR(20),
    product_id NUMERIC,
    quantity NUMERIC,
    cart_size NUMERIC,
    payment_method VARCHAR(12),
    discount_pct NUMERIC,
    amount_usd NUMERIC,
    FOREIGN KEY(session_id) REFERENCES sessions_dim(session_id)
)

CREATE TABLE reviews_fact(
    review_id INT PRIMARY KEY,
    order_id INT,
    product_id INT,
    rating INT,
    review_text TEXT,
    review_time TIMESTAMP,
    FOREIGN KEY (order_id) REFERENCES orders_fact(order_id),
    FOREIGN KEY (product_id) REFERENCES products_dim(product_id)
)
