CREATE TABLE tbl_store (
	store_id SERIAL PRIMARY KEY ,
	address VARCHAR(300) NOT NULL,
	city VARCHAR(100) NOT NULL,
	phone_number VARCHAR(50) NOT NULL,
	opened_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP
	
);


CREATE TABLE 	tbl_customers (
    customer_id SERIAL PRIMARY KEY,
    first_name VARCHAR(100) NOT NULL,
    last_name VARCHAR(100) NOT NULL,
    email VARCHAR(255) UNIQUE NOT NULL,
    phone_number VARCHAR(20) UNIQUE NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);


CREATE TABLE tbl_ingredients (
    ingredient_id SERIAL PRIMARY KEY,
    name VARCHAR(100) UNIQUE NOT NULL,
    stock_quantity NUMERIC(10, 2) NOT NULL DEFAULT 0,
    unit VARCHAR(20) NOT NULL
);

CREATE TABLE tbl_ategory (
    category_id SERIAL PRIMARY KEY,
    category_name VARCHAR(100) NOT NULL
);

ALTER TABLE tbl_ategory RENAME TO tbl_category;


CREATE TABLE Menu_Items (
    item_id SERIAL PRIMARY KEY,
    name VARCHAR(150) NOT NULL,
    category_id INT NOT NULL REFERENCES tbl_category(category_id) ON DELETE CASCADE,
    size VARCHAR(20)
);

CREATE TABLE tbl_orders (
    order_id SERIAL PRIMARY KEY,
    customer_id INT REFERENCES tbl_customers(customer_id) ON DELETE SET NULL,
    store_id INT REFERENCES tbl_stores(store_id) ON DELETE RESTRICT,
    order_timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    total_amount NUMERIC(10, 2) NOT NULL
);



