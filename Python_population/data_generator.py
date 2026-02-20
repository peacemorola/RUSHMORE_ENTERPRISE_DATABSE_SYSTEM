import os
import random
import psycopg2
from faker import Faker
from dotenv import load_dotenv
from decimal import Decimal

# -----------------------------------
# Load environment variables
# -----------------------------------
load_dotenv()

conn = psycopg2.connect(
    host=os.getenv("DB_HOST"),
    database=os.getenv("DB_NAME"),
    user=os.getenv("DB_USER"),
    password=os.getenv("DB_PASSWORD"),
    port=os.getenv("DB_PORT"),
    sslmode="require"
)

cursor = conn.cursor()
fake = Faker()

# -----------------------------------
# 1. INSERT STORES (3-5)
# -----------------------------------
store_ids = []
for _ in range(4):
    cursor.execute("""
        INSERT INTO Stores (address, city, phone_number)
        VALUES (%s, %s, %s)
        RETURNING store_id;
    """, (fake.address(), fake.city(), fake.unique.numerify(text='##########')))
    
    store_ids.append(cursor.fetchone()[0])

print("Stores inserted.")

# -----------------------------------
# 2. INSERT CATEGORIES
# -----------------------------------
categories = ["Pizza", "Drink", "Side", "Dessert"]
category_ids = {}

for cat in categories:
    cursor.execute("""
        INSERT INTO Categories (category_name)
        VALUES (%s)
        RETURNING category_id;
    """, (cat,))
    
    category_ids[cat] = cursor.fetchone()[0]

print("Categories inserted.")

# -----------------------------------
# 3. INSERT INGREDIENTS (40-50)
# -----------------------------------
for _ in range(45):
    cursor.execute("""
        INSERT INTO Ingredients (name, stock_quantity, unit)
        VALUES (%s, %s, %s)
        ON CONFLICT (name) DO NOTHING;
    """, (
        fake.word().capitalize(),
        round(random.uniform(10, 500), 2),
        random.choice(["kg", "liters", "units"])
    ))

print("Ingredients inserted.")

# -----------------------------------
# 4. INSERT MENU ITEMS (20-30)
# -----------------------------------
menu_items = []
for _ in range(25):
    category = random.choice(categories)
    
    cursor.execute("""
        INSERT INTO Menu_Items (name, category_id, size)
        VALUES (%s, %s, %s)
        RETURNING item_id;
    """, (
        fake.word().capitalize() + " Special",
        category_ids[category],
        random.choice(["Small", "Medium", "Large", "N/A"])
    ))
    
    menu_items.append(cursor.fetchone()[0])

print("Menu items inserted.")

# -----------------------------------
# 5. INSERT CUSTOMERS (1000+)
# -----------------------------------
customer_ids = []
for _ in range(1200):
    cursor.execute("""
        INSERT INTO Customers (first_name, last_name, email, phone_number)
        VALUES (%s, %s, %s, %s)
        RETURNING customer_id;
    """, (
        fake.first_name(),
        fake.last_name(),
        fake.unique.email(),
        fake.unique.numerify(text='##########')
    ))
    
    customer_ids.append(cursor.fetchone()[0])

print("Customers inserted.")

# -----------------------------------
# 6. INSERT ORDERS (5000+)
# -----------------------------------
order_ids = []

for _ in range(5000):
    cursor.execute("""
        INSERT INTO Orders (customer_id, store_id, order_timestamp, total_amount)
        VALUES (%s, %s, %s, %s)
        RETURNING order_id;
    """, (
        random.choice(customer_ids),
        random.choice(store_ids),
        fake.date_time_this_year(),
        Decimal("0.00")  # temporary
    ))
    
    order_ids.append(cursor.fetchone()[0])

print("Orders inserted.")

# -----------------------------------
# 7. INSERT ORDER ITEMS (~15,000+)
# -----------------------------------
for order_id in order_ids:
    total = Decimal("0.00")
    
    for _ in range(random.randint(1, 5)):
        item_id = random.choice(menu_items)
        quantity = random.randint(1, 3)
        price = Decimal(str(round(random.uniform(5, 25), 2)))
        
        cursor.execute("""
            INSERT INTO Order_Items (order_id, item_id, quantity, price_at_purchase)
            VALUES (%s, %s, %s, %s);
        """, (order_id, item_id, quantity, price))
        
        total += price * quantity
    
    cursor.execute("""
        UPDATE Orders
        SET total_amount = %s
        WHERE order_id = %s;
    """, (total, order_id))

print("Order items inserted and totals updated.")

# -----------------------------------
# Commit & Close
# -----------------------------------
conn.commit()
cursor.close()
conn.close()

print("Database population complete.")