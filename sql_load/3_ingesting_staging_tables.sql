COPY orders_fact_raw
FROM 'D:\SQL Projects\E-commerce Product Analytics\load_csv\orders.csv'
WITH(FORMAT csv,HEADER true, DELIMITER ',',ENCODING 'UTF8');

COPY order_items_raw
FROM 'D:\SQL Projects\E-commerce Product Analytics\load_csv\order_items.csv'
WITH(FORMAT csv,HEADER true, DELIMITER ',',ENCODING 'UTF8');

COPY products_raw
FROM 'D:\SQL Projects\E-commerce Product Analytics\load_csv\products.csv'
WITH(FORMAT csv,HEADER true, DELIMITER ',',ENCODING 'UTF8');

COPY customers_raw
FROM 'D:\SQL Projects\E-commerce Product Analytics\load_csv\customers.csv'
WITH(FORMAT csv,HEADER true, DELIMITER ',',ENCODING 'UTF8');

COPY sessions_raw
FROM 'D:\SQL Projects\E-commerce Product Analytics\load_csv\sessions.csv'
WITH(FORMAT csv,HEADER true, DELIMITER ',',ENCODING 'UTF8');

COPY events_raw
FROM 'D:\SQL Projects\E-commerce Product Analytics\load_csv\events.csv'
WITH(FORMAT csv,HEADER true, DELIMITER ',',ENCODING 'UTF8');

COPY reviews_raw
FROM 'D:\SQL Projects\E-commerce Product Analytics\load_csv\reviews.csv'
WITH(FORMAT csv,HEADER true, DELIMITER ',',ENCODING 'UTF8');
