CREATE DATABASE Amazon;

USE Amazon;

CREATE TABLE Laptops (
    product_name NVARCHAR(255) PRIMARY KEY,
    prices NVARCHAR(20),
    discount_percent CHAR(100),
    stars NVARCHAR(20),
    rating INT,
    total_purchased NVARCHAR(100),
    deal NVARCHAR(255),
    device_setup NVARCHAR(20)
);
