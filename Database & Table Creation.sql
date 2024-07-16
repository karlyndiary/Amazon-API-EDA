CREATE DATABASE DATABASE_NAME;

USE Target;

CREATE TABLE Retail (
     Transaction_ID INT PRIMARY KEY,
     Date DATE,
     Customer_ID CHAR(100),
     Gender NVARCHAR(20),
     Age INT,
     Product_Category NVARCHAR(100),
     Quantity INT,
     Price_Per_Unit INT,
     Total_Amount INT
);
