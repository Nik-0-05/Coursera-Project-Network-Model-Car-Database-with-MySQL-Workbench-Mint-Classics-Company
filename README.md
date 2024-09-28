# Mint Classics Company Inventory Analysis
**Optimizing Inventory at Mint Classics: A Data-Driven Approach**

Nikhil Kale  |  LinkedIn: [Profile@nikhil-kale5](https://www.linkedin.com/in/nikhil-kale5)  |  24/09/2024


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
- Conducting a preliminary analysis of products and inventory levels [Link](https://github.com/Nik-0-05/Mint-Classics-Model-Car-Database-with-MySQL-Workbench-Project/blob/47f6e01d289955c0822af50231049494bd15acbf/Project%20Analysis%20Files/SQL%20Queries/List%20All%20Products%20and%20Their%20Current%20Stock.sql)
```sql
SELECT productCode, productName, quantityInStock
FROM products;
```
- Warehouse-wise product distribution overview 
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
- Product Line Storage for each Warehouse
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


