CREATE DATABASE E_COMMERCE

USE E_COMMERCE;

CREATE TABLE CUSTOMERS 
( customer_id  INT PRIMARY KEY , C_name VARCHAR(50), email VARCHAR(250) UNIQUE, created_at DATE, city VARCHAR(50), country VARCHAR(50))

CREATE TABLE products
(product_id INT  IDENTITY (1,1)PRIMARY KEY, p_name VARCHAR(50) , category VARCHAR(50) , price DECIMAL(10,2) , active BIT   )

CREATE TABLE orders
(order_id INT IDENTITY (1,1) PRIMARY KEY, customer_id INT , order_date DATE , status VARCHAR(250) , 
FOREIGN KEY (customer_id) REFERENCES CUSTOMERS(customer_id) )

CREATE TABLE order_items
(order_item_id INT  IDENTITY (1,1)PRIMARY KEY , order_id INT , product_id INT , quantity INT , unit_price DECIMAL(10,2) ,
FOREIGN KEY (order_id) REFERENCES orders(order_id)  , FOREIGN KEY (product_id) REFERENCES products(product_id) )

CREATE TABLE payments
(payment_id  INT IDENTITY(1,1) PRIMARY KEY, order_id INT , amount DECIMAL(10,2) , payment_date DATE , method VARCHAR(100), status VARCHAR(50) , 
FOREIGN KEY (order_id) REFERENCES orders(order_id) )


INSERT INTO CUSTOMERS (customer_id, C_name , email , created_at , city , country ) 
VALUES (1 ,'ALI ALI','ALI@GMAIL.COM','2022-2-3','CAIRO','EGYPT') , 
       (2 , 'OMAR GABER','OMAR@GMAIL.COM','2025-7-30','ALEX','EGYPT'),
	   (3 , 'JON SMITH','JON@GMAIL.COM','2020-3-2','LONDON','ENGLAND'),
	   (4 , 'SARA KHALED','SARA@GMAIL.COM','2021-9-9','LOS ANGELOS','USA'),
	   (5 , 'Youssef Khaled','youssef@gmail.com','2023-05-05','Tanta','Egypt'),
       (6 , 'Laila Samy','laila@gmail.com','2023-06-10','Mansoura','Egypt'),
       (7 , 'Hany Ibrahim','hany@gmail.com','2023-07-11','Cairo','Egypt'),
       (8 , 'Nour Ali','nour@gmail.com','2023-08-19','Giza','Egypt'),
       (9 , 'Karim Said','karim@gmail.com','2023-09-02','Alexandria','Egypt'),
       (10 ,'Salma Mostafa','salma@gmail.com','2023-10-08','Cairo','Egypt');

INSERT INTO products (p_name, category, price, active )
VALUES  ('Laptop','Electronics',15000,1),
		('Headphones','Electronics',800,1),
		('Keyboard','Electronics',500,1),
		('Mouse','Electronics',300,1),
		('Office Chair','Furniture',2500,1),
		('Desk Lamp','Furniture',400,1);

INSERT INTO orders (customer_id , order_date , status)
VALUES  (1,'2024-01-10','completed'),
		(2,'2024-01-15','completed'),
		(3,'2024-02-01','completed'),
		(1,'2024-02-10','completed'),
		(4,'2024-02-18','cancelled'),
		(5,'2024-03-02','completed'),
		(6,'2024-03-10','completed'),
		(7,'2024-03-15','completed'),
		(8,'2024-03-20','completed'),
		(9,'2024-03-25','completed'),
		(10,'2024-04-01','completed'),
		(3,'2024-04-05','completed');

SELECT * FROM dbo.CUSTOMERS;

insert into orders ( customer_id,order_date,status)
values (2,'2022-11-26','canceled')


INSERT INTO order_items (order_id, product_id, quantity, unit_price)
VALUES
(1,1,1,15000),
(1,2,1,800),
(2,3,1,500),
(2,4,2,300),
(3,2,1,800),
(3,5,1,2500),
(4,4,1,300),
(4,3,1,500),
(5,5,1,2500),
(6,6,2,400),
(7,2,1,800),
(7,4,2,300),
(8,1,1,15000),
(9,3,2,500),
(10,4,3,300),
(11,6,1,400),
(11,2,1,800),
(12,1,1,15000),
(12,3,1,500),
(12,4,1,300);

INSERT INTO payments (order_id,amount,payment_date,method,status)
VALUES
(1,15800,'2024-01-10','credit_card','succeeded'),
(2,500,'2024-01-15','paypal','succeeded'),
(3,1600,'2024-02-01','credit_card','succeeded'),
(4,800,'2024-02-10','credit_card','succeeded'),
(5,2500,'2024-02-18','credit_card','failed'),
(6,800,'2024-03-02','paypal','succeeded'),
(7,1400,'2024-03-10','credit_card','succeeded'),
(8,15000,'2024-03-15','credit_card','succeeded'),
(9,1000,'2024-03-20','paypal','succeeded'),
(10,900,'2024-03-25','credit_card','succeeded'),
(11,1200,'2024-04-01','credit_card','succeeded'),
(12,17000,'2024-04-05','paypal','succeeded');

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





