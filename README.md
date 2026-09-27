# 📚 SQL Module End Assignment — Online Learning Database

## 📌 Project Overview

This project is a **SQL Module End Assignment** based on an **Online Learning Database**.

The project demonstrates practical SQL skills by creating a relational database for learners, courses, and purchases, inserting sample data, and performing analytical queries to extract meaningful business insights.

The database includes three main tables:

* `learners`
* `courses`
* `purchases`

Primary keys and foreign keys are used to establish relationships between the tables.

---

## 🎯 Project Objectives

* Create and manage a relational SQL database.
* Design tables with appropriate primary and foreign keys.
* Insert and manage sample data.
* Use SQL joins to combine information from multiple tables.
* Calculate learner spending and course revenue.
* Identify popular and unused courses.
* Apply aggregate functions such as `SUM()`, `AVG()`, and `COUNT()`.
* Use `GROUP BY`, `ORDER BY`, and `HAVING`.
* Apply subqueries and `ANY`.
* Use Common Table Expressions (CTEs).
* Apply `CASE` expressions for classification.
* Handle NULL values using `COALESCE()`.
* Create SQL views for reusable analysis.

---

## 🗄️ Database Structure

### Database

```sql
online_learning_db
```

### Tables

| Table       | Description                       |
| ----------- | --------------------------------- |
| `learners`  | Stores learner information        |
| `courses`   | Stores course details and pricing |
| `purchases` | Stores learner course purchases   |

### Relationships

```text
learners
   │
   │ learner_id
   ▼
purchases
   ▲
   │ course_id
   │
courses
```

The `purchases` table connects learners and courses through foreign keys.

---

## 📊 Sample Data

### Learners

The project contains sample learners from India, USA, and UK.

### Courses

The database includes courses across Beginner, Intermediate, and Advanced categories, including:

* Python for Beginners
* Advanced MySQL
* Web Development
* Data Science 101

Each course has a defined unit price.

### Purchases

Purchase records contain:

* Purchase ID
* Learner ID
* Course ID
* Quantity
* Purchase Date

The sample transactions are dated in January 2026.

---

# 🔍 SQL Analysis

## 1. Data Exploration Using INNER JOIN

The project combines learner, course, and purchase information using `INNER JOIN`.

The analysis calculates:

* Learner name
* Course name
* Category
* Quantity purchased
* Total amount
* Purchase date

Results are ordered by total purchase amount in descending order.

---

# 📈 Core Analytical Queries

## Q1 — Learner Total Spending

Calculates the total amount spent by each learner along with their country.

**SQL Concepts:**

* `JOIN`
* `SUM()`
* `GROUP BY`

---

## Q2 — Top 3 Most Purchased Courses

Identifies the three courses with the highest total purchase quantity.

**SQL Concepts:**

* `SUM()`
* `GROUP BY`
* `ORDER BY`
* `LIMIT`

---

## Q3 — Category Revenue Analysis

Calculates:

* Total revenue by category
* Number of unique learners per category

**SQL Concepts:**

* `SUM()`
* `COUNT(DISTINCT)`
* `GROUP BY`

---

## Q4 — Learners Purchasing from Multiple Categories

Identifies learners who purchased courses from more than one category.

**SQL Concepts:**

* Multiple `JOIN`s
* `COUNT(DISTINCT)`
* `HAVING`

---

## Q5 — Courses Never Purchased

Identifies courses that do not appear in the purchase records.

**SQL Concepts:**

* Subquery
* `NOT IN`

---

# 🧠 Subqueries & Advanced Analysis

## Q6 — Spending Above Average

Finds learners whose total spending is greater than the average spending of all learners.

**SQL Concepts:**

* Nested subqueries
* `AVG()`
* `SUM()`
* Aggregation

---

## Q7 — Courses More Expensive Than Beginner Courses

Identifies courses whose price is higher than **any** course in the Beginner category.

**SQL Concept:**

```sql
ANY
```

---

## Q8 — Spending Above Country Average

Finds learners whose spending is greater than the average spending within their respective country.

This analysis uses two CTEs:

* `learner_spend`
* `country_avg`

---

# 🧩 CTE, CASE, VIEW & NULL Handling

## Q9 — Learners Spending Above 10,000

A CTE calculates total spending for each learner and filters learners whose spending exceeds `10,000`.

**SQL Concept:**

```sql
WITH
```

---

## Q10 — Learner Spending Classification

Learners are classified based on their total spending using a `CASE` expression.

| Spending            | Category     |
| ------------------- | ------------ |
| Greater than 15,000 | High Value   |
| 8,000 – 15,000      | Medium Value |
| Below 8,000         | Low Value    |

---

## Q11 — NULL Handling

Uses `LEFT JOIN` and `COALESCE()` to display all courses and replace NULL purchase quantities with `0`.

```sql
COALESCE(SUM(p.quantity), 0)
```

This ensures courses without purchases can still appear in the results.

---

## Q12 — Category Performance View

Creates a reusable SQL view named:

```sql
category_performance_view
```

The view contains:

* Category
* Total revenue
* Number of purchases
* Average revenue per purchase

---

# 🛠️ SQL Concepts Covered

### Database & Table Management

* `CREATE DATABASE`
* `USE`
* `CREATE TABLE`
* Primary Keys
* Foreign Keys

### Data Manipulation

* `INSERT INTO`
* `SELECT`

### Joins

* `INNER JOIN`
* `LEFT JOIN`

### Aggregation

* `SUM()`
* `AVG()`
* `COUNT()`
* `COUNT(DISTINCT)`

### Filtering & Sorting

* `WHERE`
* `GROUP BY`
* `HAVING`
* `ORDER BY`
* `LIMIT`

### Advanced SQL

* Subqueries
* Nested Queries
* `ANY`
* CTEs
* `CASE`
* `COALESCE()`
* SQL Views

---

# 💡 Key Learning Outcomes

Through this assignment, I practiced:

* Designing a relational database.
* Creating relationships between multiple tables.
* Writing multi-table SQL queries.
* Performing sales and customer analysis.
* Using aggregate functions for business calculations.
* Writing nested and advanced queries.
* Using CTEs to organize complex analysis.
* Handling missing/NULL values.
* Creating reusable SQL views.
* Translating raw transactional data into meaningful analytical results.

---

# 📁 Project Structure

```text
SQL-Module-End-Assignment/
│
├── SQL MODEL END ASSIGNMENT.sql
└── README.md
```

---

# ▶️ How to Run

### 1. Open MySQL Workbench or another MySQL-compatible SQL environment.

### 2. Open:

```text
SQL MODEL END ASSIGNMENT.sql
```

### 3. Execute the database setup:

```sql
CREATE DATABASE online_learning_db;
USE online_learning_db;
```

### 4. Execute the table creation and sample data queries.

### 5. Run the analytical queries Q1–Q12 individually to explore the results.

---

# 🧰 Tools & Technologies

* **MySQL**
* **SQL**
* **MySQL Workbench**
* Relational Database Concepts
* Data Analysis using SQL

---

# 👨‍💻 Author

**Caleb**

This project was created as part of a **SQL Module End Assignment** to demonstrate practical SQL database design, querying, and data analysis skills.

---

⭐ **If you found this project useful, feel free to star the repository!**

