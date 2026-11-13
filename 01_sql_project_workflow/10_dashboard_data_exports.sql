/* 
=================================================
Sales Channel Analysis
=================================================
*/

-- List sales channel, total sales, and percentages
WITH sales_channels AS(
    SELECT
        SUM(warehouse_sales) + SUM(retail_sales) AS total_company_sales,
        SUM(warehouse_sales) AS total_warehouse_sales,
        SUM(retail_sales) AS total_retail_sales
    FROM retail_sales
)
SELECT
    'Company' AS sales_channels,
    total_company_sales AS total_sales,
    ROUND((sc.total_company_sales / sc.total_company_sales)*100.0, 2) AS pct_sales
FROM sales_channels AS sc

UNION ALL

SELECT
    'Warehouse' AS sales_channels,
    total_warehouse_sales AS total_sales,
    ROUND((sc.total_warehouse_sales / sc.total_company_sales)*100.0, 2) AS pct_sales
FROM sales_channels AS sc

UNION ALL

SELECT 
    'Retail' AS sales_channels,
    total_retail_sales AS total_sales,
    ROUND((sc.total_retail_sales / sc.total_company_sales)*100.0, 2) AS pct_sales
FROM sales_channels AS sc;



/* 
=================================================
Supplier Analysis
=================================================
*/

-- Total sales by supplier in each channel
SELECT
    supplier,
    SUM(warehouse_sales) + SUM(retail_sales) AS total_sales,
    SUM(warehouse_sales) AS total_warehouse_sales,
    SUM(retail_sales) AS total_retail_sales
FROM retail_sales
GROUP BY supplier
HAVING SUM(warehouse_sales) + SUM(retail_sales) > 0 
ORDER BY total_sales DESC;



-- Concentration of top suppliers in each sales channel and company
SELECT
    'Company' AS sales_channel,
    7050117.41 AS top10_sales,
    10009643.67 AS total_sales,
    70.43 AS concentration_pct

UNION ALL

SELECT
    'Warehouse' AS sales_channel,
    6179728.68 AS top10_sales,
    7856185.28 AS total_sales,
    78.66 AS concentration_pct

UNION ALL

SELECT
    'Retail' AS sales_channel,
    1022192.37 AS top10_sales,
    2160899.37 AS total_sales,
    47.30 AS concentration_pct;



/* 
=================================================
Item Type Analysis
=================================================
*/

-- Concentration of sales in each channel by item type
WITH item_type_sales AS (
    SELECT
        item_type,
        SUM(retail_sales + warehouse_sales) AS total_sales,
        SUM(warehouse_sales) AS warehouse_sales,
        SUM(retail_sales) AS retail_sales
    FROM retail_sales
    WHERE item_type IS NOT NULL
    GROUP BY item_type
    HAVING SUM(retail_sales + warehouse_sales) > 0
),

total_sales AS (
    SELECT
        SUM(total_sales) AS total_company_sales,
        SUM(warehouse_sales) AS total_warehouse_sales,
        SUM(retail_sales) AS total_retail_sales
    FROM item_type_sales
)

SELECT
    i.item_type,
    i.total_sales,
    ROUND((i.total_sales / t.total_company_sales)*100.0, 2) AS pct_total_sales,
    i.warehouse_sales,
    ROUND((i.warehouse_sales / t.total_warehouse_sales)*100.0, 2) AS pct_warehouse_sales,
    i.retail_sales,
    ROUND((i.retail_sales / t.total_retail_sales)*100.0, 2) AS pct_retail_sales
FROM item_type_sales AS i,
     total_sales AS t;



/* 
=================================================
Product Analysis
=================================================
*/

-- Total sales by products in each channel
SELECT
    item_code,
    item_description,
    SUM(warehouse_sales) + SUM(retail_sales) AS total_sales,
    SUM(warehouse_sales) AS total_warehouse_sales,
    SUM(retail_sales) AS total_retail_sales
FROM retail_sales
GROUP BY item_code, item_description
HAVING SUM(warehouse_sales) + SUM(retail_sales) > 0
ORDER BY total_sales DESC;

-- Concentration of sales in each channel and company
SELECT
    'Company' AS sales_channel,
    1655743.95 AS top10_sales,
    10084638.51 AS total_sales,
    16.42 AS concentration_pct

UNION ALL

SELECT
    'Warehouse' AS sales_channel,
    1550300.43 AS top10_sales,
    7923745.45 AS total_sales,
    19.57 AS concentration_pct

UNION ALL

SELECT
    'Retail' AS sales_channel,
    148430.58 AS top10_sales,
    2160899.92 AS total_sales,
    6.87 AS concentration_pct;