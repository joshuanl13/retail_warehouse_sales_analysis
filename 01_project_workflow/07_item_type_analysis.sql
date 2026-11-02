/*
===================================================
Item Type Analysis
===================================================
*/



/*
=============================================
Item Types Ranked by Total Sales
=============================================
*/

-- Rank item types by total sales.
SELECT
    item_type,
    SUM(warehouse_sales)+SUM(retail_sales) AS total_sales
FROM retail_sales
WHERE item_type IS NOT NULL
GROUP BY item_type
HAVING SUM(warehouse_sales)+SUM(retail_sales) > 0
ORDER BY total_sales DESC;


-- Find the concentration of total sales by item type.
WITH item_type_sales AS (
    SELECT
        item_type,
        SUM(retail_sales + warehouse_sales) AS total_sales
    FROM retail_sales
    WHERE item_type IS NOT NULL
    GROUP BY item_type
    HAVING SUM(retail_sales + warehouse_sales) > 0
),

company_total AS (
    SELECT
        SUM(total_sales) AS company_sales
    FROM item_type_sales
)

SELECT
    i.item_type,
    i.total_sales,
    ROUND((i.total_sales / c.company_sales)*100.0, 2) AS pct_total_sales
FROM item_type_sales AS i,
     company_total AS c
ORDER BY i.total_sales DESC;




/*
=============================================
Item Types Ranked by Warehouse Sales
=============================================
*/


-- Rank item type by warehouse sales.
SELECT
    item_type,
    SUM(warehouse_sales) AS warehouse_sales
FROM retail_sales
WHERE item_type IS NOT NULL
GROUP BY item_type
HAVING SUM(warehouse_sales) > 0
ORDER BY warehouse_sales DESC;

-- Find the concentration of warehouse sales by item type.
WITH item_type_sales AS (
    SELECT
        item_type,
        SUM(warehouse_sales) AS warehouse_sales
    FROM retail_sales
    WHERE item_type IS NOT NULL
    GROUP BY item_type
    HAVING SUM(warehouse_sales) > 0
),

warehouse_total AS (
    SELECT
        SUM(warehouse_sales) AS warehouse_sales
    FROM item_type_sales
)

SELECT
    i.item_type,
    i.warehouse_sales,
    ROUND((i.warehouse_sales / w.warehouse_sales)*100.0, 2) AS pct_warehouse_sales
FROM item_type_sales AS i,
     warehouse_total AS w
ORDER BY i.warehouse_sales DESC;




/*
=============================================
Item Types Ranked by Retail Sales
=============================================
*/


-- Rank item type by retail sales.
SELECT
    item_type,
    SUM(retail_sales) AS retail_sales
FROM retail_sales
WHERE item_type IS NOT NULL
GROUP BY item_type
HAVING SUM(retail_sales) > 0
ORDER BY retail_sales DESC;


-- Find the concentration of retail sales by item type.
WITH item_type_retail_sales AS (
    SELECT
        item_type,
        SUM(retail_sales) AS total_retail_sales
    FROM retail_sales
    WHERE item_type IS NOT NULL
    GROUP BY item_type
    HAVING SUM(retail_sales) > 0
), retail_total AS (
    SELECT
        SUM(total_retail_sales) AS retail_sales
    FROM item_type_retail_sales
)
SELECT
    i.item_type,
    i.total_retail_sales,
    ROUND((i.total_retail_sales / r.retail_sales)*100.0, 2) AS pct_retail_sales
FROM item_type_retail_sales AS i, retail_total AS r
ORDER BY i.total_retail_sales DESC;