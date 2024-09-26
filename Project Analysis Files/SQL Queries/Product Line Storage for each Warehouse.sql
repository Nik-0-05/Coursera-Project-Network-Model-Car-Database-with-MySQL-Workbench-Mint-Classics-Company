SELECT 
 p.warehouseCode,
 w.warehouseName,
    p.productLine,
 COUNT(productCode) AS total_product, 
 SUM(p.quantityInStock) AS total_stock
FROM products AS p 
JOIN warehouses AS w ON p.warehouseCode = w.warehouseCode
GROUP BY w.warehouseCode, w.warehouseName, p.productLine;