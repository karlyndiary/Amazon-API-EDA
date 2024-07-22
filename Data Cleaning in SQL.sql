# cleaning product_name column
UPDATE [Amazon].[dbo].[Laptops]
SET product_name = REPLACE(REPLACE(product_name, '®', ' '),'™','')

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
screen_size nvarchar(20),
condition nvarchar(15)

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
Update [Amazon].[dbo].[Laptops]
Set processor = CASE
		WHEN PATINDEX('%AMD Ryzen [3579]%', product_name) > 0 THEN
            SUBSTRING(
                product_name,
                PATINDEX('%AMD Ryzen [3579]%', product_name),
                11 -- Length of "AMD Ryzen 5"
            )
       WHEN PATINDEX('%Ryzen [3579]%', product_name) > 0 THEN
            SUBSTRING(
                product_name,
                PATINDEX('%Ryzen [3579]%', product_name),
                7 -- Length of "Ryzen 5"
            )
      WHEN PATINDEX('%Intel Core i[3579]%', product_name) > 0 THEN
            SUBSTRING(
                product_name,
                PATINDEX('%Intel Core i[3579]%', product_name),
                13 -- Length of "Intel Core i5"
            )
     WHEN PATINDEX('%Intel Core I[3579]%', product_name) > 0 THEN
            SUBSTRING(
                product_name,
                PATINDEX('%Intel Core I[3579]%', product_name),
                13 -- Length of "Intel Core I5"
            )
	      WHEN PATINDEX('%Intel Core [3579]%', product_name) > 0 THEN
            SUBSTRING(
                product_name,
                PATINDEX('%Intel Core [3579]%', product_name),
                12 -- Length of "Intel Core 5"
            )
     WHEN PATINDEX('%Celeron%', product_name) > 0 THEN
            SUBSTRING(
                product_name,
                PATINDEX('%Celeron%', product_name),
                7 -- Length of "Celeron"
            )
     WHEN PATINDEX('%Intel Celeron%', product_name) > 0 THEN
            SUBSTRING(
                product_name,
                PATINDEX('%Intel Celeron%', product_name),
                13 -- Length of "Intel Celeron"
            )
     WHEN PATINDEX('%Intel Core Ultra [3579]%', product_name) > 0 THEN
            SUBSTRING(
                product_name,
                PATINDEX('%Intel Core Ultra [3579]%', product_name),
                18 -- Length of "Intel Core Ultra 5"
            )
     WHEN PATINDEX('%AMD RYZEN AI Powered [3579]%', product_name) > 0 THEN
            SUBSTRING(
                product_name,
                PATINDEX('%AMD RYZEN AI Powered [3579]%', product_name),
                22 -- Length of "AMD RYZEN AI Powered 5"
            )
     WHEN PATINDEX('%Intel Pentium%', product_name) > 0 THEN
            SUBSTRING(
                product_name,
                PATINDEX('%Intel Pentium%', product_name),
                13 -- Length of "Intel Pentium"
            )
	WHEN PATINDEX('%i[3579]%', product_name) > 0 THEN
            SUBSTRING(
                product_name,
                PATINDEX('%i[3579]%', product_name),
                2 -- Length of "i5"
            )
     WHEN PATINDEX('%I[3579]%', product_name) > 0 THEN
            SUBSTRING(
                product_name,
                PATINDEX('%I[3579]%', product_name),
                2 -- Length of "I5"
            )
	     WHEN PATINDEX('%MediaTek%', product_name) > 0 THEN
            SUBSTRING(
                product_name,
                PATINDEX('%MediaTek%', product_name),
                8 -- Length of "MediaTek"
            )
    END
Where processor is null

# Cleaning processor column 
update Amazon.dbo.Laptops
set processor = case 
	when processor like '%i3%' then 'Intel Core i3' 
	when processor like '%i5%' then 'Intel Core i5' 
	when processor like '%i7%' then 'Intel Core i7' 
	when processor like '%i9%' then 'Intel Core i9' 
	when processor like '%Celeron%' then 'Intel Celeron' 
	when processor like '%Ryzen 3%' then 'AMD Ryzen 3' 
	when processor like '%Ryzen 5%' then 'AMD Ryzen 5' 
	when processor like '%AMD RYZEN AI Powered 7%' then 'AMD Ryzen AI Powered 7' 
	else processor
end

# Update condition column
Update [Amazon].[dbo].[Laptops]
SET condition = CASE WHEN CHARINDEX('(Refurbished)', product_name) > 0 THEN 'Refurbished'
	 ELSE 'New'
 END
where condition is null

# update model name column
Update [Amazon].[dbo].[Laptops]
SET model = CASE
        -- Check if the product_name contains a comma, hyphen, keywords "Intel", "AMD", "Ryzen", "15.6 inch", "15.6"", "Core i" or patterns like "12th Gen"
        WHEN CHARINDEX(',', product_name) > 0
             OR CHARINDEX('-', product_name) > 0
             OR PATINDEX('%Intel%', product_name) > 0
             OR PATINDEX('%AMD%', product_name) > 0
             OR PATINDEX('%Ryzen%', product_name) > 0
             OR PATINDEX('%[0-9]th Gen%', product_name) > 0
             OR PATINDEX('%15.6 inch%', product_name) > 0
             OR PATINDEX('%15.6"%', product_name) > 0
             OR PATINDEX('%Core i[0-9]%', product_name) > 0
			 OR PATINDEX('%Full%', product_name) > 0
        THEN
            -- Determine the end position based on the first occurrence of the specified patterns
            SUBSTRING(
                product_name,
                1,
                CASE
                    WHEN CHARINDEX(',', product_name) > 0
                         AND (CHARINDEX('-', product_name) = 0
                              OR CHARINDEX(',', product_name) < CHARINDEX('-', product_name))
                         AND (PATINDEX('%Intel%', product_name) = 0
                              OR CHARINDEX(',', product_name) < PATINDEX('%Intel%', product_name))
                         AND (PATINDEX('%AMD%', product_name) = 0
                              OR CHARINDEX(',', product_name) < PATINDEX('%AMD%', product_name))
                         AND (PATINDEX('%Ryzen%', product_name) = 0
                              OR CHARINDEX(',', product_name) < PATINDEX('%Ryzen%', product_name))
                         AND (PATINDEX('%[0-9]th Gen%', product_name) = 0
                              OR CHARINDEX(',', product_name) < PATINDEX('%[0-9]th Gen%', product_name))
                         AND (PATINDEX('%15.6 inch%', product_name) = 0
                              OR CHARINDEX(',', product_name) < PATINDEX('%15.6 inch%', product_name))
                         AND (PATINDEX('%15.6"%', product_name) = 0
                              OR CHARINDEX(',', product_name) < PATINDEX('%15.6"%', product_name))
                         AND (PATINDEX('%Core i[0-9]%', product_name) = 0
                              OR CHARINDEX(',', product_name) < PATINDEX('%Core i[0-9]%', product_name))
                         AND (PATINDEX('%Full%', product_name) = 0
                              OR CHARINDEX(',', product_name) < PATINDEX('%Full%', product_name))
                    THEN CHARINDEX(',', product_name) - 1

                    WHEN CHARINDEX('-', product_name) > 0
                         AND (CHARINDEX(',', product_name) = 0
                              OR CHARINDEX('-', product_name) < CHARINDEX(',', product_name))
                         AND (PATINDEX('%Intel%', product_name) = 0
                              OR CHARINDEX('-', product_name) < PATINDEX('%Intel%', product_name))
                         AND (PATINDEX('%AMD%', product_name) = 0
                              OR CHARINDEX('-', product_name) < PATINDEX('%AMD%', product_name))
                         AND (PATINDEX('%Ryzen%', product_name) = 0
                              OR CHARINDEX('-', product_name) < PATINDEX('%Ryzen%', product_name))
                         AND (PATINDEX('%[0-9]th Gen%', product_name) = 0
                              OR CHARINDEX('-', product_name) < PATINDEX('%[0-9]th Gen%', product_name))
                         AND (PATINDEX('%15.6 inch%', product_name) = 0
                              OR CHARINDEX('-', product_name) < PATINDEX('%15.6 inch%', product_name))
                         AND (PATINDEX('%15.6"%', product_name) = 0
                              OR CHARINDEX('-', product_name) < PATINDEX('%15.6"%', product_name))
                         AND (PATINDEX('%Core i[0-9]%', product_name) = 0
                              OR CHARINDEX('-', product_name) < PATINDEX('%Core i[0-9]%', product_name))
                         AND (PATINDEX('%Full%', product_name) = 0
                              OR CHARINDEX('-', product_name) < PATINDEX('%Full%', product_name))
                    THEN CHARINDEX('-', product_name) - 1

                    WHEN PATINDEX('%Intel%', product_name) > 0
                         AND (CHARINDEX(',', product_name) = 0
                              OR PATINDEX('%Intel%', product_name) < CHARINDEX(',', product_name))
                         AND (CHARINDEX('-', product_name) = 0
                              OR PATINDEX('%Intel%', product_name) < CHARINDEX('-', product_name))
                         AND (PATINDEX('%AMD%', product_name) = 0
                              OR PATINDEX('%Intel%', product_name) < PATINDEX('%AMD%', product_name))
                         AND (PATINDEX('%Ryzen%', product_name) = 0
                              OR PATINDEX('%Intel%', product_name) < PATINDEX('%Ryzen%', product_name))
                         AND (PATINDEX('%[0-9]th Gen%', product_name) = 0
                              OR PATINDEX('%Intel%', product_name) < PATINDEX('%[0-9]th Gen%', product_name))
                         AND (PATINDEX('%15.6 inch%', product_name) = 0
                              OR PATINDEX('%Intel%', product_name) < PATINDEX('%15.6 inch%', product_name))
                         AND (PATINDEX('%15.6"%', product_name) = 0
                              OR PATINDEX('%Intel%', product_name) < PATINDEX('%15.6"%', product_name))
                         AND (PATINDEX('%Core i[0-9]%', product_name) = 0
                              OR PATINDEX('%Intel%', product_name) < PATINDEX('%Core i[0-9]%', product_name))
                         AND (PATINDEX('%Full%', product_name) = 0
                              OR PATINDEX('%Intel%', product_name) < PATINDEX('%Full%', product_name))
                    THEN PATINDEX('%Intel%', product_name) - 1

                    WHEN PATINDEX('%AMD%', product_name) > 0
                         AND (CHARINDEX(',', product_name) = 0
                              OR PATINDEX('%AMD%', product_name) < CHARINDEX(',', product_name))
                         AND (CHARINDEX('-', product_name) = 0
                              OR PATINDEX('%AMD%', product_name) < CHARINDEX('-', product_name))
                         AND (PATINDEX('%Intel%', product_name) = 0
                              OR PATINDEX('%AMD%', product_name) < PATINDEX('%Intel%', product_name))
                         AND (PATINDEX('%Ryzen%', product_name) = 0
                              OR PATINDEX('%AMD%', product_name) < PATINDEX('%Ryzen%', product_name))
                         AND (PATINDEX('%[0-9]th Gen%', product_name) = 0
                              OR PATINDEX('%AMD%', product_name) < PATINDEX('%[0-9]th Gen%', product_name))
                         AND (PATINDEX('%15.6 inch%', product_name) = 0
                              OR PATINDEX('%AMD%', product_name) < PATINDEX('%15.6 inch%', product_name))
                         AND (PATINDEX('%15.6"%', product_name) = 0
                              OR PATINDEX('%AMD%', product_name) < PATINDEX('%15.6"%', product_name))
                         AND (PATINDEX('%Core i[0-9]%', product_name) = 0
                              OR PATINDEX('%AMD%', product_name) < PATINDEX('%Core i[0-9]%', product_name))
						 AND (PATINDEX('%Full%', product_name) = 0
                              OR PATINDEX('%AMD%', product_name) < PATINDEX('%Full%', product_name))
                    THEN PATINDEX('%AMD%', product_name) - 1

                    WHEN PATINDEX('%Ryzen%', product_name) > 0
                         AND (CHARINDEX(',', product_name) = 0
                              OR PATINDEX('%Ryzen%', product_name) < CHARINDEX(',', product_name))
                         AND (CHARINDEX('-', product_name) = 0
                              OR PATINDEX('%Ryzen%', product_name) < CHARINDEX('-', product_name))
                         AND (PATINDEX('%Intel%', product_name) = 0
                              OR PATINDEX('%Ryzen%', product_name) < PATINDEX('%Intel%', product_name))
                         AND (PATINDEX('%AMD%', product_name) = 0
                              OR PATINDEX('%Ryzen%', product_name) < PATINDEX('%AMD%', product_name))
                         AND (PATINDEX('%[0-9]th Gen%', product_name) = 0
                              OR PATINDEX('%Ryzen%', product_name) < PATINDEX('%[0-9]th Gen%', product_name))
                         AND (PATINDEX('%15.6 inch%', product_name) = 0
                              OR PATINDEX('%Ryzen%', product_name) < PATINDEX('%15.6 inch%', product_name))
                         AND (PATINDEX('%15.6"%', product_name) = 0
                              OR PATINDEX('%Ryzen%', product_name) < PATINDEX('%15.6"%', product_name))
                         AND (PATINDEX('%Core i[0-9]%', product_name) = 0
                              OR PATINDEX('%Ryzen%', product_name) < PATINDEX('%Core i[0-9]%', product_name))
						 AND (PATINDEX('%Full%', product_name) = 0
                              OR PATINDEX('%Ryzen%', product_name) < PATINDEX('%Full%', product_name))
                    THEN PATINDEX('%Ryzen%', product_name) - 1

                    WHEN PATINDEX('%[0-9]th Gen%', product_name) > 0
                         AND (CHARINDEX(',', product_name) = 0
                              OR PATINDEX('%[0-9]th Gen%', product_name) < CHARINDEX(',', product_name))
                         AND (CHARINDEX('-', product_name) = 0
                              OR PATINDEX('%[0-9]th Gen%', product_name) < CHARINDEX('-', product_name))
                         AND (PATINDEX('%Intel%', product_name) = 0
                              OR PATINDEX('%[0-9]th Gen%', product_name) < PATINDEX('%Intel%', product_name))
                         AND (PATINDEX('%AMD%', product_name) = 0
                              OR PATINDEX('%[0-9]th Gen%', product_name) < PATINDEX('%AMD%', product_name))
                         AND (PATINDEX('%Ryzen%', product_name) = 0
                              OR PATINDEX('%[0-9]th Gen%', product_name) < PATINDEX('%Ryzen%', product_name))
                         AND (PATINDEX('%15.6 inch%', product_name) = 0
                              OR PATINDEX('%[0-9]th Gen%', product_name) < PATINDEX('%15.6 inch%', product_name))
                         AND (PATINDEX('%15.6"%', product_name) = 0
                              OR PATINDEX('%[0-9]th Gen%', product_name) < PATINDEX('%15.6"%', product_name))
                         AND (PATINDEX('%Core i[0-9]%', product_name) = 0
                              OR PATINDEX('%[0-9]th Gen%', product_name) < PATINDEX('%Core i[0-9]%', product_name))
                         AND (PATINDEX('%Full%', product_name) = 0
                              OR PATINDEX('%[0-9]th Gen%', product_name) < PATINDEX('%Full%', product_name))
                    THEN PATINDEX('%[0-9]th Gen%', product_name) - 1

                    WHEN PATINDEX('%15.6 inch%', product_name) > 0
                         AND (CHARINDEX(',', product_name) = 0
                              OR PATINDEX('%15.6 inch%', product_name) < CHARINDEX(',', product_name))
                         AND (CHARINDEX('-', product_name) = 0
                              OR PATINDEX('%15.6 inch%', product_name) < CHARINDEX('-', product_name))
                         AND (PATINDEX('%Intel%', product_name) = 0
                              OR PATINDEX('%15.6 inch%', product_name) < PATINDEX('%Intel%', product_name))
                         AND (PATINDEX('%AMD%', product_name) = 0
                              OR PATINDEX('%15.6 inch%', product_name) < PATINDEX('%AMD%', product_name))
                         AND (PATINDEX('%Ryzen%', product_name) = 0
                              OR PATINDEX('%15.6 inch%', product_name) < PATINDEX('%Ryzen%', product_name))
                         AND (PATINDEX('%[0-9]th Gen%', product_name) = 0
                              OR PATINDEX('%15.6 inch%', product_name) < PATINDEX('%[0-9]th Gen%', product_name))
                         AND (PATINDEX('%15.6"%', product_name) = 0
                              OR PATINDEX('%15.6 inch%', product_name) < PATINDEX('%15.6"%', product_name))
                         AND (PATINDEX('%Core i[0-9]%', product_name) = 0
                              OR PATINDEX('%15.6 inch%', product_name) < PATINDEX('%Core i[0-9]%', product_name))
                         AND (PATINDEX('%Full%', product_name) = 0
                              OR PATINDEX('%15.6 inch%', product_name) < PATINDEX('%Full%', product_name))
                    THEN PATINDEX('%15.6 inch%', product_name) - 1

                    WHEN PATINDEX('%15.6"%', product_name) > 0
                         AND (CHARINDEX(',', product_name) = 0
                              OR PATINDEX('%15.6"%', product_name) < CHARINDEX(',', product_name))
                         AND (CHARINDEX('-', product_name) = 0
                              OR PATINDEX('%15.6"%', product_name) < CHARINDEX('-', product_name))
                         AND (PATINDEX('%Intel%', product_name) = 0
                              OR PATINDEX('%15.6"%', product_name) < PATINDEX('%Intel%', product_name))
                         AND (PATINDEX('%AMD%', product_name) = 0
                              OR PATINDEX('%15.6"%', product_name) < PATINDEX('%AMD%', product_name))
                         AND (PATINDEX('%Ryzen%', product_name) = 0
                              OR PATINDEX('%15.6"%', product_name) < PATINDEX('%Ryzen%', product_name))
                         AND (PATINDEX('%[0-9]th Gen%', product_name) = 0
                              OR PATINDEX('%15.6"%', product_name) < PATINDEX('%[0-9]th Gen%', product_name))
                         AND (PATINDEX('%15.6 inch%', product_name) = 0
                              OR PATINDEX('%15.6"%', product_name) < PATINDEX('%15.6 inch%', product_name))
                         AND (PATINDEX('%Core i[0-9]%', product_name) = 0
                              OR PATINDEX('%15.6"%', product_name) < PATINDEX('%Core i[0-9]%', product_name))
                         AND (PATINDEX('%Full%', product_name) = 0
                              OR PATINDEX('%15.6"%', product_name) < PATINDEX('%Full%', product_name))
					THEN PATINDEX('%15.6"%', product_name) - 1

                    WHEN PATINDEX('%Core i[0-9]%', product_name) > 0
                         AND (CHARINDEX(',', product_name) = 0
                              OR PATINDEX('%Core i[0-9]%', product_name) < CHARINDEX(',', product_name))
                         AND (CHARINDEX('-', product_name) = 0
                              OR PATINDEX('%Core i[0-9]%', product_name) < CHARINDEX('-', product_name))
                         AND (PATINDEX('%Intel%', product_name) = 0
                              OR PATINDEX('%Core i[0-9]%', product_name) < PATINDEX('%Intel%', product_name))
                         AND (PATINDEX('%AMD%', product_name) = 0
                              OR PATINDEX('%Core i[0-9]%', product_name) < PATINDEX('%AMD%', product_name))
                         AND (PATINDEX('%Ryzen%', product_name) = 0
                              OR PATINDEX('%Core i[0-9]%', product_name) < PATINDEX('%Ryzen%', product_name))
                         AND (PATINDEX('%[0-9]th Gen%', product_name) = 0
                              OR PATINDEX('%Core i[0-9]%', product_name) < PATINDEX('%[0-9]th Gen%', product_name))
                         AND (PATINDEX('%15.6 inch%', product_name) = 0
                              OR PATINDEX('%Core i[0-9]%', product_name) < PATINDEX('%15.6 inch%', product_name))
                         AND (PATINDEX('%15.6"%', product_name) = 0
                              OR PATINDEX('%Core i[0-9]%', product_name) < PATINDEX('%15.6"%', product_name))
					     AND (PATINDEX('%Full%', product_name) = 0
                              OR PATINDEX('%Core i[0-9]%', product_name) < PATINDEX('%Full%', product_name))
                    THEN PATINDEX('%Core i[0-9]%', product_name) - 1

					WHEN PATINDEX('%Full%', product_name) > 0
                         AND (CHARINDEX(',', product_name) = 0
                              OR PATINDEX('%Full%', product_name) < CHARINDEX(',', product_name))
                         AND (CHARINDEX('-', product_name) = 0
                              OR PATINDEX('%Full%', product_name) < CHARINDEX('-', product_name))
                         AND (PATINDEX('%Intel%', product_name) = 0
                              OR PATINDEX('%Full%', product_name) < PATINDEX('%Intel%', product_name))
                         AND (PATINDEX('%AMD%', product_name) = 0
                              OR PATINDEX('%Full%', product_name) < PATINDEX('%AMD%', product_name))
                         AND (PATINDEX('%Ryzen%', product_name) = 0
                              OR PATINDEX('%Full%', product_name) < PATINDEX('%Ryzen%', product_name))
                         AND (PATINDEX('%[0-9]th Gen%', product_name) = 0
                              OR PATINDEX('%Full%', product_name) < PATINDEX('%[0-9]th Gen%', product_name))
                         AND (PATINDEX('%15.6 inch%', product_name) = 0
                              OR PATINDEX('%Full%', product_name) < PATINDEX('%15.6 inch%', product_name))
                         AND (PATINDEX('%15.6"%', product_name) = 0
                              OR PATINDEX('%Full%', product_name) < PATINDEX('%15.6"%', product_name))
                         AND (PATINDEX('%Core i[0-9]%', product_name) = 0
                              OR PATINDEX('%Full%', product_name) < PATINDEX('%Core i[0-9]%', product_name))
                    THEN PATINDEX('%Full%', product_name) - 1

                    ELSE LEN(product_name)
                END
            )
        ELSE product_name
    END
WHERE model is null
