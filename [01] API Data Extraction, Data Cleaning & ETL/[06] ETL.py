import pandas as pd
import pyodbc
from sqlalchemy import create_engine
import urllib

# Products Table ETL
pbc = pd.read_csv(r'C:\Users\KAREN J FERNANDES\anaconda3\Files\Projects\API\cleaned_pbc_dataset.csv')
# drop Unnamed: 0 column
pbc.drop(columns=['Unnamed: 0'], inplace=True)

server = 'localhost'
database = 'Amazon'
username = 'your_username'
password = 'your_password'

# Create a connection string
connection_string = f"mssql+pyodbc://{username}:{urllib.parse.quote_plus(password)}@{server}/{database}?driver=ODBC+Driver+17+for+SQL+Server"
engine = create_engine(connection_string)

try:
    with engine.connect() as connection:
        print("Connection successful!")
except Exception as e:
    print(f"Connection failed: {e}")

table_name = 'Products'
try:
    df.to_sql(table_name, engine, if_exists='append', index=False)
    print("Data loaded successfully!")
except Exception as e:
    print(f"Data load failed: {e}")

# Reviews Table ETL
reviews = pd.read_csv(r'C:\Users\KAREN J FERNANDES\anaconda3\Files\Projects\API\cleaned_reviews_dataset.csv')
# drop Unnamed: 0 column
reviews.drop(columns=['Unnamed: 0'], inplace=True)

server = 'localhost'
database = 'Amazon'
username = 'your_username'
password = 'your_password'

# Create a connection string
connection_string = f"mssql+pyodbc://{username}:{urllib.parse.quote_plus(password)}@{server}/{database}?driver=ODBC+Driver+17+for+SQL+Server"
engine = create_engine(connection_string)

try:
    with engine.connect() as connection:
        print("Connection successful!")
except Exception as e:
    print(f"Connection failed: {e}")

table_name = 'Reviews'
try:
    df.to_sql(table_name, engine, if_exists='append', index=False)
    print("Data loaded successfully!")
except Exception as e:
    print(f"Data load failed: {e}")
