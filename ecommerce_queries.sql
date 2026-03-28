---order total as SUM(order_items.quantity * order_items.unit_price) per order
SELECT order_id,SUM(quantity * unit_price) AS order_total
FROM order_items
GROUP BY order_id
ORDER BY order_id;

---Top 3 customers by spending
SELECT TOP 3 C.C_name, SUM(p.amount) AS total_spent
FROM CUSTOMERS C
JOIN orders o ON c.customer_id = o.customer_id
JOIN payments p ON o.order_id = p.order_id
WHERE p.status = 'succeeded'
GROUP BY C.C_name
ORDER BY total_spent DESC;

---Orders above average
SELECT order_id,SUM(quantity * unit_price) AS total
FROM order_items
GROUP BY order_id
HAVING SUM(quantity * unit_price) >
(SELECT AVG(total)FROM(
SELECT SUM(quantity * unit_price) AS total
FROM order_items
GROUP BY order_id
) t
);

---Customers with orders in last 6 months
SELECT DISTINCT C.C_name
FROM CUSTOMERS C
JOIN orders o
ON C.customer_id = o.customer_id
WHERE o.order_date >= DATEADD(MONTH,-6,GETDATE());

----Categorize customers by frequency with CASE
SELECT C.C_name,
COUNT(o.order_id) AS total_orders,
CASE
WHEN COUNT(o.order_id) >= 5 THEN 'Frequent'
WHEN COUNT(o.order_id) BETWEEN 2 AND 4 THEN 'Regular'
ELSE 'New'
END AS customer_type

FROM CUSTOMERS C
LEFT JOIN orders o
ON C.customer_id = o.customer_id

GROUP BY C.C_name;


-----Top Selling Products
SELECT 
p.p_name,
SUM(oi.quantity) AS total_sold
FROM products p
JOIN order_items oi
ON p.product_id = oi.product_id
GROUP BY p.p_name
ORDER BY total_sold DESC;


------Total sales per month (Monthly Revenue)

SELECT 
YEAR(payment_date) AS year,
MONTH(payment_date) AS month,
SUM(amount) AS total_revenue
FROM payments
WHERE status = 'succeeded'
GROUP BY YEAR(payment_date), MONTH(payment_date)
ORDER BY year, month;
