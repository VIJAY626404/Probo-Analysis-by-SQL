use probodata;
-- Creating the sales table
CREATE TABLE sales (
    City VARCHAR(255),
    Year INT,
    Month INT,
    Sales INT
);

-- Inserting data into the sales table
INSERT INTO sales (City, Year, Month, Sales) VALUES
('Delhi', 2020, 5, 4300),
('Delhi', 2020, 6, 2000),
('Delhi', 2020, 7, 2100),
('Delhi', 2020, 8, 2200),
('Delhi', 2020, 9, 1900),
('Delhi', 2020, 10, 200),
('Mumbai', 2020, 5, 4400),
('Mumbai', 2020, 6, 2800),
('Mumbai', 2020, 7, 6000),
('Mumbai', 2020, 8, 9300),
('Mumbai', 2020, 9, 4200),
('Mumbai', 2020, 10, 9700),
('Bangalore', 2020, 5, 1000),
('Bangalore', 2020, 6, 2300),
('Bangalore', 2020, 7, 6800),
('Bangalore', 2020, 8, 7000),
('Bangalore', 2020, 9, 2300),
('Bangalore', 2020, 10, 8400);


WITH sales_data AS (
    SELECT 
        City, 
        Year, 
        Month, 
        Sales, 
        LAG(Sales) OVER (PARTITION BY City, Year ORDER BY Month) AS Previous_Month_Sales,
        LEAD(Sales) OVER (PARTITION BY City, Year ORDER BY Month) AS Next_Month_Sales,
        SUM(Sales) OVER (PARTITION BY City, Year ORDER BY Month ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS YTD_Sales
    FROM sales
)
SELECT 
    City, 
    Year, 
    Month, 
    Sales, 
    Previous_Month_Sales,
    Next_Month_Sales,
    YTD_Sales
FROM sales_data
ORDER BY City, Year, Month;
