# cleaning product_name column
UPDATE [Amazon].[dbo].[Laptops]
SET product_name = REPLACE(REPLACE(product_name, '®', ' '),'™','')

