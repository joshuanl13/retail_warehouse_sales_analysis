/*
==============================
Database Creation
==============================
*/

-- Create database in PostgreSQL.
CREATE DATABASE retail_sales;


/*
==============================
Table Creation
==============================
*/

-- Create table for data import matching format and schema in the CSV file.
CREATE TABLE retail_sales(
    "YEAR" INTEGER,
    "MONTH" INTEGER,
    "SUPPLIER" TEXT,
    "ITEM CODE" TEXT,
    "ITEM DESCRIPTION" TEXT,
    "ITEM TYPE" TEXT,
    "RETAIL SALES" NUMERIC,
    "RETAIL TRANSFERS" NUMERIC,
    "WAREHOUSE SALES" NUMERIC
);


/*
==============================
Import Dataset
==============================
*/

-- Imported retail_sales.csv into PostgreSQL using pgAdmin import option.

-- Inspect and verify that the dataset was imported correctly.
SELECT *
FROM retail_sales;


/*
==============================
Reformat Column Headers
==============================
*/

-- Convert column names from uppercase with spaces to lowercase with underscores.
ALTER TABLE retail_sales
    RENAME COLUMN "YEAR" TO year;

 ALTER TABLE retail_sales
    RENAME COLUMN "MONTH" TO month;

ALTER TABLE retail_sales
    RENAME COLUMN "SUPPLIER" TO supplier;

ALTER TABLE retail_sales
    RENAME COLUMN "ITEM CODE" TO item_code;

ALTER TABLE retail_sales
    RENAME COLUMN "ITEM DESCRIPTION" TO item_description;

ALTER TABLE retail_sales
    RENAME COLUMN "ITEM TYPE" TO item_type;

ALTER TABLE retail_sales
    RENAME COLUMN "RETAIL SALES" TO retail_sales;

ALTER TABLE retail_sales
    RENAME COLUMN "RETAIL TRANSFERS" TO retail_transfers;

ALTER TABLE retail_sales
    RENAME COLUMN "WAREHOUSE SALES" TO warehouse_sales;


-- Inspect and verify column headers are in desired format.
SELECT *
FROM retail_sales