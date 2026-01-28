SELECT * FROM orders_data;

-- --Write a query to fetch all orders where sales are greater than the overall average sales.


SELECT Order_id,SUM(Sales) as sales
FROM orders_data
GROUP BY Order_ID
HAVING SUM(Sales)>(SELECT AVG(sales) FROM orders_data);


-- Write a query to retrieve the top 5 cities by total sales, ordered from highest to lowest.

SELECT TOP 5 City , SUM(sales) as sales
FROM orders_data
GROUP BY City
ORDER BY SUM(Sales) DESC;


--Write a query to find customers who have placed more than 5 orders, along with their total sales.

SELECT Customer_ID,Customer_Name ,COUNT(Order_ID) as Orders,SUM(Sales) as Sales
FROM orders_data
GROUP BY Customer_ID,Customer_Name
HAVING COUNT(Order_ID) > 5;


--Write a query to calculate total sales and total number of orders for each segment, sorted by total sales.

SELECT Segment , SUM(Sales),COUNT(Order_id) 
FROM orders_data
GROUP BY Segment
ORDER BY SUM(Sales);

-- Write a query to identify orders where the shipping duration exceeds 4 days
SELECT order FROM orders_data
WHERE DATEDIFF(DAY,Order_Date,Ship_Date)>4;

-- Write a query to calculate the percentage contribution of each ship mode based on the total number of orders.

SELECT
    Ship_Mode,
    COUNT(Order_ID) AS Total_Orders,
    ROUND(
        COUNT(Order_ID) * 100.0 / SUM(COUNT(Order_ID)) OVER (),
        2
    ) AS Percentage_Contribution
FROM orders_data
GROUP BY Ship_Mode;

-- Write a query to rank cities within each country based on total sales using a window function.

SELECT Country,City,SUM(Sales) AS Total_Sales,
RANK() OVER (
        PARTITION BY Country
        ORDER BY SUM(Sales) DESC
    ) AS City_Rank
FROM orders_data
GROUP BY Country, City


-- Write a query to calculate the number of orders per month, grouped by year and month using Order_Date.
SELECT  YEAR(Order_Date)  AS Order_Year,MONTH(Order_Date) AS Order_Month,COUNT(Order_ID)   AS Total_Orders
FROM orders_data
GROUP BY YEAR(Order_Date),MONTH(Order_Date)


-- Write a query to identify orders where the ship date is earlier than the order date.
SELECT *
FROM orders_data
WHERE Ship_Date < Order_Date;
`