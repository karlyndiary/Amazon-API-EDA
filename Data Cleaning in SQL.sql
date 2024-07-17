# cleaning prices 
UPDATE [Amazon].[dbo].[Laptops]
SET prices = REPLACE(REPLACE(prices, ',', ''), N'₹', '')

# remove duplicate price after currency symbol
	
	
# cleaning brackets from discount_percent
UPDATE [Amazon].[dbo].[Laptops]
SET discount_percent = REPLACE(REPLACE(discount_percent,'(', ''),')','')
	
# keep the float value of the star 
UPDATE [Amazon].[dbo].[Laptops]
SET stars = REPLACE(stars, RIGHT(stars, 15), '' )

# mean for null stars
	
# mean value for rating 
UPDATE [Amazon].[dbo].[Laptops]
SET rating = (
	SELECT AVG(CAST(rating AS float)) AS mean_rating -> replace float to int
	FROM [Amazon].[dbo].[Laptops]
	WHERE ISNUMERIC(rating) = 1)
WHERE rating = 'no data'

# replace no data in device setup to no device setup option available
UPDATE [Amazon].[dbo].[Laptops]
SET device_setup = Case when device_setup = 'no data' Then 'No Device Setup Available'
				Else 'Device Setup Available'
			end
		where device_setup IN ('no data', 'Service: Device Setup');

UPDATE [Amazon].[dbo].[Laptops]
SET device_setup = Case when device_setup = 'No device setup available' Then 'No Device Setup Available'
				Else 'Device Setup Available'
			end
		where device_setup IN ('No device setup available', 'Service: Device Setup');
