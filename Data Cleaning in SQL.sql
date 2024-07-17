# cleaning prices 
UPDATE [Amazon].[dbo].[Laptops]
SET prices = REPLACE(REPLACE(prices, ',', ''), N'₹', '')

# remove duplicate price after currency symbol
	
	
# cleaning brackets from discount_percent

# keep the float star of the product and mean for no stars

# mean value for rating 
UPDATE [Amazon].[dbo].[Laptops]
SET rating = (
	SELECT AVG(CAST(rating AS float)) AS mean_rating -> replace float to int
	FROM [Amazon].[dbo].[Laptops]
	WHERE ISNUMERIC(rating) = 1)
WHERE rating = 'no data'

# replace no data in device setup to no device setup option available
