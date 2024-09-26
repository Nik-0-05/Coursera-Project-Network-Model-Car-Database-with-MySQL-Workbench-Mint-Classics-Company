SELECT w.warehouseCode, w.warehouseName, COUNT(p.productCode) as product_count, SUM(p.quantityInStock) as total_inventory
FROM warehouses w
LEFT JOIN products p ON w.warehouseCode = p.warehouseCode
GROUP BY w.warehouseCode, w.warehouseName
ORDER BY total_inventory DESC;