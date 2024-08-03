CREATE DATABASE Amazon;

USE Amazon;

CREATE TABLE Products (
    asin VARCHAR(255) PRIMARY KEY,
    title TEXT,
    price FLOAT,
    original_price FLOAT,
    currency VARCHAR(10),
    star_rating FLOAT,
    num_ratings INT,
    url TEXT,
    photo TEXT,
    num_offers INT,
    minimum_offer_price FLOAT,
    is_best_seller BIT,
    is_amazon_choice BIT,
    is_prime BIT,
    climate_pledge_friendly BIT,
    sales_volume_in_past_month FLOAT,
    delivery TEXT,
    has_variations BIT,
    coupon_text TEXT,
    unit_price VARCHAR(255),
    unit_count FLOAT,
    availability TEXT
);

USE Amazon;

CREATE TABLE Reviews (
    id INT PRIMARY KEY,
    review_id VARCHAR(255),
    title TEXT,
    comment TEXT,
    star_rating INT,
    link TEXT,
    author VARCHAR(255),
    author_avatar TEXT,
    images TEXT,
    video FLOAT,
    date_location TEXT,
    is_verified_purchase BIT,
    product_asin VARCHAR(255),
    helpful_vote_statement TEXT,
    video_stream_url TEXT,
    video_closed_captions_url TEXT,
    video_thumbnail_url TEXT,
    helpful_vote_count FLOAT,
    extracted_date VARCHAR(50),
    date DATE
);
