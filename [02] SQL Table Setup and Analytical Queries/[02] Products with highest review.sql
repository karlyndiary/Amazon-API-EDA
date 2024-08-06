-- What are the top 10 product titles with the highest total number of reviews?

WITH CTE AS (
    SELECT P.title, COUNT(*) AS total_reviews 
    FROM ReviewsView R
    JOIN Products P
    ON R.product_asin = P.asin
    GROUP BY P.title
)

SELECT TOP (10) title, total_reviews
FROM CTE
ORDER BY total_reviews DESC;
