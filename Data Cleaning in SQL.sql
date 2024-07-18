# cleaning prices 
UPDATE [Amazon].[dbo].[Laptops]
SET prices = REPLACE(prices, ',', '')

# remove currency symbol
update [Amazon].[dbo].[Laptops]
set prices =  MASTER.dbo.udfGetCharacters(prices,'0-9 /')
where prices !=  MASTER.dbo.udfGetCharacters(prices,'0-9 /')	

# remove duplicate price after space
update [Amazon].[dbo].[Laptops]
set prices =  LEFT(prices, CHARINDEX(' ', prices + ' ') - 1)
where prices != LEFT(prices, CHARINDEX(' ', prices + ' ') - 1)

	
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

# Add new columns 
Alter Table [Amazon].[dbo].[Laptops]
Add brand nvarchar(10),
model nvarchar(20),
processor nvarchar(20),
ram Nvarchar(10),
storage nvarchar(10),
os nvarchar(20),
color nvarchar(20),
weight nvarchar(10)

# update brand column 
UPDATE [Amazon].[dbo].[Laptops]
SET brand = CASE 
                WHEN LEFT(product_name, 1) = '(' AND CHARINDEX(')', product_name) > 0
                THEN LEFT(LTRIM(SUBSTRING(product_name, CHARINDEX(')', product_name) + 1, LEN(product_name))),
                        CHARINDEX(' ', LTRIM(SUBSTRING(product_name, CHARINDEX(')', product_name) + 1, LEN(product_name)))) - 1)
                ELSE LEFT(product_name, CHARINDEX(' ', product_name + ' ') - 1)
            END
WHERE brand IS NULL;

# update ram column
Update [Amazon].[dbo].[Laptops]
set ram = CASE
                WHEN CHARINDEX('16GB', product_name) > 0 THEN '16 GB'
                WHEN CHARINDEX('8GB', product_name) > 0 THEN '8 GB'
		WHEN CHARINDEX('16 GB', product_name) > 0 THEN '16 GB'
                WHEN CHARINDEX('8 GB', product_name) > 0 THEN '8 GB'
		WHEN CHARINDEX('64 GB', product_name) > 0 THEN '64 GB'
		WHEN CHARINDEX('32 GB', product_name) > 0 THEN '32 GB'
		WHEN CHARINDEX('32GB', product_name) > 0 THEN '32 GB'
		WHEN CHARINDEX('4GB', product_name) > 0 THEN '4 GB'
		WHEN CHARINDEX('16 DDR5', product_name) > 0 THEN '16 GB'
             END
FROM 
    [Amazon].[dbo].[Laptops]
where ram is null;

# update weight column
Update [Amazon].[dbo].[Laptops]
SET weight = CASE 
       WHEN CHARINDEX('Kg', product_name) > 0 THEN SUBSTRING(product_name, CHARINDEX('Kg', product_name) - 5, 5)
       ELSE AVG(weight)
       END
FROM [Amazon].[dbo].[Laptops]
WHERE weight is null;

# clean weight column
UPDATE [Amazon].[dbo].[Laptops] 
SET weight = REPLACE(weight , '/' ,'')

UPDATE [Amazon].[dbo].[Laptops] 
SET weight = LTRIM(RTRIM(weight));

update [Amazon].[dbo].[Laptops]
set weight = MASTER.dbo.udfGetCharacters(weight, '0123456789.')
where weight != MASTER.dbo.udfGetCharacters(weight, '0123456789.')

# Mean value for null values
DECLARE @avgWeight FLOAT;

SELECT @avgWeight = ROUND(AVG(CAST(weight AS FLOAT)), 2)
FROM [Amazon].[dbo].[Laptops]
WHERE weight IS NOT NULL;

UPDATE [Amazon].[dbo].[Laptops]
SET weight = @avgWeight
WHERE weight IS NULL;
