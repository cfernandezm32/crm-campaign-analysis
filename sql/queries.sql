-- =========================================
-- CRM Campaign Analysis
-- QuickBite
-- Author: Camila Fernández
-- =========================================

-- Business Question 1:
-- How many users are registered?

SELECT COUNT(*) AS total_users
FROM users;
-- There are 250 registered users. This represents the total potential audience for CRM campaigns.
-- ==========================================================
-- BUSINESS QUESTION 2
-- How many purchases have been made?
-- ==========================================================

SELECT COUNT(*) AS total_purchases
FROM purchases;


-- ==========================================================
-- BUSINESS QUESTION 3
-- How much total revenue has the company generated?
-- ==========================================================

SELECT SUM(amount) AS total_revenue
FROM purchases;


-- ==========================================================
-- BUSINESS QUESTION 4
-- What is the average purchase value?
-- ==========================================================

SELECT AVG(amount) AS average_purchase
FROM purchases;


-- ==========================================================
-- BUSINESS QUESTION 5
-- Which cities have the largest number of registered users?
-- ==========================================================

SELECT
    city,
    COUNT(*) AS total_users
FROM users
GROUP BY city
ORDER BY total_users DESC;

-- CUSTOMER ANALYSIS
-- ==========================================================

-- ----------------------------------------------------------
-- Business Question 6
-- How many unique users have made at least one purchase?
-- ----------------------------------------------------------

SELECT
    COUNT(DISTINCT user_id) AS users_with_purchase
FROM purchases;

--Only 62% of registered users have completed a purchase. This indicates an opportunity to create onboarding or activation campaigns.
-- ----------------------------------------------------------
-- Business Question 7
-- Which users have never made a purchase?
-- ----------------------------------------------------------

SELECT
    u.user_id,
    u.name,
    u.city,
    u.registration_date
FROM users AS u
LEFT JOIN purchases AS p
    ON u.user_id = p.user_id
WHERE p.user_id IS NULL;


-- ----------------------------------------------------------
-- Business Question 8
-- What is the conversion rate?
--
-- Formula:
-- (Users with at least one purchase / Total registered users) * 100
-- ----------------------------------------------------------

SELECT
    ROUND(
        (
            COUNT(DISTINCT p.user_id) * 100.0
        ) /
        (
            SELECT COUNT(*)
            FROM users
        ),
        2
    ) AS conversion_rate_percentage
FROM purchases AS p;
