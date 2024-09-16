-- ========================================================
-- Purpose: Collection of queries for customer data analysis including:
--          1. Top 10 countries by customer count
--          2. Top 10 countries and cities by customer count
--          3. Top 5 customers by total amount paid
-- ========================================================


-- ========================================================
-- Query 1: Top 10 Countries by Customer Count
-- This query lists the top 10 countries based on the number of customers.
-- ========================================================
SELECT D.country,
       COUNT(customer_id) AS customer_count
FROM customer A
INNER JOIN address B ON A.address_id = B.address_id
INNER JOIN city C ON B.city_id = C.city_id
INNER JOIN country D ON C.country_id = D.country_ID
GROUP BY country
ORDER BY COUNT(customer_id) DESC
LIMIT 10;

-- ========================================================
-- Query 2: Top 10 Countries and Cities by Customer Count
-- This query lists the top 10 country and city combinations based on the number of customers.
-- ========================================================
SELECT D.country, C.city,
       COUNT(A.customer_id) AS customer_count
FROM customer A
INNER JOIN address B ON A.address_id = B.address_id
INNER JOIN city C ON B.city_id = C.city_id
INNER JOIN country D ON C.country_id = D.country_id
WHERE D.country IN (
    SELECT D.country
    FROM customer A
    INNER JOIN address B ON A.address_id = B.address_id
    INNER JOIN city C ON B.city_id = C.city_id
    INNER JOIN country D ON C.country_id = D.country_id
    GROUP BY D.country
    ORDER BY COUNT(A.customer_id) DESC
    LIMIT 10
)
GROUP BY D.country, C.city
ORDER BY customer_count DESC
LIMIT 10;

-- ========================================================
-- Query 3: Top 5 Customers by Total Amount Paid
-- This query lists the top 5 customers, along with their country and city, 
-- based on the total amount they have paid.
-- ========================================================
SELECT B.customer_id, B.first_name, B.last_name, E.country, D.city, 
       SUM(A.amount) AS total_amount_paid
FROM payment A
INNER JOIN customer B ON A.customer_id = B.customer_id
INNER JOIN address C ON B.address_id = C.address_id
INNER JOIN city D ON C.city_id = D.city_id
INNER JOIN country E ON D.country_id = E.country_id
WHERE (E.country, D.city) IN (
    SELECT D.country, C.city
    FROM customer A
    INNER JOIN address B ON A.address_id = B.address_id
    INNER JOIN city C ON B.city_id = C.city_id
    INNER JOIN country D ON C.country_id = D.country_id
    GROUP BY D.country, C.city
    ORDER BY COUNT(A.customer_id) DESC
    LIMIT 10
)
GROUP BY B.customer_id, B.first_name, B.last_name, E.country, D.city
ORDER BY total_amount_paid DESC
LIMIT 5;
