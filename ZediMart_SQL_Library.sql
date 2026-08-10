-- SQL Query Library
-- Tool: PostgreSQL
-- Version: 1.0
-- Verified against: PostgreSQL 16
-- Dataset snapshot validated: ZediMart_CSV_Data, six files
-- (Stores, Products, Inventory, Sales, Customers, orders),
-- as supplied on 2026-07-29
-- Last validated: 2026-07-31
-- If the source CSVs are ever replaced or updated, this
-- version header and the Validation and Audit Log should both
-- be re-run and re-dated before any figure here is reused.
-- ============================================================
--
-- NOTE ON DATA STRUCTURE
-- All six source CSVs (Customers, Orders, Products, Inventory,
-- Sales, Stores) were supplied without header rows. Column
-- names below were reconstructed from the case brief's data
-- dictionary and confirmed against actual file contents.
--
-- Phone numbers are stored as VARCHAR, not INT, because several
-- begin with a leading zero (e.g. 08043321819), which would be
-- silently dropped by a numeric type.
--
-- Guiding principle applied throughout this library: reliable
-- decisions begin with validated evidence. Each section below
-- either confirms data integrity directly, or is explicit about
-- what the data cannot yet confirm.
-- ============================================================


-- ============================================================
-- SECTION 1: SCHEMA SETUP
-- ============================================================

DROP TABLE IF EXISTS orders CASCADE;
DROP TABLE IF EXISTS sales CASCADE;
DROP TABLE IF EXISTS inventory CASCADE;
DROP TABLE IF EXISTS customers CASCADE;
DROP TABLE IF EXISTS products CASCADE;
DROP TABLE IF EXISTS stores CASCADE;

CREATE TABLE stores (
    store_id        INT PRIMARY KEY,
    store_name      VARCHAR(100),
    location        VARCHAR(100),
    manager_name    VARCHAR(100)
);

CREATE TABLE products (
    product_id      INT PRIMARY KEY,
    product_name    VARCHAR(100),
    category        VARCHAR(100),
    cost_price      NUMERIC(12,2),
    reorder_level   INT
);

CREATE TABLE inventory (
    product_id          INT REFERENCES products(product_id),
    store_id            INT REFERENCES stores(store_id),
    current_stock       INT,
    last_restock_date   DATE,
    PRIMARY KEY (product_id, store_id)
);

CREATE TABLE sales (
    sale_id         INT PRIMARY KEY,
    store_id        INT REFERENCES stores(store_id),
    product_id      INT REFERENCES products(product_id),
    quantity        INT,
    sale_date       DATE,
    unit_price      NUMERIC(12,2),
    total_amount    NUMERIC(12,2)
);

CREATE TABLE customers (
    customer_id         INT PRIMARY KEY,
    gender              VARCHAR(20),
    age_group           VARCHAR(20),
    preferred_store_id  INT REFERENCES stores(store_id),
    signup_date         DATE,
    full_name           VARCHAR(150),
    phone               VARCHAR(20),
    email               VARCHAR(150)
);

CREATE TABLE orders (
    order_id        INT PRIMARY KEY,
    customer_id     INT REFERENCES customers(customer_id),
    product_id      INT REFERENCES products(product_id),
    quantity        INT,
    order_date      DATE,
    total_amount    NUMERIC(12,2),
    payment_method  VARCHAR(50)
);


-- ============================================================
-- SECTION 2: QUERY LIBRARY
-- Four sections, one per stakeholder question, each testing
-- whether the underlying evidence supports confident reporting.
-- ============================================================


-- ------------------------------------------------------------
-- PART 1: CUSTOMER DATA VALIDATED
-- Stakeholder ask: a unified, deduplicated customer list usable
-- across departments, including Marketing.
-- ------------------------------------------------------------

-- QUERY 1: Duplicate audit across customer ID, email, and phone
-- Business context: rather than assume the customer base needs
-- cleaning because the brief describes fragmented data, this
-- verifies whether duplication actually exists before any
-- cleanup work is proposed.
-- Confirmed result: 500 customers total. Zero duplicate
-- customer_id, zero duplicate email, zero duplicate phone.

SELECT
    COUNT(*)                                       AS total_customers,
    COUNT(*) - COUNT(DISTINCT customer_id)         AS duplicate_customer_ids,
    COUNT(*) - COUNT(DISTINCT email)               AS duplicate_emails,
    COUNT(*) - COUNT(DISTINCT phone)               AS duplicate_phones
FROM customers;


-- QUERY 2: Completeness audit across all customer fields
-- Business context: a customer list is only "usable across
-- departments" if it has no missing values in the fields those
-- departments actually rely on.
-- Confirmed result: zero NULLs across all eight fields, 500 of
-- 500 records complete.

SELECT
    COUNT(*) FILTER (WHERE gender IS NULL)             AS null_gender,
    COUNT(*) FILTER (WHERE age_group IS NULL)          AS null_age_group,
    COUNT(*) FILTER (WHERE preferred_store_id IS NULL) AS null_preferred_store,
    COUNT(*) FILTER (WHERE signup_date IS NULL)        AS null_signup_date,
    COUNT(*) FILTER (WHERE full_name IS NULL)          AS null_full_name,
    COUNT(*) FILTER (WHERE phone IS NULL)              AS null_phone,
    COUNT(*) FILTER (WHERE email IS NULL)              AS null_email
FROM customers;


-- QUERY 3: Unified customer list for cross-departmental use
-- Business context: the actual Marketing/performance-tracking
-- deliverable, a single validated view joined to preferred
-- store, ready to hand to another department without further
-- cleanup.
-- Confirmed result: 500 customers, all ten stores represented
-- as at least one customer's preferred store.

SELECT
    c.customer_id,
    c.full_name,
    c.gender,
    c.age_group,
    s.store_name        AS preferred_store,
    s.location           AS preferred_store_location,
    c.signup_date,
    c.phone,
    c.email
FROM customers c
JOIN stores s ON c.preferred_store_id = s.store_id
ORDER BY c.customer_id;


-- ------------------------------------------------------------
-- PART 2: REVENUE INTERPRETATION VALIDATED
-- Stakeholder ask: a complete, validated view of orders, with
-- payment methods (including unpaid), classified into High,
-- Medium, and Low value brackets.
-- ------------------------------------------------------------

-- QUERY 4: Order-to-customer referential validity
-- Business context: confirms every order can actually be traced
-- to a real customer before any revenue figure built on Orders
-- is treated as reliable.
-- Confirmed result: 1,000 of 1,000 orders reference a valid
-- customer_id. Zero orphaned records.

SELECT
    COUNT(*)                                                       AS total_orders,
    COUNT(*) FILTER (WHERE c.customer_id IS NULL)                  AS orphaned_orders
FROM orders o
LEFT JOIN customers c ON o.customer_id = c.customer_id;


-- QUERY 5: Payment method distribution, including unpaid orders
-- Business context: the brief asks for payment methods
-- "including those not yet paid." The source data has no
-- unpaid/pending status at all, every order carries one of
-- three completed payment methods. This is reported as a
-- finding, not assumed away.
-- Confirmed result: POS 351, Transfer 330, Cash 319. Zero NULL
-- or unpaid payment method values exist in this dataset.

SELECT
    payment_method,
    COUNT(*)                                                       AS order_count,
    ROUND(COUNT(*) * 100.0 / SUM(COUNT(*)) OVER (), 1)             AS pct_of_orders,
    SUM(total_amount)                                              AS revenue
FROM orders
GROUP BY payment_method
ORDER BY order_count DESC;


-- QUERY 6: Order value bracket classification
-- Business context: classifies every order as High, Medium, or
-- Low value against the dataset's own average, rather than an
-- arbitrary fixed cutoff, so the bands stay meaningful if order
-- volumes change over time.
-- Bracket rule: Low = below average; Medium = average up to
-- 1.5x average; High = 1.5x average or above.
-- Confirmed result: average order value N10,447.95. Low 477,
-- Medium 307, High 216 (of 1,000 orders).

SELECT
    CASE
        WHEN total_amount >= (SELECT AVG(total_amount) * 1.5 FROM orders) THEN 'High'
        WHEN total_amount >= (SELECT AVG(total_amount) FROM orders)       THEN 'Medium'
        ELSE 'Low'
    END                                                             AS value_bracket,
    COUNT(*)                                                        AS order_count,
    ROUND(AVG(total_amount), 2)                                     AS avg_value_in_bracket,
    SUM(total_amount)                                               AS total_value_in_bracket
FROM orders
GROUP BY value_bracket
ORDER BY total_value_in_bracket DESC;


-- QUERY 7: Temporal validity of Orders versus Sales
-- Business context: this is the finding the brief did not ask
-- for. Orders and Sales are the two tables that would naturally
-- be combined into one "total revenue" figure for an executive
-- dashboard. Before that happens, this confirms whether they
-- describe the same period at all.
-- Confirmed result: Sales spans 2024-11-01 to 2025-04-30.
-- Orders spans 2026-01-01 to 2026-12-31. Zero overlapping days.
-- 413 of 1,000 orders (41.3%) are dated after 2026-07-30, the
-- date this analysis was performed.

SELECT
    'Sales'                             AS source_table,
    MIN(sale_date)                      AS earliest_date,
    MAX(sale_date)                      AS latest_date,
    SUM(total_amount)                   AS total_revenue
FROM sales

UNION ALL

SELECT
    'Orders'                            AS source_table,
    MIN(order_date)                     AS earliest_date,
    MAX(order_date)                     AS latest_date,
    SUM(total_amount)                   AS total_revenue
FROM orders;


-- ------------------------------------------------------------
-- PART 3: INVENTORY EVIDENCE QUALIFIED BY SCHEMA LIMITATIONS
-- Stakeholder ask: reconcile inventory against products, and
-- flag mismatches, including discontinued items.
-- ------------------------------------------------------------

-- QUERY 8: Inventory-to-product referential check
-- Business context: confirms every inventory record maps to a
-- real, current product before any stock figure is trusted.
-- Confirmed result: 1,000 inventory records (100 products x 10
-- stores), zero referencing a non-existent product.

SELECT
    COUNT(*)                                                       AS total_inventory_records,
    COUNT(*) FILTER (WHERE p.product_id IS NULL)                   AS orphaned_inventory_records
FROM inventory i
LEFT JOIN products p ON i.product_id = p.product_id;


-- QUERY 9: Discontinued-product proxy check, and its limitation
-- Business context: the Products table has no lifecycle or
-- status field, so "discontinued" cannot be flagged directly.
-- The closest honest proxy is a product with zero stock across
-- every store. This query reports that proxy and states its
-- limit plainly: it is a proxy, not a confirmed status.
-- Confirmed result: zero products show zero stock across all
-- ten stores. The lowest total stock for any single product is
-- 527 units. No discontinued candidates surface under this
-- proxy. A product status field is needed to answer this
-- question with certainty.

SELECT
    p.product_id,
    p.product_name,
    SUM(i.current_stock)                                           AS total_stock_all_stores
FROM products p
JOIN inventory i ON p.product_id = i.product_id
GROUP BY p.product_id, p.product_name
HAVING SUM(i.current_stock) = 0
ORDER BY p.product_id;


-- QUERY 10: Reorder level breach by store and product
-- Business context: in the absence of a discontinued flag, this
-- is the real, provable inventory risk in this dataset, stock
-- that has already fallen below the level the business itself
-- defined as the reorder trigger.
-- Confirmed result: 154 of 1,000 store-product combinations
-- (15.4%) currently sit below their defined reorder level.

SELECT
    p.product_id,
    p.product_name,
    i.store_id,
    s.store_name,
    i.current_stock,
    p.reorder_level,
    (p.reorder_level - i.current_stock)                            AS units_below_reorder
FROM inventory i
JOIN products p ON i.product_id = p.product_id
JOIN stores s   ON i.store_id = s.store_id
WHERE i.current_stock < p.reorder_level
ORDER BY units_below_reorder DESC;


-- ------------------------------------------------------------
-- PART 4: EXECUTIVE REPORTING BUILT ON ESTABLISHED MEANING
-- Stakeholder ask: a report of high-performing orders, cleanly
-- cast, ready for the executive dashboard.
-- ------------------------------------------------------------

-- QUERY 11: High-performing orders, above average value
-- Business context: the actual dashboard deliverable requested,
-- with amounts explicitly cast for visualization tooling and
-- confirmed free of NULLs before being handed off.
-- Confirmed result: 523 of 1,000 orders (52.3%) fall above the
-- dataset average of N10,447.95. Zero NULL amounts.

SELECT
    o.order_id,
    o.customer_id,
    c.full_name,
    o.product_id,
    p.product_name,
    o.order_date,
    CAST(o.total_amount AS NUMERIC(12,2))                          AS total_amount,
    o.payment_method
FROM orders o
JOIN customers c ON o.customer_id = c.customer_id
JOIN products p  ON o.product_id = p.product_id
WHERE o.total_amount > (SELECT AVG(total_amount) FROM orders)
ORDER BY o.total_amount DESC;


-- QUERY 12: Reconciliation check, why Orders and Sales cannot
-- simply be summed into one executive revenue figure
-- Business context: this is the capstone of the whole library.
-- Combining Sales revenue and Orders revenue into a single
-- "total revenue" number, the natural first move for a
-- dashboard, would silently merge two periods that never
-- coexisted (see Query 7). This query makes that risk visible
-- rather than letting it happen inside a dashboard visual.
-- Confirmed result: Sales total N7,447,707 (Nov 2024-Apr 2025).
-- Orders total N10,447,947 (all of 2026). A naive combined
-- figure of N17,895,654 would misrepresent both periods as one
-- continuous revenue stream, which the data does not support.

SELECT
    'Sales (Nov 2024 - Apr 2025)'       AS revenue_source,
    SUM(total_amount)                   AS revenue,
    COUNT(*)                            AS transaction_count
FROM sales

UNION ALL

SELECT
    'Orders (2026)'                     AS revenue_source,
    SUM(total_amount)                   AS revenue,
    COUNT(*)                            AS transaction_count
FROM orders

UNION ALL

SELECT
    'Naive combined total (not recommended for reporting)' AS revenue_source,
    (SELECT SUM(total_amount) FROM sales) + (SELECT SUM(total_amount) FROM orders) AS revenue,
    (SELECT COUNT(*) FROM sales) + (SELECT COUNT(*) FROM orders)                    AS transaction_count;


-- ============================================================
-- END OF SQL QUERY LIBRARY
-- ============================================================

-- ============================================================
-- DOCUMENT RELATIONSHIPS
-- Evidence Source: raw ZediMart CSV dataset (six source files)
-- Related Document: none, this is the foundation document
-- Feeds Into: Risk and Opportunity Register, Validation and
-- Audit Log (every figure in both is drawn from this file)
-- ============================================================
