# Amazon Sentiment Analysis

# Table of Contents
* [Project Background](#project-background)
* [Data Structure and Initial Checks](#data-structure-and-initial-checks)
* [Executive Summary](#executive-summary)
* [Recommendations](#recommendations)

# Project Background 
Amazon, founded in 1994, is a global e-commerce giant offering a vast range of products, including popular electronic items, through its website and mobile app. 

With millions of customer reviews and feedback across its electronics category, Amazon possesses a wealth of data that has the potential to provide valuable insights for product improvement and customer satisfaction. This project focuses on conducting a comprehensive sentiment analysis of electronic product reviews, aiming to uncover key insights that can guide product enhancements, improve customer experience, and drive better business outcomes for Amazon.

Insights and recommendations are provided on the following key areas : 

- Sales Trends Analysis : Evaluation of historical sales patterns, both globally and by region, focusing on Revenue, Order Volume, and Average Order Value (AOV). 
- Product Level Performance : An analysis of Elist's various product lines, understanding their impact on sales and returns. 
- Loyalty Program Success : An assessment of the loyalty program on customer retention and sales. 
- Regional Comparisons : An evaluation of sales and orders by region.

Detailed Resources: 

- The API Extraction and Data Cleaning process utilized can be found [here](https://github.com/karlyndiary/Amazon-Sentiment-Analysis-EDA/tree/main/%5B01%5D%20API%20Data%20Extraction%2C%20Data%20Cleaning). 
- Sentiment Analysis can be found [here](https://github.com/karlyndiary/Amazon-Sentiment-Analysis-EDA/tree/main/%5B02%5D%20Sentiment%20Analysis).
- An interactive Tableau dashboard can be downloaded [here](https://public.tableau.com/app/profile/karen.judelyn.fernandes/viz/AmazonElectronicsReviewsDashboard/Dashboard-Overview?publish=yes).

# Data Structure & Initial Checks 

Amazon's database structure as seen below consists of two tables: products and reviews, with a total row count of 606 records.

![Amazon API drawio](https://github.com/user-attachments/assets/44120410-19b8-4834-b36b-23fc109ae3e1)

Prior to beginning the analysis, a variety of checks were conducted for quality control and familiarization with the datasets. The SQL queries utilized to inspect and perform quality checks can be found here.

# Executive Summary 

### Overview of Findings 

After peaking in late 2020, the company's sales have continued to decline, with significant drops in 2022. Key rformance indicators have all shown year-over-year decreases : order volume by 40%, revenue by 46%, and average der value (AOV) by 10%. While this decline can be broadly attributed to a return to pre-pandemic normalcy, the lowing sections will explore additional contributing factors and highlight key opportunity areas for improvement. 

below is the overview page from the PowerBI dashboard and more examples are included throughout the report. The tire interactive dashboard can be downloaded here.

[dashboard image here]

### Sales Trends : 
• The company's sales peaked in December 2020 with 4,019 orders totaling $1,251,721 monthly revenue. This corresponds with the boom in economy-wide spending due to pandemic-induced changing consumer behavior. 
• Beginning in April 2021, revenue declined on a year-over-year basis for 21 consecutive months. Revenue hit a company lifetime low in October 2022, with the company earning just over $178K. In the following months, revenue recovered slightly, following normal holiday seasonality patterns. 
• Despite the downward trend, full-year 2022 remained above the pre-COVID 2019 baseline in all three key performance indicators. This is primarily due to the stronger 1Q22, which recorded revenue and order count well above the same period in 2020, up 37% and 23% respectively. 
• Average order value saw a one-month year-over-year increase in September 2022, this can be attributed to an increased share of high-cost laptop orders.

[sales trends chart]

# Recommendations : 

based on the uncovered insights, the following recommendations have been provided : 

- With 85% of orders and 70% of revenue coming from just three products, diversifying the product portfolio is crucial. Expanding the accessory category with new product lines, particularly Apple charging cables, would provide upsell opportunities. 

- Despite the general sales success of Apple products, iPhone sales have been disappointingly low (1% of revenue in 2022). Enhancing marketing efforts to previous Apple product buyers could boost sales. Look to capitalize on the growing share of Samsung accessories (32% of order count in 2022) by introducing higher-cost Samsung products in already carried product categories such as laptops and cellphones. 

- Re-evaluate Bose SoundSport Headphones. As the product has never made up more than 1% of annual revenue, attempt to sell through the product by implementing bundle offers and flash sales to non-Apple ecosystem loyalty members before discontinuing.
