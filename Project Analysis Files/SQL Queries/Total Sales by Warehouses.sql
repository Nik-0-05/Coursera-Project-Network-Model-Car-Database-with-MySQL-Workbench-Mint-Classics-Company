SELECT w.warehouseCode, w.warehouseName, SUM(IFNULL(od.quantityOrdered, 0)) AS totalSales
FROM warehouses w
LEFT JOIN products p ON w.warehouseCode = p.warehouseCode
LEFT JOIN orderdetails od ON p.productCode = od.productCode
GROUP BY w.warehouseCode, w.warehouseName
ORDER BY totalSales ASC;