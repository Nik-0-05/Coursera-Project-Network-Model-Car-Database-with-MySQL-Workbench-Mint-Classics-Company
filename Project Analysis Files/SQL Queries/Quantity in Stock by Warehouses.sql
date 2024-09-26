SELECT p.productName, w.warehouseCode, w.warehouseName, p.quantityInStock
FROM products p
JOIN warehouses w ON p.warehouseCode = w.warehouseCode
ORDER BY w.warehouseName;