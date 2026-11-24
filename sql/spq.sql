USE sales_profit_analysis;

-- Q1. Find total sales and total profit
SELECT
    SUM(Sales) AS Total_Sales,
    SUM(Profit) AS Total_Profit
FROM superstore;


-- Q2. Find average sales and average profit
SELECT
    AVG(Sales) AS Average_Sales,
    AVG(Profit) AS Average_Profit
FROM superstore;


-- Q3. Find total number of unique orders
SELECT
    COUNT(DISTINCT `Order ID`) AS Total_Orders
FROM superstore;


-- Q4. Find total quantity of products sold
SELECT
    SUM(Quantity) AS Total_Quantity_Sold
FROM superstore;


-- Q5. Display all unique product categories
SELECT DISTINCT Category
FROM superstore;


-- Q6. Find total sales and profit by category
SELECT
    Category,
    SUM(Sales) AS Total_Sales,
    SUM(Profit) AS Total_Profit
FROM superstore
GROUP BY Category;


-- Q7. Find sub-categories based on highest sales
SELECT
    `Sub-Category`,
    SUM(Sales) AS Total_Sales
FROM superstore
GROUP BY `Sub-Category`
ORDER BY Total_Sales DESC;


-- Q8. Find total sales and profit by region
SELECT
    Region,
    SUM(Sales) AS Total_Sales,
    SUM(Profit) AS Total_Profit
FROM superstore
GROUP BY Region;


-- Q9. Find the region with the highest profit
SELECT
    Region,
    SUM(Profit) AS Total_Profit
FROM superstore
GROUP BY Region
ORDER BY Total_Profit DESC
LIMIT 1;


-- Q10. Find the category with the highest average discount
SELECT
    Category,
    AVG(Discount) AS Average_Discount
FROM superstore
GROUP BY Category
ORDER BY Average_Discount DESC;


-- Q11. Find total number of unique customers
SELECT
    COUNT(DISTINCT `Customer ID`) AS Total_Customers
FROM superstore;


-- Q12. Find total sales by customer segment
SELECT
    Segment,
    SUM(Sales) AS Total_Sales
FROM superstore
GROUP BY Segment
ORDER BY Total_Sales DESC;


-- Q13. Find the top 10 customers based on sales
SELECT
    `Customer Name`,
    SUM(Sales) AS Total_Sales
FROM superstore
GROUP BY `Customer ID`, `Customer Name`
ORDER BY Total_Sales DESC
LIMIT 10;


-- Q14. Find customers who generated negative profit
SELECT
    `Customer Name`,
    SUM(Profit) AS Total_Profit
FROM superstore
GROUP BY `Customer ID`, `Customer Name`
HAVING SUM(Profit) < 0
ORDER BY Total_Profit ASC;


-- Q15. Find the top 10 products based on profit
SELECT
    `Product Name`,
    SUM(Profit) AS Total_Profit
FROM superstore
GROUP BY `Product ID`, `Product Name`
ORDER BY Total_Profit DESC
LIMIT 10;


-- Q16. Find products that generated a loss
SELECT
    `Product Name`,
    SUM(Profit) AS Total_Profit
FROM superstore
GROUP BY `Product ID`, `Product Name`
HAVING SUM(Profit) < 0
ORDER BY Total_Profit ASC;


-- Q17. Find total sales and profit by shipping mode
SELECT
    `Ship Mode`,
    SUM(Sales) AS Total_Sales,
    SUM(Profit) AS Total_Profit
FROM superstore
GROUP BY `Ship Mode`;


-- Q18. Find monthly sales and profit trend
SELECT
    YEAR(`Order Date`) AS Order_Year,
    MONTH(`Order Date`) AS Order_Month,
    SUM(Sales) AS Total_Sales,
    SUM(Profit) AS Total_Profit
FROM superstore
GROUP BY
    YEAR(`Order Date`),
    MONTH(`Order Date`)
ORDER BY
    Order_Year,
    Order_Month;


-- Q19. Find orders with high discounts and negative profit
SELECT
    `Order ID`,
    `Product Name`,
    Sales,
    Discount,
    Profit
FROM superstore
WHERE Discount >= 0.30
AND Profit < 0
ORDER BY Discount DESC;


-- Q20. Calculate overall profit margin percentage
SELECT
    SUM(Profit) AS Total_Profit,
    SUM(Sales) AS Total_Sales,
    ROUND(
        (SUM(Profit) / SUM(Sales)) * 100,
        2
    ) AS Profit_Margin_Percentage
FROM superstore;