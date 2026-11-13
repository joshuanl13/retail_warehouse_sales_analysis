/*
====================================
Column Profiling
====================================
*/


/*
==================
year
==================
*/

-- List unique years.
SELECT DISTINCT year
FROM retail_sales;



/*
==================
month
==================
*/

-- List nuique months.
SELECT DISTINCT month
FROM retail_sales;

-- List unique month values each year.
SELECT DISTINCT
    year,
    month 
FROM retail_sales;



/*
==================
supplier
==================
*/

-- Count unique suppliers.
SELECT COUNT(DISTINCT supplier)
FROM retail_sales;

-- Investigate row(s) where there are missing supplier values.
SELECT *
FROM retail_sales
WHERE supplier IS NULL;



/*
==================
item_code
==================
*/

-- Count unique item codes.
SELECT COUNT(DISTINCT item_code)
FROM retail_sales;



/*
==================
item_description
==================
*/

-- Count unique item descriptions.
SELECT COUNT(DISTINCT item_description)
FROM retail_sales;

-- Investigate why number of unique item descriptions do not match number of unique item codes.
-- Count number of codes that are mapped to more than one item description.
SELECT COUNT(*)
FROM(
    SELECT
        item_code,
        COUNT(DISTINCT item_description) AS description_count
    FROM retail_sales
    GROUP BY item_code
    HAVING COUNT(DISTINCT item_description)>1
    ) multi;

-- Investigate item codes with multiple item descriptions to find the issue.
SELECT DISTINCT
    item_code,
    item_description
FROM retail_sales
WHERE item_code IN (
    SELECT
        item_code
    FROM retail_sales
    GROUP BY item_code
    HAVING COUNT(DISTINCT item_description)>1
)
ORDER BY item_code, item_description;



/*
==================
item_type
==================
*/

-- List unique item types.
SELECT DISTINCT item_type
FROM retail_sales;

-- Investigate row(s) where there are missing item_type values.
SELECT *
FROM retail_sales
WHERE item_type IS NULL;



/*
==================
retail_sales
==================
*/

-- Generate summary statistics of retail_sales.
SELECT
    COUNT(retail_sales) AS count_retail_sales,
    MIN(retail_sales) AS min_retail_sales,
    MAX(retail_sales) AS max_retail_sales,
    SUM(retail_sales) AS total_retail_sales,
    AVG(retail_sales) AS avg_retail_sales
FROM retail_sales;

-- Investigate row(s) where there are missing retail_sales values.
SELECT *
FROM retail_sales
WHERE retail_sales IS NULL;



/*
==================
retail_transfers
==================
*/

-- Generate summary statistics of retail_transfers. 
SELECT
    COUNT(retail_transfers) AS count_retail_transfers,
    MIN(retail_transfers) AS min_retail_transfers,
    MAX(retail_transfers) AS max_retail_transfers,
    SUM(retail_transfers) AS sum_retail_transfers,
    AVG(retail_transfers) AS avg_retail_transfers
FROM retail_sales;



/*
==================
warehouse_sales
==================
*/

-- Generate summary statistics of warehouse_sales.
SELECT
    COUNT(warehouse_sales) AS count_warehouse_sales,
    MIN(warehouse_sales) AS min_warehouse_sales,
    MAX(warehouse_sales) As max_warehouse_sales,
    AVG(warehouse_sales) AS avg_warehouse_sales,
    SUM(warehouse_sales) As sum_warehouse_sales
FROM retail_sales;