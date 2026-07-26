-- ============================================================
-- NOVAMART: CUSTOMER AND PRODUCT INSIGHT OPTIMIZATION
-- SQL Insight Library
-- Tool: PostgreSQL
-- Reporting Period: August 2024 to May 2025
-- ============================================================
--
-- ONE SOURCE OF TRUTH
-- All queries in this library apply the same three filters
-- used in the Power BI DAX measures and Executive BI Report:
--
--   1. CONFIRMED REVENUE FILTER: payments.is_successful = TRUE
--      This matches the Power BI DAX measure logic exactly.
--
--   2. REPORTING PERIOD FILTER: order_date >= '2024-08-01'
--      AND order_date <= '2025-05-31'
--      August 2024 to May 2025 inclusive. This is the exact
--      window used in all dashboard pages.
--
--   3. BUNDLE G SEPARATION: Bundle G (is_active = FALSE)
--      is excluded from active-bundle category totals and
--      reported separately in the anomaly query (Query 3).
--
-- All figures produced by these queries reconcile with:
--   Confirmed Revenue:  N161,463,248
--   Pending Revenue:    N18,564,696
--   Failed Revenue:     N9,109,526
--   Total Orders:       12,482
--
-- Query numbering below matches the order queries were run
-- and captured in the SQL Insight Library screenshots (Q01
-- through Q11, plus the reconciliation verification query).
-- ============================================================


-- ============================================================
-- SECTION 1: DATABASE SETUP AND SCHEMA
-- ============================================================

-- Run in psql or pgAdmin before the rest:
-- CREATE DATABASE novamart_db;
-- Then connect to novamart_db and run the schema below.

DROP TABLE IF EXISTS support_tickets CASCADE;
DROP TABLE IF EXISTS payments CASCADE;
DROP TABLE IF EXISTS subscriptions CASCADE;
DROP TABLE IF EXISTS bundles CASCADE;
DROP TABLE IF EXISTS customers CASCADE;

CREATE TABLE customers (
    customer_id     INT PRIMARY KEY,
    first_name      VARCHAR(100),
    last_name       VARCHAR(100),
    email           VARCHAR(200),
    gender          VARCHAR(20),
    birth_year      INT,
    city            VARCHAR(100),
    loyalty_tier    VARCHAR(50)
);

CREATE TABLE bundles (
    bundle_id       INT PRIMARY KEY,
    bundle_name     VARCHAR(100),
    category        VARCHAR(100),
    bundle_size     VARCHAR(50),
    is_active       BOOLEAN
);

CREATE TABLE subscriptions (
    subscription_id     INT PRIMARY KEY,
    customer_id         INT REFERENCES customers(customer_id),
    bundle_id           INT REFERENCES bundles(bundle_id),
    subscription_type   VARCHAR(50),
    order_date          DATE,
    quantity            INT,
    unit_price          NUMERIC(12,2),
    discount            NUMERIC(5,2),
    total_value         NUMERIC(12,2)
);

CREATE TABLE payments (
    payment_id          INT PRIMARY KEY,
    subscription_id     INT REFERENCES subscriptions(subscription_id),
    payment_method      VARCHAR(50),
    payment_date        DATE,
    is_successful       BOOLEAN,
    payment_status      VARCHAR(50)
);

CREATE TABLE support_tickets (
    ticket_id           INT PRIMARY KEY,
    customer_id         INT REFERENCES customers(customer_id),
    submission_date     DATE,
    issue_type          VARCHAR(100),
    resolution_status   VARCHAR(50),
    rating              INT
);


-- ============================================================
-- SECTION 2: DATA LOADING
-- ============================================================
-- Update the file paths to match your local directory.
-- Use pgAdmin Import/Export tool or the COPY commands below.

/*
COPY customers FROM '/your/path/customers.csv' CSV HEADER;

COPY bundles FROM '/your/path/bundles.csv' CSV HEADER;

COPY subscriptions (subscription_id, customer_id, bundle_id,
    subscription_type, order_date, quantity, unit_price,
    discount, total_value)
FROM '/your/path/subscriptions.csv'
    CSV HEADER DATEFORMAT 'DD/MM/YYYY';

COPY payments (payment_id, subscription_id, payment_method,
    payment_date, is_successful, payment_status)
FROM '/your/path/payments.csv'
    CSV HEADER DATEFORMAT 'DD/MM/YYYY';

COPY support_tickets FROM '/your/path/support_tickets.csv'
    CSV HEADER;
*/


-- ============================================================
-- SECTION 3: REPORTING PERIOD FILTER (REUSABLE)
-- ============================================================
-- Apply this date filter to every revenue query to match
-- the dashboard reporting window exactly.
-- Copy and paste into your WHERE clause as needed.

-- s.order_date >= '2024-08-01'
-- AND s.order_date <= '2025-05-31'


-- ============================================================
-- SECTION 4: SQL INSIGHT LIBRARY
-- 11 Queries, numbered in execution order, plus one
-- reconciliation verification query
-- All figures reconcile with the Power BI dashboard
-- ============================================================


-- QUERY 1: Top 3 bundles by subscription volume
-- Theme: Bundle and Product Performance
-- Business context: Identifies which products NovaMart
-- customers order most frequently within the reporting period.
-- Confirmed result (Aug 2024 to May 2025):
--   Bundle J: 1,864 orders (14.9%)
--   Bundle I: 1,764 orders (14.1%)
--   Bundle H: 1,571 orders (12.6%)

SELECT
    b.bundle_name,
    b.category,
    b.bundle_size,
    b.is_active,
    COUNT(s.subscription_id)                       AS subscription_count,
    ROUND(
        COUNT(s.subscription_id) * 100.0 /
        SUM(COUNT(s.subscription_id)) OVER (), 1
    )                                              AS pct_of_total
FROM subscriptions s
JOIN bundles b ON s.bundle_id = b.bundle_id
WHERE s.order_date >= '2024-08-01'
  AND s.order_date <= '2025-05-31'
GROUP BY b.bundle_name, b.category, b.bundle_size, b.is_active
ORDER BY subscription_count DESC
LIMIT 3;


-- QUERY 2: Confirmed revenue by active bundle category
-- Theme: Bundle and Product Performance
-- Business context: Reveals which product categories generate
-- real confirmed revenue within the reporting period.
-- Excludes inactive bundles (Bundle G) and unconfirmed payments.
-- Confirmed results (Aug 2024 to May 2025):
--   Wellness:  N62,589,140  (44.1%)
--   Essentials: N50,171,928 (35.4%)
--   Snacks:    N17,360,363  (12.2%)
--   Tech:      N11,691,010  (8.2%)

SELECT
    b.category,
    COUNT(s.subscription_id)                       AS confirmed_orders,
    SUM(s.total_value)                             AS confirmed_revenue,
    ROUND(AVG(s.total_value), 0)                   AS avg_order_value,
    ROUND(
        SUM(s.total_value) * 100.0 /
        SUM(SUM(s.total_value)) OVER (), 1
    )                                              AS revenue_share_pct
FROM subscriptions s
JOIN bundles b  ON s.bundle_id = b.bundle_id
JOIN payments p ON s.subscription_id = p.subscription_id
WHERE p.is_successful = TRUE
  AND b.is_active = TRUE
  AND s.order_date >= '2024-08-01'
  AND s.order_date <= '2025-05-31'
GROUP BY b.category
ORDER BY confirmed_revenue DESC;


-- QUERY 3: Bundle G anomaly -- inactive bundle revenue audit
-- Theme: Bundle and Product Performance
-- Business context: Bundle G is marked inactive but generated
-- N19.7M in confirmed revenue during the reporting period.
-- This surfaces a product catalogue integrity issue requiring
-- immediate business review.
-- Confirmed result (Aug 2024 to May 2025):
--   Bundle G: N19,650,808 confirmed revenue

SELECT
    b.bundle_name,
    b.category,
    b.bundle_size,
    b.is_active,
    COUNT(s.subscription_id)                       AS total_orders,
    SUM(CASE WHEN p.is_successful = TRUE
             THEN s.total_value ELSE 0 END)        AS confirmed_revenue,
    SUM(CASE WHEN p.payment_status = 'Pending'
             THEN s.total_value ELSE 0 END)        AS pending_revenue,
    SUM(CASE WHEN p.payment_status = 'Failed'
             THEN s.total_value ELSE 0 END)        AS failed_revenue
FROM subscriptions s
JOIN bundles b  ON s.bundle_id = b.bundle_id
JOIN payments p ON s.subscription_id = p.subscription_id
WHERE b.is_active = FALSE
  AND s.order_date >= '2024-08-01'
  AND s.order_date <= '2025-05-31'
GROUP BY b.bundle_name, b.category, b.bundle_size, b.is_active
ORDER BY confirmed_revenue DESC;


-- QUERY 4: Average spend per loyalty tier (confirmed orders only)
-- Theme: Customer Intelligence and Loyalty
-- Business context: Determines whether higher-tier customers
-- spend more per order. The near-identical average order value
-- across all three tiers indicates the loyalty programme does
-- not reflect customer spending behaviour.
-- Confirmed results (Aug 2024 to May 2025):
--   Gold avg:     N15,352
--   Platinum avg: N15,114
--   Silver avg:   N15,094

SELECT
    c.loyalty_tier,
    COUNT(s.subscription_id)                       AS confirmed_orders,
    COUNT(DISTINCT s.customer_id)                  AS unique_customers,
    SUM(s.total_value)                             AS confirmed_revenue,
    ROUND(AVG(s.total_value), 0)                   AS avg_order_value,
    ROUND(
        SUM(s.total_value) /
        COUNT(DISTINCT s.customer_id), 0
    )                                              AS avg_revenue_per_customer
FROM subscriptions s
JOIN customers c ON s.customer_id = c.customer_id
JOIN payments p  ON s.subscription_id = p.subscription_id
WHERE p.is_successful = TRUE
  AND s.order_date >= '2024-08-01'
  AND s.order_date <= '2025-05-31'
GROUP BY c.loyalty_tier
ORDER BY avg_order_value DESC;


-- QUERY 5: Issue types by average rating and escalation rate
-- Theme: Support and Customer Experience
-- Business context: Surfaces which complaint categories generate
-- the worst customer experience and are most likely to escalate.
-- No issue type achieves above 3.71 on a 5-point scale.
-- Product Quality has the lowest rating and highest escalation rate.
-- Confirmed results (all tickets):
--   Other:          442 tickets  avg 3.54  escalation 9.0%
--   Product Quality: 460 tickets  avg 3.55  escalation 10.2%
--   Billing Issue:  439 tickets  avg 3.61  escalation 9.8%
--   Late Delivery:  459 tickets  avg 3.71  escalation 9.6%

SELECT
    t.issue_type,
    COUNT(t.ticket_id)                             AS total_tickets,
    ROUND(AVG(t.rating), 2)                        AS avg_rating,
    MIN(t.rating)                                  AS min_rating,
    SUM(CASE WHEN t.resolution_status = 'Escalated'
             THEN 1 ELSE 0 END)                    AS escalated_count,
    ROUND(
        SUM(CASE WHEN t.resolution_status = 'Escalated'
                 THEN 1 ELSE 0 END) * 100.0 /
        COUNT(t.ticket_id), 1
    )                                              AS escalation_rate_pct,
    SUM(CASE WHEN t.resolution_status = 'Resolved'
             THEN 1 ELSE 0 END)                    AS resolved_count,
    SUM(CASE WHEN t.resolution_status = 'Pending'
             THEN 1 ELSE 0 END)                    AS pending_count
FROM support_tickets t
GROUP BY t.issue_type
ORDER BY avg_rating ASC;


-- QUERY 6: Recurring vs one-time revenue split
-- Theme: Customer Intelligence and Loyalty
-- Business context: Determines NovaMart's revenue stability.
-- A high one-time share signals retention risk and revenue
-- volatility that must be re-earned every month.
-- Confirmed results (Aug 2024 to May 2025):
--   Recurring: N112,915,393 (69.9%)
--   One-time:   N48,547,855 (30.1%)

SELECT
    s.subscription_type,
    COUNT(s.subscription_id)                       AS confirmed_orders,
    SUM(s.total_value)                             AS confirmed_revenue,
    ROUND(AVG(s.total_value), 0)                   AS avg_order_value,
    ROUND(
        SUM(s.total_value) * 100.0 /
        SUM(SUM(s.total_value)) OVER (), 1
    )                                              AS revenue_share_pct
FROM subscriptions s
JOIN payments p ON s.subscription_id = p.subscription_id
WHERE p.is_successful = TRUE
  AND s.order_date >= '2024-08-01'
  AND s.order_date <= '2025-05-31'
GROUP BY s.subscription_type
ORDER BY confirmed_revenue DESC;


-- QUERY 7: Confirmed revenue and order volume by city
-- Theme: Customer Intelligence and Loyalty
-- Business context: Identifies NovaMart's strongest geographic
-- markets and surfaces the Abuja performance gap.
-- Confirmed results (Aug 2024 to May 2025):
--   Port Harcourt: N30,229,346 (18.7%) -- leading city
--   Abuja:         weakest market

SELECT
    c.city,
    COUNT(s.subscription_id)                       AS confirmed_orders,
    SUM(s.total_value)                             AS confirmed_revenue,
    ROUND(AVG(s.total_value), 0)                   AS avg_order_value,
    ROUND(
        SUM(s.total_value) * 100.0 /
        SUM(SUM(s.total_value)) OVER (), 1
    )                                              AS city_revenue_share_pct
FROM subscriptions s
JOIN customers c ON s.customer_id = c.customer_id
JOIN payments p  ON s.subscription_id = p.subscription_id
WHERE p.is_successful = TRUE
  AND s.order_date >= '2024-08-01'
  AND s.order_date <= '2025-05-31'
GROUP BY c.city
ORDER BY confirmed_revenue DESC;


-- QUERY 8: Failed payments by method -- revenue loss breakdown
-- Theme: Payment and Revenue Risk
-- Business context: Identifies which payment methods carry the
-- highest failure risk, enabling targeted recovery and mitigation.
-- All failure rates exceed the 2% to 3% industry benchmark.
-- Confirmed results (Aug 2024 to May 2025):
--   Bank Transfer: 202 failed (5.5%) N2,964,372 lost
--   Wallet:        122 failed (4.9%) N1,905,668 lost
--   Card:          293 failed (4.6%) N4,239,487 lost

SELECT
    p.payment_method,
    COUNT(p.payment_id)                            AS total_transactions,
    SUM(CASE WHEN p.payment_status = 'Failed'
             THEN 1 ELSE 0 END)                    AS failed_count,
    SUM(CASE WHEN p.is_successful = TRUE
             THEN 1 ELSE 0 END)                    AS confirmed_count,
    ROUND(
        SUM(CASE WHEN p.payment_status = 'Failed'
                 THEN 1 ELSE 0 END) * 100.0 /
        COUNT(p.payment_id), 1
    )                                              AS failure_rate_pct,
    SUM(CASE WHEN p.payment_status = 'Failed'
             THEN s.total_value ELSE 0 END)        AS revenue_lost
FROM payments p
JOIN subscriptions s ON p.subscription_id = s.subscription_id
WHERE s.order_date >= '2024-08-01'
  AND s.order_date <= '2025-05-31'
GROUP BY p.payment_method
ORDER BY failure_rate_pct DESC;


-- QUERY 9: Pending payment recovery opportunity by method
-- Theme: Payment and Revenue Risk
-- Business context: N18.6M sits in pending status and is
-- recoverable through payment retry infrastructure.
-- Card carries the largest single recovery opportunity.
-- Confirmed results (Aug 2024 to May 2025):
--   Card:          622 pending  N9,604,767 recoverable
--   Bank Transfer: 354 pending  N5,178,594 recoverable
--   Wallet:        250 pending  N3,781,334 recoverable
--   Total:       1,226 pending N18,564,695 recoverable

SELECT
    p.payment_method,
    COUNT(p.payment_id)                            AS pending_count,
    SUM(s.total_value)                             AS recoverable_revenue,
    ROUND(AVG(s.total_value), 0)                   AS avg_pending_order_value
FROM payments p
JOIN subscriptions s ON p.subscription_id = s.subscription_id
WHERE p.payment_status = 'Pending'
  AND s.order_date >= '2024-08-01'
  AND s.order_date <= '2025-05-31'
GROUP BY p.payment_method
ORDER BY recoverable_revenue DESC;


-- QUERY 10: Discount bands and effect on average order value
-- Theme: Discount Impact Analysis
-- Business context: Determines whether NovaMart's discounts
-- are reducing revenue without proportional volume gain.
-- Orders above 20% discount generate N13,630 avg order value,
-- which is N3,029 (18.2%) lower than non-discounted orders.
-- Confirmed results (Aug 2024 to May 2025):
--   No Discount:  208 orders  avg N16,659
--   1% to 10%:  4,284 orders  avg N16,317
--   11% to 20%: 4,268 orders  avg N14,641
--   Above 20%:  1,879 orders  avg N13,630

SELECT
    CASE
        WHEN s.discount = 0    THEN 'No Discount'
        WHEN s.discount <= 0.10 THEN '1% to 10%'
        WHEN s.discount <= 0.20 THEN '11% to 20%'
        ELSE                        'Above 20%'
    END                                            AS discount_band,
    COUNT(s.subscription_id)                       AS confirmed_orders,
    ROUND(AVG(s.discount * 100), 1)                AS avg_discount_pct,
    ROUND(AVG(s.total_value), 0)                   AS avg_order_value,
    SUM(s.total_value)                             AS total_revenue
FROM subscriptions s
JOIN payments p ON s.subscription_id = p.subscription_id
WHERE p.is_successful = TRUE
  AND s.order_date >= '2024-08-01'
  AND s.order_date <= '2025-05-31'
GROUP BY discount_band
ORDER BY avg_order_value DESC;


-- QUERY 11: Monthly confirmed revenue trend
-- Theme: Monthly Revenue Trends
-- Business context: Tracks NovaMart's revenue performance over
-- the full reporting period to identify growth, seasonality,
-- or plateau patterns.
-- Confirmed results: Revenue stable at N15.3M to N17.4M/month.
-- October 2024 is the single strongest month at N17,396,931.

SELECT
    TO_CHAR(s.order_date, 'YYYY-MM')               AS month,
    COUNT(s.subscription_id)                       AS confirmed_orders,
    SUM(s.total_value)                             AS confirmed_revenue,
    ROUND(AVG(s.total_value), 0)                   AS avg_order_value
FROM subscriptions s
JOIN payments p ON s.subscription_id = p.subscription_id
WHERE p.is_successful = TRUE
  AND s.order_date >= '2024-08-01'
  AND s.order_date <= '2025-05-31'
GROUP BY TO_CHAR(s.order_date, 'YYYY-MM')
ORDER BY month;


-- ============================================================
-- RECONCILIATION VERIFICATION QUERY
-- Run this to confirm all three headline figures match
-- the Power BI dashboard exactly.
-- Expected output:
--   confirmed_revenue = 161,463,248
--   pending_revenue   =  18,564,696
--   failed_revenue    =   9,109,526
-- ============================================================

SELECT
    SUM(CASE WHEN p.is_successful = TRUE
             THEN s.total_value ELSE 0 END)        AS confirmed_revenue,
    SUM(CASE WHEN p.payment_status = 'Pending'
             THEN s.total_value ELSE 0 END)        AS pending_revenue,
    SUM(CASE WHEN p.payment_status = 'Failed'
             THEN s.total_value ELSE 0 END)        AS failed_revenue,
    COUNT(CASE WHEN p.is_successful = TRUE
               THEN 1 END)                         AS confirmed_orders,
    COUNT(s.subscription_id)                       AS total_orders
FROM subscriptions s
JOIN payments p ON s.subscription_id = p.subscription_id
WHERE s.order_date >= '2024-08-01'
  AND s.order_date <= '2025-05-31';


-- ============================================================
-- END OF SQL INSIGHT LIBRARY
-- ============================================================
