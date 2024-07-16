import pandas as pd
import pyodbc
from sqlalchemy import create_engine
import urllib



server = 'your_server_name'
database = 'your_database_name'
username = 'your_username'
password = 'your_password'

# Create a connection string
connection_string = f"mssql+pyodbc://{username}:{urllib.parse.quote_plus(password)}@{server}/{database}?driver=ODBC+Driver+17+for+SQL+Server"
engine = create_engine(connection_string)

# Verify the connection
try:
    with engine.connect() as connection:
        print("Connection successful!")
except Exception as e:
    print(f"Connection failed: {e}")

# Load data into SQL Server
table_name = 'Retail'
try:
    df.to_sql(table_name, engine, if_exists='append', index=False)
    print("Data loaded successfully!")
except Exception as e:
    print(f"Data load failed: {e}")
