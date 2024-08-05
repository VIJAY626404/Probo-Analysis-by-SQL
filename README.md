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
