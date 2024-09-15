# Amazon Sentiment Analysis

# Table of Contents
* [Project Background](#project-background)
* [Data Structure and Initial Checks](#data-structure-and-initial-checks)
* [Executive Summary](#executive-summary)
* [Recommendations](#recommendations)

# Project Background 
### Sentiment Analysis of Customer Reviews for Product Improvement

This project aims to analyze customer reviews to extract meaningful insights into product performance and customer satisfaction. By leveraging sentiment analysis techniques, the project will classify reviews into positive, neutral, and negative sentiments. This analysis will help identify trends and patterns in customer opinions, enabling data-driven decisions for product development and marketing strategies. The insights gained from this project will be crucial in enhancing product quality, customer experience, and overall brand perception.

# Project Background 
Elist Electronics, established in 2018, is a global e-commerce company that sells popular electronic products worldwide via its website and mobile app. 

The company has significant amounts of data on its sales, marketing efforts, operational efficiency, product offerings, and loyalty program that has been previously underutilized. This project thoroughly analyzes and synthesizes this data in order to uncover critical insights that will improve Elist's commercial success. 

Insights and recommendations are provided on the following key areas : 

- Sales Trends Analysis : Evaluation of historical sales patterns, both globally and by region, focusing on Revenue, Order Volume, and Average Order Value (AOV). 
- Product Level Performance : An analysis of Elist's various product lines, understanding their impact on sales and returns. 
- Loyalty Program Success : An assessment of the loyalty program on customer retention and sales. 
- Regional Comparisons : An evaluation of sales and orders by region.


- An interactive PowerBI dashboard can be downloaded here.
- the SQL queries utilized to inspect and perform quality checks can be found here. 
- the SQL queries utilized to clean, organize, and prepare data for the dashboard can be found here. 
- targeted SQL queries regarding various business questions can be found here.

# Data Structure & Initial Checks 

Elist's database structure as seen below consists of four tables : orders, customers, geo_lookup, and order_status, with a total row count of 108,127 records.

[ER Diagram here]

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
