-- 1. tbl_store
INSERT INTO tbl_store (address, city, phone_number) VALUES
('12 Allen Avenue', 'Lagos', '08012345678'),
('45 Victoria Island', 'Lagos', '08087654321'),
('78 GRA Road', 'Abuja', '07012398765');

-- 2. tbl_customers
INSERT INTO tbl_customers (first_name, last_name, email, phone_number) VALUES
('Morola', 'Oyeyemi', 'morola.oyeyemi@example.com', '08011112222'),
('Gabriel', 'Ade', 'gabriel.ade@example.com', '08033334444'),
('Kelvins', 'Smith', 'kelvins.smith@example.com', '08055556666');

-- 3. tbl_ingredients
INSERT INTO tbl_ingredients (name, stock_quantity, unit) VALUES
('Tomato', 100.00, 'kg'),
('Cheese', 50.00, 'kg'),
('Chicken', 200.00, 'kg'),
('Beef', 150.00, 'kg'),
('Onion', 80.00, 'kg');

-- 4. tbl_category
INSERT INTO tbl_category (category_name) VALUES
('Pizza'),
('Burger'),
('Pasta'),
('Salad');

-- 5. tbl_menu_items
INSERT INTO tbl_menu_items (name, category_id, size) VALUES
('Margherita Pizza', 1, 'Medium'),
('Pepperoni Pizza', 1, 'Large'),
('Cheeseburger', 2, 'Single'),
('Double Cheeseburger', 2, 'Double'),
('Spaghetti Bolognese', 3, 'Regular'),
('Caesar Salad', 4, 'Small');

-- 6. tbl_orders
INSERT INTO tbl_orders (customer_id, store_id, total_amount) VALUES
(1, 1, 2500.00),
(2, 2, 1500.50),
(3, 3, 3200.75),
(1, 2, 1800.00);


-- 1. Delete dependent tables first to avoid FK constraint errors
DELETE FROM tbl_orders;
DELETE FROM tbl_menu_items;

-- 2. Then delete tables referenced by FK
DELETE FROM tbl_customers;
DELETE FROM tbl_store;
DELETE FROM tbl_ingredients;
DELETE FROM tbl_category;

-- 3. Reset all sequences so SERIAL starts from 1
ALTER SEQUENCE tbl_store_store_id_seq RESTART WITH 1;
ALTER SEQUENCE tbl_customers_customer_id_seq RESTART WITH 1;
ALTER SEQUENCE tbl_ingredients_ingredient_id_seq RESTART WITH 1;
ALTER SEQUENCE tbl_ategory_category_id_seq RESTART WITH 1;
ALTER SEQUENCE tbl_menu_items_item_id_seq RESTART WITH 1;
ALTER SEQUENCE tbl_orders_order_id_seq RESTART WITH 1;




