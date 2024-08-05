show databases;
create database probodata;
use probodata;
CREATE TABLE investment (
    USER_ID varchar(50),
    Poll_Id varchar(50),
    Poll_Option_Id char(1),
    Amount int,
    Created_dt date
);

INSERT INTO investment (USER_ID, Poll_Id, Poll_Option_Id, Amount, Created_dt)
VALUES
    ('id1', 'p1', 'A', 200, '2021-12-01'),
    ('id2', 'p1', 'C', 250, '2021-12-01'),
    ('id3', 'p1', 'A', 200, '2021-12-01'),
    ('id4', 'p1', 'B', 500, '2021-12-01'),
    ('id5', 'p1', 'C', 50, '2021-12-01'),
    ('id6', 'p1', 'D', 500, '2021-12-01'),
    ('id7', 'p1', 'C', 200, '2021-12-01'),
    ('id8', 'p1', 'A', 100, '2021-12-01');

WITH total_non_winner_amount AS (
    SELECT SUM(Amount) AS total_amount
    FROM investment
    WHERE Poll_Option_Id IN ('A', 'B', 'D')
),
total_winner_amount AS (
    SELECT SUM(Amount) AS total_amount
    FROM investment
    WHERE Poll_Option_Id = 'C'
),
user_winner_contributions AS (
    SELECT User_ID, Amount
    FROM investment
    WHERE Poll_Option_Id = 'C'
)
SELECT 
    u.User_ID,
    ROUND((u.Amount / t.total_amount) * nw.total_amount + u.Amount,0) AS Returns
FROM 
    user_winner_contributions u
JOIN 
    total_winner_amount t ON 1=1
JOIN 
    total_non_winner_amount nw ON 1=1;
