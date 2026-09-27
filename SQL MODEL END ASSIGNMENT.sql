
-- Database Setup & Data Entry


-- Create Database
CREATE DATABASE online_learning_db;
USE online_learning_db;

-- 1. Create 'learners' table
CREATE TABLE learners (
    learner_id INT PRIMARY KEY,
    full_name VARCHAR(100),
    country VARCHAR(50)
);

-- 2. Create 'courses' table
CREATE TABLE courses (
    course_id INT PRIMARY KEY,
    course_name VARCHAR(100),
    category VARCHAR(50),
    unit_price DECIMAL(10, 2)
);

-- 3. Create 'purchases' table
CREATE TABLE purchases (
    purchase_id INT PRIMARY KEY,
    learner_id INT,
    course_id INT,
    quantity INT,
    purchase_date DATE,
    FOREIGN KEY (learner_id) REFERENCES learners(learner_id),
    FOREIGN KEY (course_id) REFERENCES courses(course_id)
);

-- Insert Sample Data
INSERT INTO learners VALUES 
(1, 'Arun Kumar', 'India'), 
(2, 'John Smith', 'USA'), 
(3, 'Priya Sharma', 'India'), 
(4, 'Emma Watson', 'UK');

INSERT INTO courses VALUES 
(101, 'Python for Beginners', 'Beginner', 5000.00), 
(102, 'Advanced MySQL', 'Advanced', 8000.00), 
(103, 'Web Development', 'Intermediate', 6000.00), 
(104, 'Data Science 101', 'Beginner', 7000.00);

INSERT INTO purchases VALUES 
(1, 1, 101, 2, '2026-01-10'), 
(2, 2, 102, 1, '2026-01-12'), 
(3, 3, 103, 1, '2026-01-15'), 
(4, 1, 104, 1, '2026-01-18'), 
(5, 4, 101, 3, '2026-01-20'), 
(6, 2, 103, 2, '2026-01-22');



-- Data Exploration Using Jion

SELECT 
    l.full_name AS Learner_Name,
    c.course_name AS Course_Name,
    c.category AS Category,
    p.quantity AS Quantity,
    ROUND(p.quantity * c.unit_price, 2) AS Total_Amount,
    p.purchase_date AS Purchase_Date
FROM purchases p
INNER JOIN learners l ON p.learner_id = l.learner_id
INNER JOIN courses c ON p.course_id = c.course_id
ORDER BY Total_Amount DESC;


-- Core Analytical Queries (Q1 - Q5)

-- Q1. Display each learner's total spending with their country:

SELECT l.full_name, l.country, SUM(p.quantity * c.unit_price) AS total_spending 
FROM learners l 
JOIN purchases p ON l.learner_id = p.learner_id 
JOIN courses c ON p.course_id = c.course_id 
GROUP BY l.learner_id, l.full_name, l.country;

-- Q2. Find the top 3 most purchased courses by quantity:

SELECT c.course_name, SUM(p.quantity) AS total_qty 
FROM courses c 
JOIN purchases p ON c.course_id = p.course_id 
GROUP BY c.course_id, c.course_name 
ORDER BY total_qty DESC 
LIMIT 3;

-- Q3. Show each category’s total revenue and number of unique learners:

SELECT c.category, 
       SUM(p.quantity * c.unit_price) AS total_revenue, 
       COUNT(DISTINCT p.learner_id) AS unique_learners 
FROM courses c 
JOIN purchases p ON c.course_id = p.course_id 
GROUP BY c.category;

-- Q4. List learners who purchased from more than one category: 

SELECT l.learner_id, l.full_name 
FROM learners l 
JOIN purchases p ON l.learner_id = p.learner_id 
JOIN courses c ON p.course_id = c.course_id 
GROUP BY l.learner_id, l.full_name 
HAVING COUNT(DISTINCT c.category) > 1;

-- Q5. Identify courses never purchased:

SELECT * FROM courses 
WHERE course_id NOT IN (SELECT DISTINCT course_id FROM purchases);


-- Subqueries & Correlated Subqueries (Q6 - Q8)

-- Q6. Find learners whose total spending is above the average learner spending:

SELECT full_name, total_spend FROM (
    SELECT l.full_name, SUM(p.quantity * c.unit_price) AS total_spend 
    FROM learners l 
    JOIN purchases p ON l.learner_id = p.learner_id 
    JOIN courses c ON p.course_id = c.course_id 
    GROUP BY l.learner_id, l.full_name
) AS t 
WHERE total_spend > (
    SELECT AVG(total_spend) FROM (
        SELECT SUM(p2.quantity * c2.unit_price) AS total_spend 
        FROM learners l2 
        JOIN purchases p2 ON l2.learner_id = p2.learner_id 
        JOIN courses c2 ON p2.course_id = c2.course_id 
        GROUP BY l2.learner_id
    ) AS avg_table
);


-- Q7. Display courses whose price is higher than any course in the 'Beginner' category:

SELECT * FROM courses 
WHERE unit_price > ANY (SELECT unit_price FROM courses WHERE category = 'Beginner');

-- Q8. Find learners who spent more than the average spending in their country:

WITH learner_spend AS (
    SELECT l.learner_id, l.full_name, l.country, SUM(p.quantity * c.unit_price) AS spend 
    FROM learners l 
    JOIN purchases p ON l.learner_id = p.learner_id 
    JOIN courses c ON p.course_id = c.course_id 
    GROUP BY l.learner_id, l.full_name, l.country
), 
country_avg AS (
    SELECT country, AVG(spend) AS avg_spend 
    FROM learner_spend 
    GROUP BY country
) 
SELECT ls.* FROM learner_spend ls 
JOIN country_avg ca ON ls.country = ca.country 
WHERE ls.spend > ca.avg_spend;


-- CTE, CASE, VIEW, And NULL handling (Q9 - Q12)

-- Q9. Use a CTE to calculate total spending per learner, 
-- then display learners with spending above 10,000:

WITH learner_spending AS (
    SELECT l.full_name, SUM(p.quantity * c.unit_price) AS total_spend
    FROM learners l
    JOIN purchases p ON l.learner_id = p.learner_id
    JOIN courses c ON p.course_id = c.course_id
    GROUP BY l.learner_id, l.full_name
)
SELECT full_name, total_spend
FROM learner_spending
WHERE total_spend > 10000;

-- Q10. CASE Expression (Classify learners based on spending):

SELECT l.full_name, 
       SUM(p.quantity * c.unit_price) AS total_spend,
       CASE 
           WHEN SUM(p.quantity * c.unit_price) > 15000 THEN 'High Value'
           WHEN SUM(p.quantity * c.unit_price) BETWEEN 8000 AND 15000 THEN 'Medium Value'
           ELSE 'Low Value'
       END AS spending_category
FROM learners l
JOIN purchases p ON l.learner_id = p.learner_id
JOIN courses c ON p.course_id = c.course_id
GROUP BY l.learner_id, l.full_name;

-- Q11. NULL Handling (Display all courses and replace NULL purchase counts with 0):

SELECT c.course_name, COALESCE(SUM(p.quantity), 0) AS total_purchased_count
FROM courses c
LEFT JOIN purchases p ON c.course_id = p.course_id
GROUP BY c.course_id, c.course_name;

-- Q12. View (category_performance_view): 

CREATE VIEW category_performance_view AS
SELECT c.category, 
       SUM(p.quantity * c.unit_price) AS total_revenue,
       COUNT(p.purchase_id) AS number_of_purchases,
       AVG(p.quantity * c.unit_price) AS average_revenue_per_purchase
FROM courses c
LEFT JOIN purchases p ON c.course_id = p.course_id
GROUP BY c.category;
