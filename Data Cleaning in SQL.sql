# cleaning prices 
UPDATE [Amazon].[dbo].[Laptops]
SET prices = REPLACE(prices, ',', '')

# remove currency symbol
update [Amazon].[dbo].[Laptops]
set prices =  MASTER.dbo.getCharacters(prices,'0-9 /')
where prices !=  MASTER.dbo.getCharacters(prices,'0-9 /')	

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
storage nvarchar(20),
os nvarchar(20),
color nvarchar(20),
weight nvarchar(10),
screen_resolution nvarchar(10),
screen_size nvarchar(20)

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

# updating the os column
UPDATE [Amazon].[dbo].[Laptops]
SET os = CASE
    WHEN CHARINDEX('win 10', LOWER(product_name)) > 0 THEN 'Windows 10'
    WHEN CHARINDEX('windows 10 home', LOWER(product_name)) > 0 THEN 'Windows 10 Home'
    WHEN CHARINDEX('windows 11 home', LOWER(product_name)) > 0 THEN 'Windows 11 Home'
    WHEN CHARINDEX('w11', LOWER(product_name)) > 0 THEN 'Windows 11 Home'
    WHEN CHARINDEX('windows 10', LOWER(product_name)) > 0 THEN 'Windows 10'
    WHEN CHARINDEX('win 11', LOWER(product_name)) > 0 THEN 'Windows 11'
    WHEN CHARINDEX('win11', LOWER(product_name)) > 0 THEN 'Windows 11'
    WHEN CHARINDEX('win11 home', LOWER(product_name)) > 0 THEN 'Windows 11'
    WHEN CHARINDEX('dos', LOWER(product_name)) > 0 THEN 'DOS'
    WHEN CHARINDEX('primeos', LOWER(product_name)) > 0 THEN 'Prime OS'
    WHEN CHARINDEX('windows 11', LOWER(product_name)) > 0 THEN 'Windows 11'
    WHEN CHARINDEX('chrome os', LOWER(product_name)) > 0 THEN 'Chrome OS'
    ELSE 'Windows 11'
END

# updating the storage column
Update [Amazon].[dbo].[Laptops]
set storage = CASE
        WHEN CHARINDEX('512GB', product_name) > 0 THEN '512GB SSD'
	WHEN CHARINDEX('512', product_name) > 0 THEN '512GB SSD'
	WHEN CHARINDEX('256GB', product_name) > 0 THEN '256GB SSD'
        WHEN CHARINDEX('1TB', product_name) > 0 THEN '1TB SSD'
	WHEN CHARINDEX('512 GB', product_name) > 0 THEN '512GB SSD'
        WHEN CHARINDEX('1 TB', product_name) > 0 THEN '1TB SSD'
	WHEN CHARINDEX('2TB NVMe', product_name) > 0 THEN '2TB NVMe SSD'
	WHEN CHARINDEX('128GB eMMC', product_name) > 0 THEN '128GB eMMC'
	WHEN CHARINDEX('64 GB eMMC', product_name) > 0 THEN '64GB eMMC'
	WHEN CHARINDEX('64GB eMMC', product_name) > 0 THEN '64GB eMMC'
    END
FROM 
    [Amazon].[dbo].[Laptops]
where storage is null;

# updated color column
Update [Amazon].[dbo].[Laptops]
set color = CASE
        WHEN product_name LIKE '%Mica Silver%' THEN 'Mica Silver'
        WHEN product_name LIKE '%Steel Gray%' THEN 'Steel Gray'
        WHEN product_name LIKE '%Moon White%' THEN 'Moon White'
        WHEN product_name LIKE '%Icelight Silver%' THEN 'Icelight Silver'
	WHEN product_name LIKE '%Graphite Black%' THEN 'Graphite Black'
	WHEN product_name LIKE '%Midnight Blue%' THEN 'Midnight Blue'
	WHEN product_name LIKE '%Natural Silver%' THEN 'Natural Silver'
	WHEN product_name LIKE '%Cloud Gray%' THEN 'Cloud Gray'
	WHEN product_name LIKE '%Cosmos Gray%' THEN 'Cosmos Gray'
        WHEN product_name LIKE '%Blue%' THEN 'Blue'
        WHEN product_name LIKE '%Silver%' THEN 'Silver'
        WHEN product_name LIKE '%Grey%' THEN 'Grey'
	WHEN product_name LIKE '%Gray%' THEN 'Gray'
	WHEN product_name LIKE '%White%' THEN 'White'
        WHEN product_name LIKE '%Platinum%' THEN 'Platinum'
	WHEN product_name LIKE '%Black%' THEN 'Black'
	WHEN product_name LIKE '%Graphite%' THEN 'Graphite'
        WHEN product_name LIKE '%Green%' THEN 'Green'
        ELSE 'Unknown'
    END
FROM 
    [Amazon].[dbo].[Laptops]
where color is null;

# update screen resolution column
UPDATE [Amazon].[dbo].[Laptops]
SET screen_resolution = CASE WHEN product_name LIKE '%2.8K%' THEN '2.8K'
	 WHEN product_name LIKE '%FHD OLED%' THEN 'FHD OLED'
	 WHEN product_name LIKE '%OLED%' THEN 'OLED'
         WHEN product_name LIKE '%2.5K%' THEN '2.5K'
	 WHEN product_name LIKE '%2K%' THEN '2K'
         WHEN product_name LIKE '%FHD%' THEN 'FHD'
	 WHEN product_name LIKE '%3K%' THEN '3K'
	 WHEN product_name LIKE '%UHD%' THEN 'UHD'
     ELSE 'HD'
    END
where screen_resolution is null

# update processor column
SELECT
    product_name,
    CASE
        WHEN PATINDEX('%Intel Core i[3579]%', product_name) > 0 THEN
            SUBSTRING(
                product_name,
                PATINDEX('%Intel Core i[3579]%', product_name),
                13 -- Length of "Intel Core i5"
            )
			WHEN PATINDEX('%i[3579]%', product_name) > 0 THEN
            SUBSTRING(
                product_name,
                PATINDEX('%i[3579]%', product_name),
                2 -- Length of "i5"
            )
					WHEN PATINDEX('%Intel Pentium%', product_name) > 0 THEN
            SUBSTRING(
                product_name,
                PATINDEX('%Intel Pentium%', product_name),
                13 -- Length of "i5"
            )
        WHEN PATINDEX('%Intel [0-9]+th Gen i[3579]%', product_name) > 0 THEN
            SUBSTRING(
                product_name,
                PATINDEX('%Intel [0-9]+th Gen i[3579]%', product_name),
                15 -- Length of "Intel Core i5"
            )
	    WHEN PATINDEX('%Intel Core [0-9]%', product_name) > 0 THEN
           SUBSTRING(
                product_name,
                PATINDEX('%Intel Core [0-9]%', product_name),
                12 -- Length of "Intel Core i5"
           )
			    WHEN PATINDEX('%Intel i[0-9]%', product_name) > 0 THEN
           SUBSTRING(
                product_name,
                PATINDEX('%Intel i[0-9]%', product_name),
                8 -- Length of "Intel Core i5"
           )
        WHEN PATINDEX('%Intel® Core™ i[3579]%', product_name) > 0 THEN
            SUBSTRING(
                product_name,
                PATINDEX('%Intel® Core™ i[3579]%', product_name),
                15 -- Length of "Intel®Core™ i5"
            )
        WHEN PATINDEX('%AMD Ryzen [3579]%', product_name) > 0 THEN
            SUBSTRING(
                product_name,
                PATINDEX('%AMD Ryzen [3579]%', product_name),
                10 -- Length of "AMD Ryzen 5"
            )
		WHEN PATINDEX('%Ryzen [3579]%', product_name) > 0 THEN
            SUBSTRING(
                product_name,
                PATINDEX('%Ryzen [3579]%', product_name),
                7 -- Length of "Ryzen 5"
            )
		WHEN PATINDEX('%Intel Celeron%', product_name) > 0 THEN
            SUBSTRING(
                product_name,
                PATINDEX('%Intel Celeron%', product_name),
                13 -- Length of "Ryzen 5"
            )
        WHEN PATINDEX('%MediaTek Kompanio [0-9]%', product_name) > 0 THEN
            SUBSTRING(
                product_name,
                PATINDEX('%MediaTek Kompanio [0-9]%', product_name),
                8 -- Length of "MediaTek Kompanio 520"
            )
        WHEN PATINDEX('%MediaTek MT[0-9]%', product_name) > 0 THEN
            SUBSTRING(
                product_name,
                PATINDEX('%MediaTek MT[0-9]%', product_name),
                8 -- Length of "MediaTek MT8788"
            )
        WHEN PATINDEX('%Core i[3579]%', product_name) > 0 THEN
            SUBSTRING(
                product_name,
                PATINDEX('%Core i[3579]%', product_name),
                7 -- Length of "Core i5"
            )
        ELSE 'Unknown Processor'
    END AS processor
FROM
    [Amazon].[dbo].[Laptops]
