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