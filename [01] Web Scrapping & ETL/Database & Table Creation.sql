CREATE DATABASE Amazon;

USE Amazon;

CREATE TABLE Laptops (
    id INT IDENTITY(1,1) PRIMARY KEY,
    product_name NVARCHAR(255),
    prices NVARCHAR(50),
    discount_percent NVARCHAR(50),
    stars NVARCHAR(50),
    rating NVARCHAR(50),
    total_purchased NVARCHAR(100),
    deal NVARCHAR(100),
    device_setup NVARCHAR(50)
);
