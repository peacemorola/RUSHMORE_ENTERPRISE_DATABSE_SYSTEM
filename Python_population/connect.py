import psycopg2
from dotenv import load_dotenv
import os
from pathlib import Path

env_path = Path(__file__).parent / ".env"
print("ENV FILE EXISTS:", env_path.exists())  # <--- add this line

load_dotenv(dotenv_path=env_path)

print("Loaded password:", os.getenv("DB_PASSWORD"))  # Debug line
print("DB_HOST:", os.getenv("DB_HOST"))
print("DB_USER:", os.getenv("DB_USER"))

conn = psycopg2.connect(
    host=os.getenv("DB_HOST"),
    port=os.getenv("DB_PORT"),
    dbname=os.getenv("DB_NAME"),
    user=os.getenv("DB_USER"),
    password=os.getenv("DB_PASSWORD"),
    sslmode='require'
)

print("Connected to PostgreSQL!")
conn.close()
