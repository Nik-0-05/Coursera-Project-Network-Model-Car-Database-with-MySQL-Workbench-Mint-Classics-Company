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