/*
===================================================
Supplier Analysis
===================================================
*/



/*
====================================
Top 10 Suppliers by Total Sales
====================================
*/

-- List top 10 suppliers by total sales.
SELECT
    supplier,
    SUM(warehouse_sales) + SUM(retail_sales) AS total_sales
FROM retail_sales
GROUP BY supplier
HAVING SUM(warehouse_sales) + SUM(retail_sales) > 0
ORDER BY total_sales DESC
LIMIT 10;


-- Find the concentration of sales from the top 10 suppliers by total sales.
WITH supplier_sales AS(
    SELECT
        supplier,
        SUM(warehouse_sales) + SUM(retail_sales) AS total_sales
    FROM retail_sales
    GROUP BY supplier
    HAVING SUM(warehouse_sales) + SUM(retail_sales) > 0
), top_suppliers AS(
    SELECT
        supplier,
        total_sales
    FROM supplier_sales
    ORDER BY total_sales DESC
    LIMIT 10
), top_suppliers_total_sales AS (
    SELECT
        SUM(total_sales) AS total_top_suppliers
    FROM top_suppliers
), overall_supplier_sales AS(
    SELECT
        SUM(total_sales) AS total_supplier_sales
    FROM supplier_sales
)
SELECT 
    o.total_supplier_sales,
    t10.total_top_suppliers,
    ROUND((t10.total_top_suppliers / o.total_supplier_sales)*100.0, 2) AS pct_total_top_supplier_sales
FROM top_suppliers_total_sales AS t10, overall_supplier_sales AS o;





/*
====================================
Top 10 Suppliers by Warehouse Sales
====================================
*/

-- List top 10 suppliers by warehouse sales.
SELECT
    supplier,
    SUM(warehouse_sales) AS warehouse_supplier_sales
FROM retail_sales
GROUP BY supplier
HAVING SUM(warehouse_sales) > 0
ORDER BY warehouse_supplier_sales DESC
LIMIT 10;



-- Find the concentration of sales from the top 10 suppliers by warehouse sales.
WITH supplier_warehouse_sales AS(
    SELECT
        supplier,
        SUM(warehouse_sales) AS warehouse_sales
    FROM retail_sales
    GROUP BY supplier
    HAVING SUM(warehouse_sales) > 0
), top_suppliers AS(
    SELECT
        supplier,
        warehouse_sales
    FROM supplier_warehouse_sales
    ORDER BY warehouse_sales DESC
    LIMIT 10
), top_suppliers_warehouse_sales AS (
    SELECT
        SUM(warehouse_sales) AS warehouse_top_suppliers
    FROM top_suppliers
), overall_warehouse_supplier_sales AS(
    SELECT
        SUM(warehouse_sales) AS total_warehouse_supplier_sales
    FROM supplier_warehouse_sales
)
SELECT 
    o.total_warehouse_supplier_sales,
    t10.warehouse_top_suppliers,
    ROUND((t10.warehouse_top_suppliers / o.total_warehouse_supplier_sales)*100.0, 2) AS pct_warehouse_top_supplier_sales
FROM top_suppliers_warehouse_sales AS t10, overall_warehouse_supplier_sales AS o;



/*
====================================
Top 10 Suppliers by Retail Sales
====================================
*/

-- List top 10 suppliers by retail sales.
SELECT
    supplier,
    SUM(retail_sales) AS retail_supplier_sales
FROM retail_sales
GROUP BY supplier
HAVING SUM(retail_sales) > 0
ORDER BY retail_supplier_sales DESC
LIMIT 10;



-- Find the concentration of sales from the top 10 suppliers by retail sales.
WITH supplier_retail_sales AS(
    SELECT
        supplier,
        SUM(retail_sales) AS retail_sales
    FROM retail_sales
    GROUP BY supplier
    HAVING SUM(retail_sales) > 0
), top_suppliers AS(
    SELECT
        supplier,
        retail_sales
    FROM supplier_retail_sales
    ORDER BY retail_sales DESC
    LIMIT 10
), top_suppliers_retail_sales AS (
    SELECT
        SUM(retail_sales) AS retail_top_suppliers
    FROM top_suppliers
), overall_retail_supplier_sales AS(
    SELECT
        SUM(retail_sales) AS total_retail_supplier_sales
    FROM supplier_retail_sales
)
SELECT 
    o.total_retail_supplier_sales,
    t10.retail_top_suppliers,
    ROUND((t10.retail_top_suppliers / o.total_retail_supplier_sales)*100.0, 2) AS pct_retail_top_supplier_sales
FROM top_suppliers_retail_sales AS t10, overall_retail_supplier_sales AS o;
