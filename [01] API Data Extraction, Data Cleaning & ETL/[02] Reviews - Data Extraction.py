import pandas as pd
import requests

# Define the API endpoint and headers
url = "https://real-time-amazon-data.p.rapidapi.com/product-reviews"
headers = {
	"x-rapidapi-key": "API_Key",
	"x-rapidapi-host": "real-time-amazon-data.p.rapidapi.com"
}

# Function to fetch data from a given page
def fetch_data(asin):
    querystring = {
        "asin": asin,
        "country":"US",
        "sort_by":"TOP_REVIEWS",
        "star_rating":"ALL",
        "verified_purchases_only":"false",
        "images_or_videos_only":"false",
        "current_format_only":"false"
    }
    
    # Make the API request
    response = requests.get(url, headers=headers, params=querystring)
    response_json = response.json()
    print(response_json)

    # Extract the products data
    reviews = response_json.get('data', {}).get('reviews', [])
    
    return reviews

asin_list = ['B0D9H39JL7', 'B0D7VRMJ9Y', 'B0D6NKMVMP', 'B0D7Q55LT3', 'B0D9JXR3BH', 'B0D923QDHR', 'B0D4WGL353', 'B0D5QNFDHZ',
       'B0D9JMXV2B', 'B0D583XV3S', 'B0D7MNMYR2', 'B0D96RHR3Q', 'B0D6XGQLW7', 'B0D8ZMW78F', 'B0D86YVG7V', 'B0D7LDQ7FR',
       'B0D91TG15T', 'B0D7ZVWR45', 'B0D6L4FTC1', 'B0D5YRWLBY', 'B0D6QW69HC', 'B0D8HMMSS6', 'B0D62VMQ4G', 'B0D7W3R7T9',
       'B0D8KP5X67', 'B0D676BXDV', 'B0D6J5B98H', 'B0D812Z2T1', 'B0D7QFKJK8', 'B0D9B48CBX', 'B0D87CHFQ3', 'B0D49C85V3',
       'B0D6WGQQKP', 'B0D72WK9H7', 'B0D6YVTNFG', 'B0D5XD947V', 'B0D5YR7HKF', 'B0D62GGXJC', 'B0D6GBDJND', 'B0D7PBHSZY',
       'B0D72SDCQ1', 'B0D4JM4QPG', 'B0D7L5VGNS', 'B0D78RPTT7', 'B0D929CSBT', 'B0D69465BY', 'B0D7LN7FP9', 'B0D635YLCT',
       'B0D6B2MJBP', 'B0D6357YDP', 'B0D6QPW32F', 'B0D5XSTWNT', 'B0D8K27YHS', 'B0D92ZXFMJ', 'B0D95GBQGQ', 'B0D6QS3B34',
       'B0D7Q4S11G', 'B0D77SHSB7', 'B0D72TNXSC', 'B0D9NJHCKF', 'B0D78H29R8', 'B0D9MJXGL2', 'B0D9GZCPMJ', 'B0D8J5W2CJ',
       'B0D7367688', 'B0D739N97N', 'B0D4XZWYZ5', 'B0D92B5783', 'B0D9H7ZHW6', 'B0D5DPFTPB', 'B0D4QCRS7S', 'B0D7MPTDH1',
       'B0D99QQ7JL', 'B0D7LYYWG8', 'B0D74N1YNK', 'B0D73DHHV5', 'B0D45WN7G9', 'B0D9F79XRT', 'B0D8FQHGR7', 'B0D4QV56KG',
       'B0D66QZQ2Y', 'B0D69969V1', 'B0D87G5RYW', 'B0D5Z333HL', 'B0D8DJ6T8V', 'B0D97F6FP6', 'B0D9238TCL', 'B0D5CRMNMG',
       'B0D95JGW5V', 'B0D7ZQ1ZLF', 'B0D73N1WKT', 'B0D7LT84FG', 'B0D9QJ7SWZ', 'B0D5YH77VF', 'B0D626HRLD', 'B0D62CPFYZ',
       'B0D7M5DLSW', 'B0D5YMWWSX', 'B0D86QG8NJ', 'B0D343FLYZ', 'B0D5VK53LB', 'B0D4Z8DDYB', 'B0D92D7PTM', 'B0D948J9D3',
       'B0D49HKPMG', 'B0D69L9SJV', 'B0D5XX22X2', 'B0D86PLHMK', 'B0D7ZY98B5', 'B0D83G11V2', 'B0D93K9QKN', 'B0D4Y72BCS',
       'B0D5DLF39S', 'B0D4DTYYC5', 'B0D86V1MZM', 'B0D7HMDT3Q', 'B0D6C2MF57', 'B0D9H9FSL6', 'B0D4QGD3LB', 'B0D9F7PZ4N',
       'B0D7ZQFVFD', 'B0D5RHRD2D']
all_reviews = []

# Loop through the pages and fetch data
for asin in asin_list:
    reviews = fetch_data(asin)
    all_reviews.extend(reviews)  # Aggregate products

# Normalize the aggregated data into a DataFrame
df = pd.json_normalize(all_reviews)

df.to_csv("reviews.csv")
