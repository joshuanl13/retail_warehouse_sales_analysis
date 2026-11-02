/*
===================================================
Product Analysis
===================================================
*/



/*
====================================
Top 10 Products by Total Sales
====================================
*/

-- List top 10 products by total sales.
WITH total_top10_products AS(
        SELECT
        item_code,
        SUM(warehouse_sales)+SUM(retail_sales) AS total_sales,
                SUM(warehouse_sales) AS total_warehouse_sales,
        SUM(retail_sales) AS total_retail_sales
    FROM retail_sales
    GROUP BY item_code
    HAVING SUM(warehouse_sales)+SUM(retail_sales) > 0
    ORDER BY total_sales DESC
    LIMIT 10
)
SELECT DISTINCT
    rs.item_code,
    rs.item_description,
    rs.item_type,
    rs.supplier,
    tt10.total_sales,
    tt10.total_warehouse_sales,
    tt10.total_retail_sales
FROM retail_sales AS rs
    INNER JOIN total_top10_products AS tt10 ON tt10.item_code = rs.item_code
ORDER BY tt10.total_sales DESC; 


-- Find the concentration of sales from the top 10 products by total sales.
WITH product_sales AS(
    SELECT
        item_code,
        SUM(warehouse_sales) + SUM(retail_sales) AS product_sales
    FROM retail_sales
    GROUP BY item_code
    HAVING SUM(warehouse_sales) + SUM(retail_sales) > 0   
), top_products AS(
    SELECT
        item_code,
        product_sales AS top10_products_sales
    FROM product_sales
    ORDER BY product_sales DESC
    LIMIT 10
), sales_top_products AS(
    SELECT
        SUM(top10_products_sales) AS total_top10_sales
    FROM top_products
), company_sales AS(
    SELECT 
        SUM(product_sales) AS total_company_sales
    FROM product_sales
)
SELECT
    t10.total_top10_sales,
    c.total_company_sales,
    ROUND((t10.total_top10_sales / c.total_company_sales)*100.0, 2) AS pct_top10_total_sales
FROM sales_top_products AS t10, company_sales AS c;



/*
====================================
Top 10 Products by Warehouse Sales
====================================
*/

-- List top 10 products by warehouse sales.
WITH total_top10_products AS(
        SELECT
        item_code,
        SUM(warehouse_sales) AS total_warehouse_sales
    FROM retail_sales
    GROUP BY item_code
    HAVING SUM(warehouse_sales) > 0
    ORDER BY total_warehouse_sales DESC
    LIMIT 10
)
SELECT DISTINCT
    rs.item_code,
    rs.item_description,
    rs.item_type,
    rs.supplier,
    tt10.total_warehouse_sales
FROM retail_sales AS rs
    INNER JOIN total_top10_products AS tt10 ON tt10.item_code = rs.item_code
ORDER BY tt10.total_warehouse_sales DESC; 


-- Find the concentration of sales from the top 10 products by warehouse sales.
WITH warehouse_product_sales AS(
    SELECT
        item_code,
        SUM(warehouse_sales) AS warehouse_product_sales
    FROM retail_sales
    GROUP BY item_code
    HAVING SUM(warehouse_sales) > 0   
), top_warehouse_products AS(
    SELECT
        item_code,
        warehouse_product_sales AS top10_warehouse_products_sales
    FROM warehouse_product_sales
    ORDER BY warehouse_product_sales DESC
    LIMIT 10
), warehouse_sales_top_products AS(
    SELECT
        SUM(top10_warehouse_products_sales) AS warehouse_top10_sales
    FROM top_warehouse_products
), company_sales AS(
    SELECT 
        SUM(warehouse_product_sales) AS total_warehouse_company_sales
    FROM warehouse_product_sales
)
SELECT
    wht10.warehouse_top10_sales,
    c.total_warehouse_company_sales,
    ROUND((wht10.warehouse_top10_sales / c.total_warehouse_company_sales)*100.0, 2) AS pct_top10_total_warehouse_sales
FROM warehouse_sales_top_products AS wht10, company_sales AS c;



/*
====================================
Top 10 Products by Retail Sales
====================================
*/

-- List top 10 products by retail sales.
WITH total_top10_products AS(
        SELECT
        item_code,
        SUM(retail_sales) AS total_retail_sales
    FROM retail_sales
    GROUP BY item_code
    HAVING SUM(retail_sales) > 0
    ORDER BY total_retail_sales DESC
    LIMIT 10
)
SELECT DISTINCT
    rs.item_code,
    rs.item_description,
    rs.item_type,
    rs.supplier,
    tt10.total_retail_sales
FROM retail_sales AS rs
    INNER JOIN total_top10_products AS tt10 ON tt10.item_code = rs.item_code
ORDER BY tt10.total_retail_sales DESC; 


-- Find the concentration of sales from the top 10 products by retail sales.
WITH retail_product_sales AS(
    SELECT
        item_code,
        SUM(retail_sales) AS retail_product_sales
    FROM retail_sales
    GROUP BY item_code
    HAVING SUM(retail_sales) > 0   
), top_retail_products AS(
    SELECT
        item_code,
        retail_product_sales AS top10_retail_products_sales
    FROM retail_product_sales
    ORDER BY top10_retail_products_sales DESC
    LIMIT 10
), retail_sales_top_products AS(
    SELECT
        SUM(top10_retail_products_sales) AS retail_top10_sales
    FROM top_retail_products
), company_sales AS(
    SELECT 
        SUM(retail_product_sales) AS total_retail_company_sales
    FROM retail_product_sales
)
SELECT
    rt10.retail_top10_sales,
    c.total_retail_company_sales,
    ROUND((rt10.retail_top10_sales / c.total_retail_company_sales)*100.0, 2) AS pct_top10_total_retail_sales
FROM retail_sales_top_products AS rt10, company_sales AS c;