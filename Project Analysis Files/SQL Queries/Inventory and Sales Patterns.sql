SELECT p.productCode, p.productName, p.quantityInStock, 
       w.warehouseName,
       COUNT(od.orderNumber) as order_count, 
       SUM(od.quantityOrdered) as Total_Sales
FROM products p
LEFT JOIN warehouses w ON p.warehouseCode = w.warehouseCode
LEFT JOIN orderdetails od ON p.productCode = od.productCode
GROUP BY p.productCode, p.productName, p.quantityInStock, w.warehouseName
ORDER BY Total_Sales DESC;