# Mint Classics Company Inventory Analysis
**Optimizing Inventory at Mint Classics: A Data-Driven Approach**

Nikhil Kale  |  LinkedIn: [Profile@nikhil-kale5](https://www.linkedin.com/in/nikhil-kale5)  |  25/09/2024


## Introduction
Mint Classics Company, a fictional retailer of classic model cars and vehicles, seeks to optimize its inventory management. To inform a potential storage facility closure, the company requires data-driven recommendations for reorganizing or reducing inventory while maintaining customer service standards. MySQL Workbench is used to demonstrate SQL capabilities within the analytical environment in this project from Coursera Project Network.

### Business Task Statement
This project aims to analyze current inventory data to identify opportunities for reorganization or reduction. By examining factors influencing inventory levels and sales performance, the analysis will develop data-driven insights and recommendations. Through SQL queries, the analysis will address key questions such as: Where are items stored, and can a warehouse be eliminated by rearranging inventory? How do inventory numbers correlate with sales figures? Are inventory counts adequate? Are we holding non-moving items? By answering these questions, the analysis aims to develop effective strategies for reducing inventory and potentially closing a storage facility while maintaining optimal customer service.

### Stakeholders
- Mint Classics Company Management: The executives and managers responsible for making decisions about inventory and facility operations.
- Inventory and Warehouse Staff: Those directly involved in managing, storing, and shipping inventory.
- Financial Analysts: Department responsible for assessing the company's financial performance and making recommendations.

### Data Source and License
The data for this project was provided by the Coursera Project Network. The relational database file 'mintclassicsDB.sql' and the Extended Entity-Relationship (EER) diagram were downloaded from the Coursera platform. The complete project overview is available [here.](https://coursera.org/share/ce13a4363d8262c4264e86242f68fc32)

### Tools for Analysis
MySQL Workbench was configured and launched on a local machine. It was then connected to a local MySQL Community Server instance, both of which were downloaded and installed. The relational database 'mintclassicsDB.sql' was imported into MySQL Workbench using an SQL script to facilitate the analysis.

## Importing the Mint Classics relational Database
The 'mintclassicsDB.sql' file, containing the script to create and populate the Mint Classics relational database, was downloaded. This script was then imported into MySQL Workbench using the 'Import from Self-Contained File' option within the Data Import tool. This process successfully created the Mint Classics database schema, including tables, fields, primary and foreign keys, and populated it with relevant data. As a result, a fully functional nine-table relational database representing the Mint Classics company was established.

## Data Exploration
The database structure will be understood by analyzing the Extended Entity-Relationship (EER) diagram. ![ERR](https://github.com/Nik-0-05/Mint-Classics-Model-Car-Database-with-MySQL-Workbench-Project/blob/b4b059fee48acb7871739271153a79d6e5a3e8d8/Extended%20Entity-Relationship%20diagram.png) 

All nine tables were analyzed to understand their schemas, structure and contents of a table using the SQL query 'SELECT * FROM mintclassics.table_name'. This gives insights into their column names, data types, and sample data.

## Data Analysis
1. Conducting a preliminary analysis of products and inventory levels
```sql
SELECT productCode, productName, quantityInStock
FROM products;
```
2. Warehouse-wise product distribution overview 
```sql
SELECT w.warehouseCode, w.warehouseName, COUNT(p.productCode) as product_count,
        SUM(p.quantityInStock) as total_inventory
FROM warehouses w
LEFT JOIN products p ON w.warehouseCode = p.warehouseCode
GROUP BY w.warehouseCode, w.warehouseName
ORDER BY total_inventory DESC;
```
![Total_Inventory](https://github.com/Nik-0-05/Mint-Classics-Model-Car-Database-with-MySQL-Workbench-Project/blob/407d2f4a9a814263517fe283a87e560536e166c5/Project%20Analysis%20Files/Analytical%20Snippets/Warehouse-wise%20product%20distribution%20overview.jpg)

The East warehouse houses the most number of products and has the highest total inventory count, whereas the South warehouse has the lowest product count and lowest total inventory.

3. Product Line Storage for each Warehouse
```sql
SELECT 
 p.warehouseCode,
 w.warehouseName,
    p.productLine,
 COUNT(productCode) AS total_product, 
 SUM(p.quantityInStock) AS total_stock
FROM products AS p 
JOIN warehouses AS w ON p.warehouseCode = w.warehouseCode
GROUP BY w.warehouseCode, w.warehouseName, p.productLine;
```
![Product Line by Warehouse](https://github.com/Nik-0-05/Mint-Classics-Model-Car-Database-with-MySQL-Workbench-Project/blob/d74b75306941bf509275264b7c467a6df1195fa3/Project%20Analysis%20Files/Analytical%20Snippets/Product%20line%20Storage%20for%20each%20Warehouse.jpg)

While the East and West warehouses each specialize in a single product line, the East warehouse has the highest total inventory. In contrast, the South warehouse, despite offering three product lines, has the lowest total inventory.

4. Total Sales by Warehouses
```sql
SELECT w.warehouseCode, w.warehouseName, SUM(IFNULL(od.quantityOrdered, 0)) AS totalSales
FROM warehouses w
LEFT JOIN products p ON w.warehouseCode = p.warehouseCode
LEFT JOIN orderdetails od ON p.productCode = od.productCode
GROUP BY w.warehouseCode, w.warehouseName
ORDER BY totalSales ASC;
```
![Warehouse Sales](https://github.com/Nik-0-05/Mint-Classics-Model-Car-Database-with-MySQL-Workbench-Project/blob/8507ae97ab0c195a404492bb42edd6bba3ba6912/Project%20Analysis%20Files/Analytical%20Snippets/Total%20Sales%20by%20Warehouses.jpg)

The East warehouse generated the highest total sales, while the South warehouse recorded the lowest.

5. Number of Sales by Product Lines and Warehouses
```sql
SELECT 
    pl.productLine,
    SUM(od.quantityOrdered) AS total_quantity_sold
FROM 
    productlines pl
JOIN 
    products p ON pl.productLine = p.productLine
JOIN 
    orderdetails od ON p.productCode = od.productCode
GROUP BY 
    pl.productLine
ORDER BY 
    total_quantity_sold DESC;
```
![Product line Sales](https://github.com/Nik-0-05/Mint-Classics-Model-Car-Database-with-MySQL-Workbench-Project/blob/8507ae97ab0c195a404492bb42edd6bba3ba6912/Project%20Analysis%20Files/Analytical%20Snippets/Number%20of%20Sales%20by%20Product%20Lines.jpg)

 Classic Cars are the best-selling product line, followed by Vintage Cars and Motorcycles. Trucks, Buses, Ships, and Trains, which are stored in the South warehouse, have lower sales volumes.

6. Products with No Sales
```sql
SELECT p.productCode, p.productName, p.quantityInStock, w.warehouseName
FROM products p
LEFT JOIN warehouses w ON p.warehouseCode = w.warehouseCode
LEFT JOIN orderdetails od ON p.productCode = od.productCode
GROUP BY p.productCode, p.productName, p.quantityInStock, w.warehouseName
HAVING SUM(od.quantityOrdered) IS NULL OR SUM(od.quantityOrdered) = 0
ORDER BY p.quantityInStock DESC;
```
![No Sales](https://github.com/Nik-0-05/Mint-Classics-Model-Car-Database-with-MySQL-Workbench-Project/blob/39b8d6d0574f555bb50cff98dd20784993466b78/Project%20Analysis%20Files/Analytical%20Snippets/Products%20with%20No%20Sales.jpg)

The 1985 Toyota Supra, located in the East warehouse, has not recorded any sales.

7. Inventory Status by Warehouse [SQL query link](https://github.com/Nik-0-05/Mint-Classics-Model-Car-Database-with-MySQL-Workbench-Project/blob/39b8d6d0574f555bb50cff98dd20784993466b78/Project%20Analysis%20Files/SQL%20Queries/Inventory%20Status%20by%20Warehouse.sql)

![Inventory Status](https://github.com/Nik-0-05/Mint-Classics-Model-Car-Database-with-MySQL-Workbench-Project/blob/39b8d6d0574f555bb50cff98dd20784993466b78/Project%20Analysis%20Files/Analytical%20Snippets/Inventory%20Status%20by%20Warehouse.jpg)

The East warehouse has the highest number of overstocked items, while the South warehouse has the lowest.

8. Slow-Moving Inventory : [Output Excel link](https://github.com/Nik-0-05/Mint-Classics-Model-Car-Database-with-MySQL-Workbench-Project/blob/39b8d6d0574f555bb50cff98dd20784993466b78/Project%20Analysis%20Files/Output%20CSV%20Files/Slow-moving%20Products.csv)
```sql
SELECT p.productCode, p.productName, p.quantityInStock, w.warehouseName
FROM products p
LEFT JOIN warehouses w ON p.warehouseCode = w.warehouseCode
LEFT JOIN orderdetails od ON p.productCode = od.productCode
LEFT JOIN orders o ON od.orderNumber = o.orderNumber
WHERE o.orderDate IS NULL OR o.orderDate < DATE_SUB(NOW(), INTERVAL 6 MONTH)
ORDER BY p.quantityInStock DESC;
```
A quick pivot table analysis of the output excel data reveals that the East warehouse has the highest quantity of slow-moving inventory, totaling 5,851,766 units, while the South warehouse has the lowest quantity at 2,186,871 units. The North warehouse holds the second-largest volume of slow-moving inventory, totaling 3,659,553 units.

9. Inventory-Sales Ratio by Warehouses
```sql
SELECT 
    w.warehouseCode,
    w.warehouseName,
    COUNT(DISTINCT p.productCode) AS unique_products,
    SUM(p.quantityInStock) AS total_inventory,
    SUM(od.quantityOrdered) AS total_sales,
    SUM(p.quantityInStock) / NULLIF(SUM(od.quantityOrdered), 0) AS inventory_sales_ratio
FROM 
    warehouses w
LEFT JOIN 
    products p ON w.warehouseCode = p.warehouseCode
LEFT JOIN 
    orderdetails od ON p.productCode = od.productCode
GROUP BY 
    w.warehouseCode, w.warehouseName
ORDER BY 
    total_inventory DESC;
```
![Inventory-Sales Ratio](https://github.com/Nik-0-05/Mint-Classics-Model-Car-Database-with-MySQL-Workbench-Project/blob/8852a2e3529357d4540d0eb8a1429d0e61405a7b/Project%20Analysis%20Files/Analytical%20Snippets/Inventory-Sales%20Ratio%20by%20Warehouses.jpg)

The East warehouse generated the highest total sales (35,582) and had the highest inventory-to-sales ratio (164.4586), while the South warehouse had the lowest sales (22,351) and the lowest inventory-to-sales ratio (97.8422). 

**All above analysis reveals a stark contrast between the East and South warehouses across various metrics. Additional SQL queries and their corresponding output files are available in the 'Project Analysis Files' folder [(link)](https://github.com/Nik-0-05/Mint-Classics-Model-Car-Database-with-MySQL-Workbench-Project/tree/8b29e8ede5a413393be7991e6b013207b3ff0987/Project%20Analysis%20Files) for extended examination.** 

## Key Findings and Insights
- **Warehouse Utilization:** The East warehouse, despite being the most utilized in terms of product storage and sales, exhibits higher levels of inventory inefficiency. It has the highest number of overstocked units, the highest inventory-to-sales ratio, and the highest quantity of slow-moving inventory. In contrast, the South warehouse, while having the lowest utilization and sales, demonstrates more efficient inventory management with lower levels of slow-moving inventory, overstocking, and a lower inventory-to-sales ratio.
- **Inventory Imbalance:** There is a significant imbalance in inventory levels across warehouses, with many overstocked items, particularly in the East warehouse. The East warehouse exhibits both the highest number of overstocked items and the largest quantity of slow-moving inventory, while the South warehouse has the lowest levels in both categories.
- **Sales and Inventory Relationship:** While the East warehouse has the highest sales, it also has the highest inventory-sales ratio, indicating potential overstock issues. The South warehouse has the lowest inventory-sales ratio, suggesting more efficient stock management or potential understocking.
- **Product Line Performance:** Classic Cars and Vintage Cars are the best-performing product lines, while Trains have the lowest sales. The 1985 Toyota Supra, located in the East warehouse, has not recorded any sales.

## Limitations and Further Research
The report acknowledges that the scope of this analysis is extremely limited. As a result, additional data and data points could have contributed to a more comprehensive and granular analysis. The following data points would have enhanced the report:
- Warehouse Costs: Information on warehouse operating costs was not available. Including this data could provide a more comprehensive view for decision-making.
- Warehouse Capacity: Warehouse capacity data was unavailable, limiting insights into warehouse utilization and potential for consolidation.
- Time Frame: This analysis is based on one year of data. A longer time frame could reveal seasonal trends or long-term patterns.
- Profit Margins: Incorporating profit margin data for different product lines could refine the recommendations for product line optimization.

## Recommendations
1. **<u>Warehouse Consolidation<u>:** Consider closing the South warehouse and redistributing its inventory to the East warehouse. The East warehouse, which holds a product with no sales, also has the highest number of overstocked items and the largest volume of slow-moving inventory. By removing this excess inventory, space can be made available to consolidate both warehouses.
2. **Inventory Rebalancing:** Implement a comprehensive strategy to optimize inventory distribution by reducing overstocked items in the East and North warehouses, redistributing slow-moving items from the South warehouse to other locations, and ensuring that popular product lines, like Classic Cars and Vintage Cars, are sufficiently stocked across the remaining warehouses.
3. **Inventory Management System:** Implement a more robust inventory management system to better align stock levels with sales performance, reducing instances of significant over- or under-stocking.
4. **SKU Rationalization:** Conduct a detailed analysis of slow-moving items, particularly in the Trucks and Buses, Ships, and Trains categories, to identify candidates for discontinuation or potential promotional campaigns to clear stock. The 1985 Toyota Supra, despite being part of a top-performing Classic Cars product line, has recorded no sales. Further investigation is needed to identify potential issues with this product.

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
Thank you for your time!








