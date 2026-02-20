--================================--
--Total Revenue Per Store--
--================================--
SELECT s.store_id,
       s.city,
       SUM(o.total_amount) AS total_revenue
FROM Orders o
JOIN Stores s ON o.store_id = s.store_id
GROUP BY s.store_id, s.city
ORDER BY total_revenue DESC;

--================================--
--Total 10 Customers--
--================================--
SELECT c.customer_id,
       c.first_name,
       c.last_name,
       SUM(o.total_amount) AS total_spent
FROM Customers c
JOIN Orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_id
ORDER BY total_spent DESC
LIMIT 10;


--================================--
--Most Popular Menu Item--
--================================--
SELECT m.name,
       SUM(oi.quantity) AS total_sold
FROM Order_Items oi
JOIN Menu_Items m ON oi.item_id = m.item_id
GROUP BY m.name
ORDER BY total_sold DESC
LIMIT 1;

--================================--
--Average Order Value--
--================================--
SELECT AVG(total_amount) AS average_order_value
FROM Orders;


--================================--
--Busiest Hour--
--================================--
SELECT 
    TO_CHAR(order_timestamp, 'HH24:00') AS busy_hour,
    COUNT(*) AS total_orders
FROM Orders
GROUP BY busy_hour
ORDER BY total_orders DESC;




