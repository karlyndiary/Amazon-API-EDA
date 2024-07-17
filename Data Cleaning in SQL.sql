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

# trim whitespace and replace with 0
UPDATE [Amazon].[dbo].[Laptops]
SET stars = CASE
               WHEN LTRIM(RTRIM(stars)) = '' THEN '0'
               ELSE LTRIM(RTRIM(stars))
            END
WHERE stars IS NOT NULL;

# mean for null stars
UPDATE [Amazon].[dbo].[Laptops]
SET stars = CASE
              WHEN stars = '0' THEN CAST(
                  (
                      SELECT ROUND(AVG(CAST(stars AS FLOAT)),1)
                      FROM [Amazon].[dbo].[Laptops]
                      WHERE ISNUMERIC(stars) = 1
                  ) AS NVARCHAR(10)) 
              ELSE stars
           END
WHERE stars IS NOT NULL;

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
		END
	WHERE device_setup IN ('no data', 'Service: Device Setup');
