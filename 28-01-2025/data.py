import pandas as pd
from sqlalchemy import create_engine
import urllib

# --- 1. Define your database connection details ---
server = 'localhost'  # e.g., 'localhost\SQLEXPRESS' or 'your_server.database.windows.net'
database = 'superstore_data'
username = 'sa'
password = 'sqlpassword2026!'
csv_file_path = '/Users/abinkgeo/BridgeLabz/review/review/28-01-2025/superstore_final_dataset (1) 2.csv'
table_name = 'orders_data' # The name for the new SQL table

# --- 2. Create the connection string and engine ---
# The urllib.parse.quote_plus is necessary to handle special characters in the password
quoted_password = urllib.parse.quote_plus(password)
conn_string = f'mssql+pyodbc://{username}:{quoted_password}@{server}/{database}?driver=ODBC+Driver+18+for+SQL+Server' # Use the correct driver name
engine = create_engine(conn_string)

# --- 3. Read the CSV file into a pandas DataFrame ---
df = pd.read_csv(csv_file_path)

# Optional: Perform any data cleaning or transformations on the DataFrame here
# Example: df = df.dropna()

# --- 4. Write the DataFrame to the MSSQL database ---
# 'if_exists' options: 'fail', 'replace', 'append'
df.to_sql(table_name, con=engine, index=False, if_exists='replace')

print(f"Successfully imported data from {csv_file_path} to table {table_name} in {database}")
