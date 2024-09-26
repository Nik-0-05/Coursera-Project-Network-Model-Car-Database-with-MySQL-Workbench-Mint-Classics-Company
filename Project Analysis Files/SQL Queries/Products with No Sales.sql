SELECT p.productCode, p.productName, p.quantityInStock, w.warehouseName
FROM products p
LEFT JOIN warehouses w ON p.warehouseCode = w.warehouseCode
LEFT JOIN orderdetails od ON p.productCode = od.productCode
GROUP BY p.productCode, p.productName, p.quantityInStock, w.warehouseName
HAVING SUM(od.quantityOrdered) IS NULL OR SUM(od.quantityOrdered) = 0
ORDER BY p.quantityInStock DESC;