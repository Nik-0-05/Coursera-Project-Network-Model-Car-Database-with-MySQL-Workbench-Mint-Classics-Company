SELECT p.productCode, p.productName, p.quantityInStock, w.warehouseName
FROM products p
LEFT JOIN warehouses w ON p.warehouseCode = w.warehouseCode
LEFT JOIN orderdetails od ON p.productCode = od.productCode
LEFT JOIN orders o ON od.orderNumber = o.orderNumber
WHERE o.orderDate IS NULL OR o.orderDate < DATE_SUB(NOW(), INTERVAL 6 MONTH)
ORDER BY p.quantityInStock DESC;