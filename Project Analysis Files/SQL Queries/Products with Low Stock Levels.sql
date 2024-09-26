SELECT p.productCode, p.productName, p.quantityInStock, p.warehouseCode, w.warehouseName
FROM products p
LEFT JOIN warehouses w ON p.warehouseCode = w.warehouseCode
WHERE p.quantityInStock < 500
ORDER BY p.quantityInStock;