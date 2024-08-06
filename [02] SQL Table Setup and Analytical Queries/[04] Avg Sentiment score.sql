-- Retrieve products with an average sentiment score higher than the overall average sentiment.

SELECT product_asin, AVG(review_star_rating) as avg_sentiment
FROM ReviewsView
GROUP BY product_asin
HAVING AVG(review_star_rating) > (SELECT AVG(review_star_rating) FROM ReviewsView);
