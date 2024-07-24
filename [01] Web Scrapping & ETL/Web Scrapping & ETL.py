import pandas as pd
import pyodbc
from sqlalchemy import create_engine
import urllib
import requests
from bs4 import BeautifulSoup
import time

HEADERS = ({'User-Agent':'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/122.0.0.0 Safari/537.36', 'Accept-Language': 'en-US, en;q=0.5'})

titles = []
prices = []
discount_percent = []
stars = []
rating = []
total_purchased = []
deal = []
device_setup = []

for i in range(1, 60):  # Loop through pages
    url = f"https://www.amazon.in/s?k=laptop&page={i}&crid=1UZ5CBGVB07U6&qid=1721162014&sprefix=laptop%2Caps%2C309&ref=sr_pg_{i}"
    
    # HTTP request
    r = requests.get(url, headers=HEADERS)
    
    # Soup object containing all data
    soup = BeautifulSoup(r.text, "html.parser")
    
    # Find all product boxes
    boxes = soup.find_all("div", attrs={"data-component-type": "s-search-result"})
    
    for box in boxes:
        # Function to return product title
        def get_title(box):
            try:
                title = box.h2.a.text.strip()
            except AttributeError:
                title = "No title found"
            return title
        
        # Function to return product price
        def get_price(box):
            try:
                price = box.find("span", "a-price").text
            except AttributeError:
                price = "No price found"
            return price

        # Function to return discount percent
        def get_discount_percent(box):
            try:
                discount_percent = box.find("span", text=lambda x: x and 'off' in x).text
            except AttributeError:
                discount_percent = "No discount found"
            return discount_percent
        
        # Function to return product rating
        def get_stars(box):
            try:
                stars = box.find("span", "a-icon-alt").text
            except AttributeError:
                stars = "No rating"
            return stars

        # Function to return rating
        def get_rating(box):
            try:
                rating = box.find("span", attrs={"class": "a-size-base s-underline-text"}).text
            except AttributeError:
                rating = "No data"
            return rating
            
        # Function to return total number of purchases
        def get_total_purchased(box):
            try:
                total_purchased = box.find("div", attrs={"class": "a-row a-size-base"}).find("span", attrs={"class": "a-size-base a-color-secondary"}).text
            except AttributeError:
                total_purchased = "No data"
            return total_purchased

        # Function to return deal
        def get_deal(box):
            try:
                deal = box.find("span", attrs={"class": "a-truncate-full"}).text
            except AttributeError:
                deal = "No data"
            return deal

        # Function to return delivery type
        def get_device_setup(box):
            try:
                device_setup = box.find("div", attrs={"class": "a-section a-spacing-none a-spacing-top-mini"}).find("div", attrs={"class": "a-row a-size-base a-color-secondary"}).text.strip()
            except AttributeError:
                device_setup = "No data"
            return device_setup
        
        # Append data to respective lists
        titles.append(get_title(box))
        prices.append(get_price(box))
        discount_percent.append(get_discount_percent(box))
        stars.append(get_stars(box))
        rating.append(get_rating(box))
        total_purchased.append(get_total_purchased(box))
        deal.append(get_deal(box))
        device_setup.append(get_device_setup(box))
    
    # Respectful delay between requests
    time.sleep(2)

# Creating DataFrame and saving to CSV
df = pd.DataFrame({
    "product_name": titles,
    "prices": prices,
    "discount_percent": discount_percent,
    "stars": stars,
    "rating": rating,
    "total_purchased": total_purchased,
    "deal": deal,
    "device_setup": device_setup
})

df.to_csv("amazon_products_dataset.csv", index=False)

server = 'localhost'
database = 'Amazon'
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
table_name = 'Laptops'
try:
    df.to_sql(table_name, engine, if_exists='append', index=False)
    print("Data loaded successfully!")
except Exception as e:
    print(f"Data load failed: {e}")
