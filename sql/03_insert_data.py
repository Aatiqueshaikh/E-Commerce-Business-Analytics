import pandas as pd
import mysql.connector

# CSV file
csv_file = r"A:\DataAnalyticsProjects\E-Commerce-Business-Analytics\data\cleaned\ecommerce_cleaned_mysql.csv"

# Read CSV
df = pd.read_csv(csv_file)

print("Rows loaded from CSV:", len(df))

# Convert date columns to MySQL-compatible format
df["Order Date"] = pd.to_datetime(df["Order Date"], format="mixed", dayfirst=True).dt.strftime("%Y-%m-%d")
df["Ship Date"] = pd.to_datetime(df["Ship Date"], format="mixed", dayfirst=True).dt.strftime("%Y-%m-%d")

# Clean currency columns
df["Sales"] = df["Sales"].replace(r"[\$,]", "", regex=True).astype(float)
df["Profit"] = df["Profit"].replace(r"[\$,]", "", regex=True).astype(float)

# Clean discount percentages
df["Discount"] = (
    df["Discount"]
    .astype(str)
    .str.replace("%", "", regex=False)
    .astype(float) / 100
)

# Connect to MySQL
connection = mysql.connector.connect(
    host="127.0.0.1",
    port=3306,
    user="root",
    password=input("Enter MySQL root password: "),
    database="ecommerce_analytics"
)

cursor = connection.cursor()

# Insert query
insert_query = """
INSERT INTO sales (
    row_id, order_id, order_date, ship_date, ship_mode,
    customer_id, customer_name, segment, country, city,
    state, postal_code, region, product_id, category,
    sub_category, product_name, sales, quantity, discount, profit
)
VALUES (
    %s, %s, %s, %s, %s,
    %s, %s, %s, %s, %s,
    %s, %s, %s, %s, %s,
    %s, %s, %s, %s, %s, %s
)
"""

# Convert rows to tuples
data = [
    tuple(None if pd.isna(value) else value for value in row)
    for row in df.itertuples(index=False, name=None)
]

# Insert data
cursor.executemany(insert_query, data)

connection.commit()

print("Rows inserted into MySQL:", cursor.rowcount)

cursor.close()
connection.close()

print("Import completed successfully.")