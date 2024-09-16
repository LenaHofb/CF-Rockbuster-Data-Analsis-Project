-- ========================================================
-- Customer Analysis Queries
-- Purpose: Collection of queries for customer data analysis including:
--          1. Average amount paid by the top 5 customers
--          2. Number of top 5 customers based within each country
-- ========================================================

-- ========================================================
-- Step 1: Find the average amount paid by the top 5 customers
-- This query calculates the average amount paid by the top 5 customers
-- ========================================================

SELECT AVG(total_amount_paid.total_amount_paid) AS average
FROM (
    SELECT 
        B.customer_id, 
        B.first_name, 
        B.last_name, 
        E.country, 
        D.city, 
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
        WHERE D.country IN (
            SELECT D.country
            FROM customer A
            JOIN address B ON A.address_id = B.address_id
            JOIN city C ON B.city_id = C.city_id
            JOIN country D ON C.country_id = D.country_id
            GROUP BY D.country
            ORDER BY COUNT(A.customer_id) DESC
            LIMIT 10
        )
        GROUP BY D.country, C.city
        ORDER BY COUNT(A.customer_id) DESC
        LIMIT 10
    )
    GROUP BY B.customer_id, B.first_name, B.last_name, E.country, D.city
    ORDER BY total_amount_paid DESC
    LIMIT 5
) AS total_amount_paid;

-- ========================================================
-- Step 2: Find the count of the top 5 customers in each country
-- This query finds how many of the top 5 customers (from step 1) are based within each country
-- ========================================================

SELECT 
    outer_query.country,
    COUNT(DISTINCT outer_query.customer_id) AS all_customer_count,
    COUNT(DISTINCT top_5_customers.customer_id) AS top_customer_count
FROM (
    -- Outer query to get all customers by country
    SELECT 
        E.country,  
        B.customer_id
    FROM customer B
    INNER JOIN address C ON B.address_id = C.address_id
    INNER JOIN city D ON C.city_id = D.city_id
    INNER JOIN country E ON D.country_id = E.country_id
) AS outer_query
LEFT JOIN (
    -- Subquery to get top 5 customers by total amount paid
    SELECT 
        B.customer_id,
        E.country,
        SUM(A.amount) AS total_amount_paid
    FROM payment A
    INNER JOIN customer B ON A.customer_id = B.customer_id
    INNER JOIN address C ON B.address_id = C.address_id
    INNER JOIN city D ON C.city_id = D.city_id
    INNER JOIN country E ON D.country_id = E.country_id
    WHERE (E.country, D.city) IN (
        SELECT 
            D.country, 
            C.city
        FROM customer A
        INNER JOIN address B ON A.address_id = B.address_id
        INNER JOIN city C ON B.city_id = C.city_id
        INNER JOIN country D ON C.country_id = D.country_id
        WHERE D.country IN (
            SELECT D.country
            FROM customer A
            JOIN address B ON A.address_id = B.address_id
            JOIN city C ON B.city_id = C.city_id
            JOIN country D ON C.country_id = D.country_id
            GROUP BY D.country
            ORDER BY COUNT(A.customer_id) DESC
            LIMIT 10
        )
        GROUP BY D.country, C.city
        ORDER BY COUNT(A.customer_id) DESC
        LIMIT 10
    )
    GROUP BY B.customer_id, E.country
    ORDER BY total_amount_paid DESC
    LIMIT 5
) AS top_5_customers
ON outer_query.country = top_5_customers.country
GROUP BY outer_query.country
ORDER BY all_customer_count DESC, top_customer_count DESC;
