-- ============================================
-- RushMore Pizzeria Enterprise Database
-- PostgreSQL Schema
-- ============================================

-- ========================
-- 1. STORES TABLE
-- ========================
CREATE TABLE Stores (
    store_id SERIAL PRIMARY KEY,
    address VARCHAR(255) NOT NULL,
    city VARCHAR(100) NOT NULL,
    phone_number VARCHAR(20) UNIQUE NOT NULL,
    opened_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- ========================
-- 2. CUSTOMERS TABLE
-- ========================
CREATE TABLE Customers (
    customer_id SERIAL PRIMARY KEY,
    first_name VARCHAR(100) NOT NULL,
    last_name VARCHAR(100) NOT NULL,
    email VARCHAR(255) UNIQUE NOT NULL,
    phone_number VARCHAR(20) UNIQUE NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- ========================
-- 3. CATEGORIES TABLE
-- ========================
CREATE TABLE Categories (
    category_id SERIAL PRIMARY KEY,
    category_name VARCHAR(100) UNIQUE NOT NULL
);

-- ========================
-- 4. INGREDIENTS TABLE
-- ========================
CREATE TABLE Ingredients (
    ingredient_id SERIAL PRIMARY KEY,
    name VARCHAR(100) UNIQUE NOT NULL,
    stock_quantity NUMERIC(10,2) NOT NULL DEFAULT 0,
    unit VARCHAR(20) NOT NULL
);

-- ========================
-- 5. MENU ITEMS TABLE
-- ========================
CREATE TABLE Menu_Items (
    item_id SERIAL PRIMARY KEY,
    name VARCHAR(150) NOT NULL,
    category_id INTEGER NOT NULL,
    size VARCHAR(20),

    CONSTRAINT fk_category
        FOREIGN KEY (category_id)
        REFERENCES Categories(category_id)
        ON DELETE RESTRICT
);

-- ========================
-- 6. ORDERS TABLE
-- ========================
CREATE TABLE Orders (
    order_id SERIAL PRIMARY KEY,
    customer_id INTEGER,
    store_id INTEGER NOT NULL,
    order_timestamp TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    total_amount NUMERIC(10,2) NOT NULL,

    CONSTRAINT fk_customer
        FOREIGN KEY (customer_id)
        REFERENCES Customers(customer_id)
        ON DELETE SET NULL,

    CONSTRAINT fk_store
        FOREIGN KEY (store_id)
        REFERENCES Stores(store_id)
        ON DELETE RESTRICT
);

-- ========================
-- 7. ORDER ITEMS TABLE
-- ========================
CREATE TABLE Order_Items (
    order_item_id SERIAL PRIMARY KEY,
    order_id INTEGER NOT NULL,
    item_id INTEGER NOT NULL,
    quantity INTEGER NOT NULL,
    price_at_purchase NUMERIC(10,2) NOT NULL,

    CONSTRAINT fk_order
        FOREIGN KEY (order_id)
        REFERENCES Orders(order_id)
        ON DELETE CASCADE,

    CONSTRAINT fk_menu_item
        FOREIGN KEY (item_id)
        REFERENCES Menu_Items(item_id)
        ON DELETE RESTRICT
);


TRUNCATE TABLE Order_Items RESTART IDENTITY CASCADE;
TRUNCATE TABLE Orders RESTART IDENTITY CASCADE;
TRUNCATE TABLE Customers RESTART IDENTITY CASCADE;
TRUNCATE TABLE Menu_Items RESTART IDENTITY CASCADE;
TRUNCATE TABLE Categories RESTART IDENTITY CASCADE;
TRUNCATE TABLE Ingredients RESTART IDENTITY CASCADE;
TRUNCATE TABLE Stores RESTART IDENTITY CASCADE;

SELECT * FROM Customers;






