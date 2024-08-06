-- Which product(s) have the highest number of reviews and what is the date of their most recent review?

SELECT product_asin, MAX(date) AS last_review_date, COUNT(*) AS total_reviews
FROM ReviewsView 
GROUP BY product_asin
ORDER BY total_reviews DESC;
