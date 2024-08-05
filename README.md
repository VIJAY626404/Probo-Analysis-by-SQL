# 📊 Probo Data Anlysis
- <img src="https://www.freshersvoice.com/wp-content/uploads/2024/08/probo-internship.webp" alt="Output Example" width="1000"/>

Welcome to the Probo Data Analysis projects repository! This repository contains solutions to various SQL problems, showcasing data analysis and settlement processes.



## 🛠️ Technology Used

- **MySQL**: The relational database management system used for querying and analyzing sales data.

## 📊 Method and Functions

- **`WITH`**: To combine rows from multiple tables based on related columns.
- **`LAG()()`**: To aggregate data into summary statistics.
- **`LEAD()()`**: To sort the result set in ascending or descending order.
- **`SUM()`**: To calculate the total revenue and quantities.
- **`AVG()`**: To compute average values, such as the average number of pizzas ordered per day.
- **`WINDOW FUNCTION()`**: To perform calculations across a set of table rows that are related to the current row.

## 🔍 Problem Statement
### 1. Settlement Process Based on Poll Outcomes
**Scenario:**
We have a table recording user investments in poll options for predicting the number of matches the Indian cricket team will win in 2022. The options were:

- Less than 50
- 50-60
- 61-65 (Option C, the winner)
- Greater than 65

India wins 63 matches, making Option C the winner. The goal is to proportionately distribute the total money invested in non-winning options (A, B, and D) among users who invested in Option C.

**Solution:**

- **Calculate Total Investment:** Find the total amount invested in options A, B, and D.
- **Distribute Proportionally:** Allocate this total to users who invested in Option C based on their contributions.

**SQL Query:**
```sql
    WITH total_non_winner_amount AS (
        SELECT SUM(Amount) AS total_amount
        FROM investments
        WHERE Poll_Option_Id IN ('A', 'B', 'D')
    ),
    total_winner_amount AS (
        SELECT SUM(Amount) AS total_amount
        FROM investments
        WHERE Poll_Option_Id = 'C'
    ),
    user_winner_contributions AS (
        SELECT User_ID, Amount
        FROM investments
        WHERE Poll_Option_Id = 'C'
    )
    SELECT 
        u.User_ID,
        ROUND((u.Amount / t.total_amount) * nw.total_amount, 2) AS Returns
    FROM 
        user_winner_contributions u,
        total_winner_amount t,
        total_non_winner_amount nw;
```

### 2. Sales Data Analysis
**Scenario:**
We have city and month-wise sales data for 2020. The objective is to generate a table with:

- Sales
- Previous Month's Sales
- Next Month's Sales
- Year-to-Date (YTD) Sales
India wins 63 matches, making Option C the winner. The goal is to proportionately distribute the total money invested in non-winning options (A, B, and D) among users who invested in Option C.

**Solution:**

- **Previous Month's Sales:** Retrieve sales data from the previous month using window functions.
- **Next Month's Sales:** Retrieve sales data for the next month.
- **YTD Sales:** Compute cumulative sales up to the current month.
**SQL Query:**
```sql
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

```
## 🚀 How to Use

1. **Clone the Repository**:
    ```bash
    git clone <[repository-url](https://github.com/VIJAY626404/Probo-Analysis-by-SQL.git)>
    ```

2. **Navigate to the Project Directory**:
    ```bash
    cd Probo-Analysis-by-SQL
    ```

3. **Run the SQL Queries**:
    Use the SQL scripts in the `Sql Queries` folder with MySQL to execute and analyze the data.


## 🔗 Related Links

- [MySQL Documentation](https://dev.mysql.com/doc/)
- [SQL Join Operations](https://www.w3schools.com/sql/sql_join.asp)
- [SQL Aggregate Functions](https://www.w3schools.com/sql/sql_func_aggregate.asp)

## 📩 Contact

For any questions or feedback, feel free to reach out to me at vijaykumarshah1942@gmail.com

## 📜 License

This project is licensed under the MIT License. See the [LICENSE](https://github.com/VIJAY626404/Probo-Analysis-by-SQL/blob/main/LICENSE) file for details.

