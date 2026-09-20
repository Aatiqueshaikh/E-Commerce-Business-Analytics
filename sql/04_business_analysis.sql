USE ecommerce_analytics;

-- 1. Overall Business Performance
SELECT
    COUNT(DISTINCT order_id) AS total_orders,
    COUNT(DISTINCT customer_id) AS total_customers,
    SUM(quantity) AS total_units_sold,
    ROUND(SUM(sales), 2) AS total_revenue,
    ROUND(SUM(profit), 2) AS total_profit,
    ROUND((SUM(profit) / SUM(sales)) * 100, 2) AS profit_margin_percentage,
    ROUND(SUM(sales) / COUNT(DISTINCT order_id), 2) AS average_order_value
FROM sales;

-- 2. Monthly Sales and Profit Trend
SELECT
    YEAR(order_date) AS year,
    MONTH(order_date) AS month,
    DATE_FORMAT(order_date, '%Y-%m') AS month_year,
    ROUND(SUM(sales), 2) AS total_revenue,
    ROUND(SUM(profit), 2) AS total_profit,
    COUNT(DISTINCT order_id) AS total_orders
FROM sales
GROUP BY
    YEAR(order_date),
    MONTH(order_date),
    DATE_FORMAT(order_date, '%Y-%m')
ORDER BY
    year,
    month;

-- 3. Category Performance
SELECT
    category,
    ROUND(SUM(sales), 2) AS total_revenue,
    ROUND(SUM(profit), 2) AS total_profit,
    SUM(quantity) AS total_units_sold,
    COUNT(DISTINCT order_id) AS total_orders,
    ROUND((SUM(profit) / SUM(sales)) * 100, 2) AS profit_margin_percentage
FROM sales
GROUP BY category
ORDER BY total_revenue DESC;

-- 4. Sub-Category Performance
SELECT
    sub_category,
    ROUND(SUM(sales), 2) AS total_revenue,
    ROUND(SUM(profit), 2) AS total_profit,
    SUM(quantity) AS total_units_sold,
    COUNT(DISTINCT order_id) AS total_orders,
    ROUND((SUM(profit) / SUM(sales)) * 100, 2) AS profit_margin_percentage
FROM sales
GROUP BY sub_category
ORDER BY total_revenue DESC;

-- 5. Regional Performance
SELECT
    region,
    ROUND(SUM(sales), 2) AS total_revenue,
    ROUND(SUM(profit), 2) AS total_profit,
    SUM(quantity) AS total_units_sold,
    COUNT(DISTINCT order_id) AS total_orders,
    ROUND((SUM(profit) / SUM(sales)) * 100, 2) AS profit_margin_percentage
FROM sales
GROUP BY region
ORDER BY total_revenue DESC;

-- 6. Top Customers by Revenue
SELECT
    customer_id,
    customer_name,
    segment,
    ROUND(SUM(sales), 2) AS total_revenue,
    ROUND(SUM(profit), 2) AS total_profit,
    COUNT(DISTINCT order_id) AS total_orders,
    SUM(quantity) AS total_units_sold,
    ROUND(SUM(sales) / COUNT(DISTINCT order_id), 2) AS average_order_value
FROM sales
GROUP BY
    customer_id,
    customer_name,
    segment
ORDER BY total_revenue DESC
LIMIT 10;

-- 7. Top 10 Products by Revenue
SELECT
    product_id,
    product_name,
    category,
    sub_category,
    ROUND(SUM(sales), 2) AS total_revenue,
    ROUND(SUM(profit), 2) AS total_profit,
    SUM(quantity) AS total_units_sold,
    COUNT(DISTINCT order_id) AS total_orders,
    ROUND((SUM(profit) / SUM(sales)) * 100, 2) AS profit_margin_percentage
FROM sales
GROUP BY
    product_id,
    product_name,
    category,
    sub_category
ORDER BY total_revenue DESC
LIMIT 10;

-- 8. Top 10 Products by Profit
SELECT
    product_id,
    product_name,
    category,
    sub_category,
    ROUND(SUM(sales), 2) AS total_revenue,
    ROUND(SUM(profit), 2) AS total_profit,
    SUM(quantity) AS total_units_sold,
    COUNT(DISTINCT order_id) AS total_orders,
    ROUND((SUM(profit) / SUM(sales)) * 100, 2) AS profit_margin_percentage
FROM sales
GROUP BY
    product_id,
    product_name,
    category,
    sub_category
ORDER BY total_profit DESC
LIMIT 10;

-- 9. Bottom 10 Products by Profit
SELECT
    product_id,
    product_name,
    category,
    sub_category,
    ROUND(SUM(sales), 2) AS total_revenue,
    ROUND(SUM(profit), 2) AS total_profit,
    SUM(quantity) AS total_units_sold,
    COUNT(DISTINCT order_id) AS total_orders,
    ROUND((SUM(profit) / SUM(sales)) * 100, 2) AS profit_margin_percentage
FROM sales
GROUP BY
    product_id,
    product_name,
    category,
    sub_category
ORDER BY total_profit ASC
LIMIT 10;

-- 10. Yearly Business Performance
SELECT
    YEAR(order_date) AS year,
    ROUND(SUM(sales), 2) AS total_revenue,
    ROUND(SUM(profit), 2) AS total_profit,
    SUM(quantity) AS total_units_sold,
    COUNT(DISTINCT order_id) AS total_orders,
    COUNT(DISTINCT customer_id) AS total_customers,
    ROUND((SUM(profit) / SUM(sales)) * 100, 2) AS profit_margin_percentage
FROM sales
GROUP BY YEAR(order_date)
ORDER BY year;

-- 11. Customer Segment Performance
SELECT
    segment,
    ROUND(SUM(sales), 2) AS total_revenue,
    ROUND(SUM(profit), 2) AS total_profit,
    SUM(quantity) AS total_units_sold,
    COUNT(DISTINCT order_id) AS total_orders,
    COUNT(DISTINCT customer_id) AS total_customers,
    ROUND((SUM(profit) / SUM(sales)) * 100, 2) AS profit_margin_percentage
FROM sales
GROUP BY segment
ORDER BY total_revenue DESC;

-- 12. Discount and Profitability Analysis
SELECT
    discount,
    ROUND(SUM(sales), 2) AS total_revenue,
    ROUND(SUM(profit), 2) AS total_profit,
    SUM(quantity) AS total_units_sold,
    COUNT(DISTINCT order_id) AS total_orders,
    ROUND(AVG(sales), 2) AS average_sales,
    ROUND(AVG(profit), 2) AS average_profit
FROM sales
GROUP BY discount
ORDER BY discount;

-- 13. Ship Mode Performance
SELECT
    ship_mode,
    ROUND(SUM(sales), 2) AS total_revenue,
    ROUND(SUM(profit), 2) AS total_profit,
    SUM(quantity) AS total_units_sold,
    COUNT(DISTINCT order_id) AS total_orders,
    COUNT(DISTINCT customer_id) AS total_customers,
    ROUND((SUM(profit) / SUM(sales)) * 100, 2) AS profit_margin_percentage,
    ROUND(SUM(sales) / COUNT(DISTINCT order_id), 2) AS average_order_value
FROM sales
GROUP BY ship_mode
ORDER BY total_revenue DESC;

-- 14. State Performance
SELECT
    state,
    ROUND(SUM(sales), 2) AS total_revenue,
    ROUND(SUM(profit), 2) AS total_profit,
    SUM(quantity) AS total_units_sold,
    COUNT(DISTINCT order_id) AS total_orders,
    COUNT(DISTINCT customer_id) AS total_customers,
    ROUND((SUM(profit) / SUM(sales)) * 100, 2) AS profit_margin_percentage
FROM sales
GROUP BY state
ORDER BY total_profit DESC;

-- 15. Top Customers by Profit
SELECT
    customer_id,
    customer_name,
    segment,
    ROUND(SUM(sales), 2) AS total_revenue,
    ROUND(SUM(profit), 2) AS total_profit,
    COUNT(DISTINCT order_id) AS total_orders,
    SUM(quantity) AS total_units_sold,
    ROUND(SUM(sales) / COUNT(DISTINCT order_id), 2) AS average_order_value
FROM sales
GROUP BY
    customer_id,
    customer_name,
    segment
ORDER BY total_profit DESC
LIMIT 10;

-- 16. Quarterly Business Performance
SELECT
    YEAR(order_date) AS year,
    QUARTER(order_date) AS quarter,
    ROUND(SUM(sales), 2) AS total_revenue,
    ROUND(SUM(profit), 2) AS total_profit,
    COUNT(DISTINCT order_id) AS total_orders,
    COUNT(DISTINCT customer_id) AS total_customers,
    ROUND((SUM(profit) / SUM(sales)) * 100, 2) AS profit_margin_percentage
FROM sales
GROUP BY
    YEAR(order_date),
    QUARTER(order_date)
ORDER BY
    year,
    quarter;