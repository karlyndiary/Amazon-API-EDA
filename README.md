# Amazon-Web-Scraping-EDA

## Table of Contents
* [Business Problem](#business-problem)
* [Tools Used](#tools-used)
* [Data Description](#data-description)
* [Data Cleaning in MS SQL Server](#data-cleaning-in-ms-sql-server)
* [Dashboard](#dashboard)

## Business Problem: 
### Laptop Price Optimization Analysis

Developing a laptop price analysis and recommendation system to optimize sales and customer satisfaction through informed pricing strategies.

## Tools Used
- Python: For Web Scraping and ETL.
  - Laptops 
- SQL: For data cleaning and querying the required data.
- Google Sheets: Dashboard Data Visualizations.

## Data Description
- id : Primary Key of the laptop
- title: Title of the laptop listing
- price: Current price of the laptop
- brand: Brand name
- mrp: Original price before any discounts
- discount_percent: Discount percentage
- rating: Customer rating of the product
- stars: Number of stars the product has received
- total_purchased: Total number of units purchased
- deal: Indicates if the product is part of a special deal
- style_name: Style or variant of the laptop
- model_name: Model name of the laptop
- screen_size: Size of the laptop screen
- color: Color of the laptop
- hard_disk_size: Size of the hard disk
- cpu_model: Model of the CPU
- ram: Amount of RAM in the laptop
- operating_system: Operating system of the laptop
- graphic_card: Type of graphic card included
- software: Additional software included with the laptop
- stock: Availability of the product
- ships_from: Location from where the product ships
- resolution: Screen resolution of the laptop
- processor_brand: Brand of the processor
- service: Additional services provided with the product

## Data Cleaning in MS SQL Server

- [] price - remove comma and dot
- [] rating - remove the word rating
- [] mrp - remove sign and comma
- [] ram - remove gb
- [] storage - extract all with ssd
- [] star - mean value for missing
- [] screen size - convert cm to inches and maybe remove inches
  
## Dashboard
