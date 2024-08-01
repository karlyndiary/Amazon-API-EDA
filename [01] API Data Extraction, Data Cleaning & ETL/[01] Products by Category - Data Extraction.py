import pandas as pd
import requests

# Define the API endpoint and headers
url = "https://real-time-amazon-data.p.rapidapi.com/products-by-category"
headers = {
    "x-rapidapi-key": "API_Key",
    "x-rapidapi-host": "real-time-amazon-data.p.rapidapi.com"
}

# Function to fetch data from a given page
def fetch_data(page_number):
    querystring = {
        "category_id": "172282",
        "page": str(page_number),
        "country": "US",
        "sort_by": "RELEVANCE",
        "product_condition": "ALL"
    }
    
    # Make the API request
    response = requests.get(url, headers=headers, params=querystring)
    response_json = response.json()
    
    # Extract the products data
    products = response_json['data']['products']
    
    return products

# Number of pages to fetch
num_pages = 5
all_products = []

# Loop through the pages and fetch data
for page in range(1, num_pages + 1):
    products = fetch_data(page)
    all_products.extend(products)  # Aggregate products

# Normalize the aggregated data into a DataFrame
df = pd.json_normalize(all_products)

df.to_csv('productsbycategory.csv')

asin_list = df['asin'].tolist()
print(asin_list)
