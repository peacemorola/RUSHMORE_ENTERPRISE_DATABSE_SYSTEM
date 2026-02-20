# 🍕 RushMore Pizzeria  
## Enterprise Database System (Capstone Project)

---

## 📌 Project Overview

This project implements a **cloud-based, production-ready PostgreSQL database** for **RushMore Pizzeria**, replacing a fragile JSON-based ordering system with a scalable **Relational Database Management System (RDBMS)**.

As the assigned **Data Engineer & Database Administrator (DBA)**, the objectives were to:

- Design a **normalized relational schema (3NF)**
- Deploy PostgreSQL in the cloud (**Azure Flexible Server**)
- Populate the database with **10,000+ rows of realistic masked data**
- Demonstrate analytical capabilities using SQL queries

The final system serves as a **single source of truth** for stores, customers, menu items, and transactions.

---

# 🏗 System Architecture

Local Machine
   │
   │ (Python + psycopg2 + Faker)
   ▼
Azure PostgreSQL Flexible Server
   │
   ▼
pgAdmin (Database Management & Querying)


---

## 🧩 Components

| Component | Technology Used |
|------------|-----------------|
| **Cloud Provider** | Microsoft Azure |
| **Database Engine** | PostgreSQL 17 |
| **Database Tool** | pgAdmin 4 |
| **Programming Language** | Python 3 |

### 📦 Libraries Used

- `psycopg2-binary`
- `Faker`
- `python-dotenv`

---

# 🔐 Security Considerations

- Credentials stored in **`.env`**
- **`.env` excluded via `.gitignore`**
- SSL-encrypted database connection
- Firewall-restricted Azure access
- No real customer data used (masked with Faker)

---

# 🚀 Challenges & Solutions

| **Challenge** | **Solution** |
|---------------|--------------|
| Foreign key constraint errors | Inserted data in correct relational order |
| Phone number length errors | Standardized Faker phone format |
| Slow cloud inserts | Used transaction commit optimization |
| Preserving price history | Stored `price_per_purchase` in `Order_Items` |

---

# 🎯 Learning Outcomes

Through this project, I gained practical experience in:

- Designing **normalized relational databases (3NF)**
- Deploying PostgreSQL in the cloud
- Secure credential management
- Large-scale data population using Faker
- Writing analytical SQL queries
- Managing foreign key relationships and referential integrity

---

# 📂 Repository Structure

CAPSTONE/
│
├── create_statements.sql
├── Analysis_queries.sql
├── ERD.png
├── Azure_deployment.png
├── README.md
│
└── Python_population/
├── data_generator.py
├── connect.py
└── .env (ignored)

---

# ✅ Conclusion

This project successfully migrated RushMore Pizzeria from a static JSON system to a **scalable, cloud-hosted relational database**.

The new system now supports:

- Multi-store operations  
- Secure data storage  
- Large-scale transaction handling  
- Business analytics readiness  

The database is **production-ready** and capable of supporting future BI integrations such as:

- Power BI  
- Tableau  
- Looker Studio  

---
