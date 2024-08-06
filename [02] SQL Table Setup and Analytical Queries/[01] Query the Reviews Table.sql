-- Check if there are any other asin ids aside the ones from the product table 

WITH CTE AS (
    SELECT R.id, R.review_id, R.title as review_title, R.comment, R.star_rating as review_star_rating, R.author, R.product_asin, R.date
    FROM [Amazon].[dbo].[Products] P 
    INNER JOIN [Amazon].[dbo].[Reviews] R 
    ON P.asin = R.product_asin
)
SELECT * FROM CTE;
