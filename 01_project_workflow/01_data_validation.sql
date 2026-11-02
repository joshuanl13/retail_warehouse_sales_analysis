/*
===============================
Data Validation
===============================
*/

--Count rows of data.
SELECT COUNT(*)
FROM retail_sales;



-- Find if there are any duplicate rows of data.
SELECT
    year,
    month,
    supplier,
    item_code,
    item_description,
    item_type,
    retail_sales,
    retail_transfers,
    warehouse_sales,
    COUNT(*)
FROM retail_sales
GROUP BY
    year,
    month,
    supplier,
    item_code,
    item_description,
    item_type,
    retail_sales,
    retail_transfers,
    warehouse_sales
HAVING COUNT(*) > 1;



-- Find any NULLs in each column.
-- Count missing year values.
SELECT COUNT(*)
FROM retail_sales
WHERE year IS NULL;



-- Count missing month values.
SELECT COUNT(*)
FROM retail_sales
WHERE month IS NULL;



-- Count missing supplier values.
SELECT COUNT(*)
FROM retail_sales
WHERE supplier IS NULL;



-- Count missing item_code values.
SELECT COUNT(*)
FROM retail_sales
WHERE item_code IS NULL;



-- Count missing item_description values.
SELECT COUNT(*)
FROM retail_sales
WHERE item_description IS NULL;



-- Count missing item_type values.
SELECT COUNT(*)
FROM retail_sales
WHERE item_type IS NULL;



-- Count missing retail_sales values.
SELECT COUNT(*)
FROM retail_sales
WHERE retail_sales IS NULL;



-- Count missing retail_transfers values.
SELECT COUNT(*)
FROM retail_sales
WHERE retail_transfers IS NULL;



-- Count missing warehouse_sales values.
SELECT COUNT(*)
FROM retail_sales
WHERE warehouse_sales IS NULL;