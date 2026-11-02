# Dataset Overview


## Dataset Description

This dataset contains monthly sales volume and movement data for various type of products heavily concentrated in alcoholic beverage products. The data includes product information, product category, suppliers of those products, retail sales activity, retail transfers, and warehouse sales activity. 

Each record corresponds to specific product which is reported within a specific year between 2017-2020 and month. Products are identified by an item code number along with it's item description and are connected to a certain supplier and product category.

The dataset contains information related to beer, wine, liquor, non-alcoholic beverages, kegs, and store supplies.The primary sales measures available for analysis come from retail and warehouse sales. There is also retail transfer data, but there is not enough information or context regarding its calculations and business meaning.

This dataset was analyzed to examine difference in sales volume through its sales channels, product performance, supplier performance, and product category performance. 

## Column Definitions

- **year** - reporting year
- **month** - reporting month
- **supplier** - product supplier
- **item_code** - product identifier
- **item_description** - product description
- **item_type** - product category
- **retail_sales** - cases of product sold from DLC dispensaries; represents sales volume rather than revenue
- **retail transfers** - cases of product transferred to DLC dispensaries; represents sales volume rather than revenue
- **warehouse_sales** - cases of product sold to MC lcensees; represents sales volume rather than revenue

## Dataset Limitations

**Annual sales could not be analyzed reliably.** 

Each reporting year contains different months of reporting, making the year-over-year comparisons misleading. Monthly sales analysis may be used in some situations but monthly coverage across available years is still inconsistent and should be taken into consideration when interpreting. 

**Analysis on seasonality could not be done reliably**

The dataset does not contain a complete and consistent set of reporting months for every year, limiting the ability to identify seasonal patterns confidently.

**Retail transfers were excluded from the final analysis**

Although retail transfer data is available, there was not enough context or information on how the measure is defined, calculated, and used in business operations. Any analysis done on this would not be done confidently.

**Some item codes had multiple item descriptions mapped to one code**

The number of unique item description exceeded the number of unique item codes because some codes had more than one item description mapped to it. Product analyses were done using item_code as primary identifier.

**Customer analysis could not be done**

This dataset does not contain customer identifiers or transaction information.
