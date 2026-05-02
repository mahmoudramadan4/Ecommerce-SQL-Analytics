E-Commerce SQL Project

A relational database project built with **Microsoft SQL Server (T-SQL)** that simulates a real-world e-commerce system — covering database design, data insertion, and analytical queries.

---

Project Overview

This project demonstrates core **data engineering and SQL skills** by designing and querying an e-commerce database from scratch. It includes schema design, realistic sample data, and a set of business-driven analytical queries.

---

Database Schema

The database consists of **5 related tables**:

```
CUSTOMERS ──< ORDERS ──< ORDER_ITEMS >── PRODUCTS
                │
             PAYMENTS
```

| Table | Description |
|-------|-------------|
| `CUSTOMERS` | Stores customer profiles (name, email, city, country) |
| `PRODUCTS` | Product catalog with category, price, and active status |
| `ORDERS` | Customer orders with date and fulfillment status |
| `ORDER_ITEMS` | Line items linking orders to products (quantity & price) |
| `PAYMENTS` | Payment records with method and success status |

### Entity-Relationship Highlights
- A **customer** can place many **orders**
- An **order** can contain many **order items** (products)
- Each **order** has a corresponding **payment** record
- Foreign key constraints enforce referential integrity throughout

---

Analytical Queries

The project includes **6 business-driven SQL queries**:

| # | Query | Technique Used |
|---|-------|----------------|
| 1 | Order total per order | `GROUP BY`, `SUM()` |
| 2 | Top 3 customers by spending | `JOIN`, `TOP`, `ORDER BY DESC` |
| 3 | Orders above average order value | Subquery, `HAVING`, `AVG()` |
| 4 | Customers with orders in last 6 months | `DATEADD()`, `GETDATE()` |
| 5 | Customer segmentation by order frequency | `CASE WHEN`, `LEFT JOIN` |
| 6 | Monthly revenue report | `YEAR()`, `MONTH()`, `GROUP BY` |

---

How to Run

1. Open **SQL Server Management Studio (SSMS)** or any T-SQL compatible client
2. Run the script in order — it will:
   - Create the `E_COMMERCE` database
   - Define all tables and constraints
   - Insert sample data
   - Execute all analytical queries

```sql
-- Just open and run:
E_COMMERCE_SQL_PROJECT.sql
```

**Note:** This project uses **T-SQL syntax** (Microsoft SQL Server). Some functions like `GETDATE()`, `DATEADD()`, `IDENTITY`, and `TOP` are SQL Server–specific.

---

Tech Stack

- **Database:** Microsoft SQL Server
- **Language:** T-SQL (Transact-SQL)
- **Tool:** SQL Server Management Studio (SSMS)

---


Key Concepts Practiced

- Relational database design & normalization
- Primary and foreign key constraints
- Aggregate functions (`SUM`, `AVG`, `COUNT`)
- Multi-table `JOIN` operations
- Subqueries and `HAVING` clauses
- Date functions for time-based filtering
- `CASE WHEN` for conditional logic / customer segmentation
- Revenue analysis by time period

---

About

This is my **first project** in my data engineering learning journey. It reflects my understanding of relational databases, SQL querying, and analytical thinking applied to a real-world business scenario.

Feel free to explore, fork, or suggest improvements

---

Contact

If you'd like to connect or give feedback, feel free to reach out via GitHub.

---
Mahmoud El-Awam Aspiring Data Engineer



