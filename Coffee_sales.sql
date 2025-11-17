Create database Coffee_sales;
use coffee_sales;
CREATE TABLE coffee_sales (
    order_date DATE,
    datetime DATETIME,
    cash_type VARCHAR(10),
    card VARCHAR(100),
    money DECIMAL(10,2),
    coffee_name VARCHAR(50),
    Year INT,
    Month INT,
    Day INT,
    Day_of_Week VARCHAR(15),
    Next_Day DATE
);

select * from coffee_sales;

-- 1.Avg_revenue per date
SELECT date,AVG(money) as Avg_revenue
FROM coffee_sales
GROUP BY date;

--  2.Daily sales trend
SELECT date, SUM(money) AS total_sales
FROM coffee_sales
GROUP BY date
ORDER BY date;

-- 3.Monthly trend
SELECT month, SUM(money) AS monthly_sales
FROM coffee_sales
GROUP BY month
ORDER BY month;

-- 4.Weekday sales
SELECT day_of_week, SUM(money) AS total_sales
FROM coffee_sales
GROUP BY day_of_week
ORDER BY FIELD(day_of_week, 'Monday','Tuesday','Wednesday','Thursday','Friday','Saturday','Sunday');

-- 5.Hourly trend
SELECT 
    HOUR(datetime) AS hour,
    SUM(money) AS total_sales
FROM coffee_sales
GROUP BY HOUR(datetime)
ORDER BY hour;

-- 6.Expected next day sales (based on average daily)
SELECT ROUND(AVG(total_sales),2) AS expected_next_day_sales
FROM (
  SELECT date, SUM(money) AS total_sales
  FROM coffee_sales
  GROUP BY date
) AS daily;

-- 7.Expected next month sales
SELECT ROUND(AVG(monthly_sales),2) AS expected_next_month_sales
FROM (
  SELECT month, SUM(money) AS monthly_sales
  FROM coffee_sales
  GROUP BY month
) AS monthly;


-- 8.Each card customer’s total purchases
SELECT card, COUNT(*) AS total_orders, SUM(money) AS total_spent
FROM coffee_sales
WHERE card != 'CASH_USER'
GROUP BY card
ORDER BY total_spent DESC;

-- 9.Each cash customer's total spent
SELECT card, COUNT(*) AS total_orders, SUM(money) AS total_spent
FROM coffee_sales
WHERE card = 'CASH_USER'
GROUP BY card
ORDER BY total_spent DESC;

-- 10.Favorite coffee for each customer
SELECT card, coffee_name, COUNT(*) AS purchase_count
FROM coffee_sales
WHERE card != 'CASH_USER'
GROUP BY card, coffee_name
ORDER BY  purchase_count DESC;

-- 11.Revenue by coffee type
SELECT coffee_name, SUM(money) AS total_revenue
FROM coffee_sales
GROUP BY coffee_name
ORDER BY total_revenue DESC;

-- 12.Payment type usage
SELECT cash_type, COUNT(*) AS transactions, SUM(money) AS revenue
FROM coffee_sales
GROUP BY cash_type;

-- 13.Top 5 products
SELECT coffee_name, COUNT(*) AS total_orders, SUM(money) AS total_revenue
FROM coffee_sales
GROUP BY coffee_name
ORDER BY total_revenue DESC
LIMIT 5;

-- 14.Most profitable day of the week
SELECT Day_of_Week, SUM(money) AS total_sales
FROM coffee_sales
GROUP BY Day_of_Week
ORDER BY total_sales DESC
LIMIT 1;

-- 15.Peak hour (highest sales)
SELECT HOUR(datetime) AS hour, SUM(money) AS total_sales
FROM coffee_sales
GROUP BY hour
ORDER BY total_sales DESC
LIMIT 1;



