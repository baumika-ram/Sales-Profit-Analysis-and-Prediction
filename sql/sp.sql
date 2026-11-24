CREATE DATABASE sales_profit_analysis;

USE sales_profit_analysis;

CREATE TABLE superstore (
    `Row ID` INT,
    `Order ID` VARCHAR(20),
    `Order Date` VARCHAR(20),
    `Ship Date` VARCHAR(20),
    `Ship Mode` VARCHAR(30),
    `Customer ID` VARCHAR(20),
    `Customer Name` VARCHAR(100),
    `Segment` VARCHAR(30),
    `Country` VARCHAR(50),
    `City` VARCHAR(100),
    `State` VARCHAR(100),
    `Postal Code` VARCHAR(20),
    `Region` VARCHAR(30),
    `Product ID` VARCHAR(30),
    `Category` VARCHAR(50),
    `Sub-Category` VARCHAR(50),
    `Product Name` TEXT,
    `Sales` DECIMAL(12,2),
    `Quantity` INT,
    `Discount` DECIMAL(5,2),
    `Profit` DECIMAL(12,2)
);

SHOW TABLES;

SET GLOBAL local_infile = 1;

SHOW GLOBAL VARIABLES LIKE 'local_infile';

LOAD DATA LOCAL INFILE
'C:/Users/ELCOT/OneDrive/Desktop/Sales_Profit_Analysis/Sample - Superstore.csv'
INTO TABLE superstore
CHARACTER SET latin1
FIELDS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS
(
    @row_id, @order_id, @order_date, @ship_date, @ship_mode,
    @customer_id, @customer_name, @segment, @country, @city,
    @state, @postal_code, @region, @product_id, @category,
    @sub_category, @product_name, @sales, @quantity, @discount, @profit
)
SET
    `Row ID` = NULLIF(@row_id, ''),
    `Order ID` = @order_id,
    `Order Date` = @order_date,
    `Ship Date` = @ship_date,
    `Ship Mode` = @ship_mode,
    `Customer ID` = @customer_id,
    `Customer Name` = @customer_name,
    `Segment` = @segment,
    `Country` = @country,
    `City` = @city,
    `State` = @state,
    `Postal Code` = NULLIF(@postal_code, ''),
    `Region` = @region,
    `Product ID` = @product_id,
    `Category` = @category,
    `Sub-Category` = @sub_category,
    `Product Name` = @product_name,
    `Sales` = NULLIF(@sales, ''),
    `Quantity` = NULLIF(@quantity, ''),
    `Discount` = NULLIF(@discount, ''),
    `Profit` = NULLIF(@profit, '');
    
    TRUNCATE TABLE superstore;
    
    ALTER TABLE superstore
MODIFY Sales DECIMAL(15,4),
MODIFY Profit DECIMAL(15,4);

SELECT COUNT(*) AS total_rows
FROM superstore;

SHOW WARNINGS LIMIT 20;

SELECT
    COUNT(*) AS total_rows,
    SUM(`Order Date` IS NULL OR `Order Date` = '') AS missing_order_date,
    SUM(`Sales` IS NULL) AS missing_sales,
    SUM(`Quantity` IS NULL) AS missing_quantity,
    SUM(`Discount` IS NULL) AS missing_discount,
    SUM(`Profit` IS NULL) AS missing_profit,
    SUM(`Category` IS NULL OR `Category` = '') AS missing_category
FROM superstore;

SELECT
    COUNT(*) AS total_rows,
    COUNT(DISTINCT `Row ID`) AS unique_rows
FROM superstore;

DESCRIBE superstore;

SELECT `Order Date`, `Ship Date`
FROM superstore
LIMIT 5;

ALTER TABLE superstore
ADD COLUMN order_date_new DATE,
ADD COLUMN ship_date_new DATE;

UPDATE superstore
SET
    order_date_new = STR_TO_DATE(`Order Date`, '%m/%d/%Y'),
    ship_date_new = STR_TO_DATE(`Ship Date`, '%m/%d/%Y');
    
SET SQL_SAFE_UPDATES = 0;

SELECT
    `Order Date`,
    order_date_new,
    `Ship Date`,
    ship_date_new
FROM superstore
LIMIT 5;

SELECT
    COUNT(*) AS total_rows,
    SUM(order_date_new IS NULL) AS missing_order_dates,
    SUM(ship_date_new IS NULL) AS missing_ship_dates
FROM superstore;

ALTER TABLE superstore
DROP COLUMN `Order Date`,
DROP COLUMN `Ship Date`;

ALTER TABLE superstore
CHANGE COLUMN order_date_new `Order Date` DATE,
CHANGE COLUMN ship_date_new `Ship Date` DATE;

describe superstore;