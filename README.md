# Amazon Sentiment Analysis

# Table of Contents
* [Project Background](#project-background)
* [Data Structure](#data-structure)
* [Executive Summary](#executive-summary)
* [Recommendations](#recommendations)

# Project Background 
Amazon, founded in 1994, is a global e-commerce giant offering a vast range of products, including popular electronic items, through its website and mobile app. 

With millions of customer reviews and feedback across its electronics category, Amazon possesses a wealth of data that has the potential to provide valuable insights for product improvement and customer satisfaction. This project focuses on conducting a comprehensive sentiment analysis of electronic product reviews, aiming to uncover key insights that can guide product enhancements, improve customer experience, and drive better business outcomes for Amazon.

Insights and recommendations are provided on the following key areas : 

- **Sentiment Distribution**: Analysis of overall customer feedback, highlighting the proportion of positive, neutral, and negative reviews.
- **Sentiment Trends**: Evaluation of sentiment changes over time, focusing on the increase in negative sentiment in 2024.
- **Product Performance**: Assessment of product ratings in relation to customer sentiment, showing the correlation between high ratings and positive feedback.
- **Best Sellers & Prime Products**: Review of best-selling and Prime products, focusing on their association with positive sentiment and customer satisfaction.

Detailed Resources: 

- The API Extraction and Data Cleaning process utilized can be found [here](https://github.com/karlyndiary/Amazon-Sentiment-Analysis-EDA/tree/main/%5B01%5D%20API%20Data%20Extraction%2C%20Data%20Cleaning). 
- Sentiment Analysis can be found [here](https://github.com/karlyndiary/Amazon-Sentiment-Analysis-EDA/tree/main/%5B02%5D%20Sentiment%20Analysis).
- An interactive Tableau dashboard can be downloaded [here](https://public.tableau.com/app/profile/karen.judelyn.fernandes/viz/AmazonElectronicsReviewsDashboard/Dashboard-Overview?publish=yes).

# Data Structure

Amazon's database structure as seen below consists of two tables: products and reviews, with a total row count of 606 records.

![Amazon API drawio](https://github.com/user-attachments/assets/44120410-19b8-4834-b36b-23fc109ae3e1)

# Executive Summary 

### Overview of Findings 

After a period of strong positive sentiment, there has been a noticeable shift in 2024, with negative sentiment increasing significantly. Key performance indicators reflect this change: negative sentiment rose, and the average rating for negative reviews remains low at 3.154. Despite this, positive sentiment still dominates at 88%, driving higher average ratings of 4.866. The following sections will explore potential reasons for the rise in negative sentiment and identify areas to improve customer satisfaction, particularly in relation to best sellers and Prime products.

Below is the overview page from the Tableau dashboard and more examples are included throughout the report. The interactive dashboard can be downloaded [here](https://public.tableau.com/app/profile/karen.judelyn.fernandes/viz/AmazonElectronicsReviewsDashboard/Dashboard-Overview?publish=yes).

![Overview](https://github.com/user-attachments/assets/41b8d8a7-f411-431e-bade-048a12eac3cc)

### Sentiment Analysis and Correlation Insights : 
- 88% of the products received positive reviews, 7% neutral, and 4% negative, highlighting a strong customer satisfaction trend. This aligns with growing consumer preference for electronic products, driving positive feedback in the review space.
- The average rating for products with positive sentiment is 4.8, followed by 4.5 for neutral, and 3.1 for negative reviews. This trend reflects the strong correlation between higher ratings and positive customer experiences, emphasizing the impact of satisfaction on product evaluations.
- Out of the total products, 504 received 5-star ratings, followed by 83 products with 4 stars. A smaller number, 8 products, received 3 stars, while 4 products were rated 2 stars, and 7 products received 1 star. This distribution highlights a clear dominance of top-rated products, indicating strong consumer approval.
- Most products received ratings above 3.9, indicating a positive sentiment, while ratings between 4.2 and 4.5 showed a neutral sentiment. Products with a 3.9 rating had a predominantly negative sentiment. Interestingly, a product with a 4.5 rating, which would usually signal positive feedback, was tied to negative sentiment. This exception to the typical trend will be examined further in the next analysis.
- The relationship between price and sentiment reveals notable patterns: a sharp decrease in negative sentiment is observed for a product priced at $19.99 with a rating of 2.7. In contrast, the highest positive sentiment aligns with a product priced at $9.99 and rated 4.8. For neutral sentiment, ratings span from 3.9 at $69.99 to 4.8 at $29.99. This variation highlights the intricate interplay between product pricing, sentiment, and ratings.
- Sales volume data demonstrates a strong correlation with sentiment: products with positive sentiment achieved a sales volume of 14,007, indicating high customer satisfaction across delivery, product performance, and overall experience. Meanwhile, neutral sentiment reflects moderate satisfaction with 8,977 in sales volume, and negative sentiment still shows a significant 8,500 sales, highlighting areas for potential product improvement despite continued customer interest.

### Product Trends

![Details](https://github.com/user-attachments/assets/4f5e1577-e61a-4bda-9cc9-609fb8b9593d)

# Recommendations : 

based on the uncovered insights, the following recommendations have been provided : 

- With 85% of orders and 70% of revenue coming from just three products, diversifying the product portfolio is crucial. Expanding the accessory category with new product lines, particularly Apple charging cables, would provide upsell opportunities. 

- Despite the general sales success of Apple products, iPhone sales have been disappointingly low (1% of revenue in 2022). Enhancing marketing efforts to previous Apple product buyers could boost sales. Look to capitalize on the growing share of Samsung accessories (32% of order count in 2022) by introducing higher-cost Samsung products in already carried product categories such as laptops and cellphones. 

- Re-evaluate Bose SoundSport Headphones. As the product has never made up more than 1% of annual revenue, attempt to sell through the product by implementing bundle offers and flash sales to non-Apple ecosystem loyalty members before discontinuing.
