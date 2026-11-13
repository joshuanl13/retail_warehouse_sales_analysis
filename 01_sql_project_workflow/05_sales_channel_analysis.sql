/*
===================================================
Sales Channels Analysis
===================================================
*/



/*
=============================================
Warehouse and Retail Sales
=============================================
*/

-- Find total sales distribution between retail and warehouse sales channels.
SELECT
    SUM(warehouse_sales) + SUM(retail_sales) AS total_company_sales,
    SUM(warehouse_sales) AS total_warehouse_sales,
    SUM(retail_sales) AS total_retail_sales
FROM retail_sales;
    

-- Find total sales distribution between retail and warehouse sales channels in percentages.
WITH sales_channels AS(
    SELECT
        SUM(warehouse_sales) + SUM(retail_sales) AS total_company_sales,
        SUM(warehouse_sales) AS total_warehouse_sales,
        SUM(retail_sales) AS total_retail_sales
    FROM retail_sales
)
SELECT
    ROUND((sc.total_warehouse_sales / sc.total_company_sales)*100.0, 2) AS pct_warehouse_sales,
    ROUND((sc.total_retail_sales / sc.total_company_sales)*100.0, 2) AS pct_retail_sales
FROM sales_channels AS sc;
