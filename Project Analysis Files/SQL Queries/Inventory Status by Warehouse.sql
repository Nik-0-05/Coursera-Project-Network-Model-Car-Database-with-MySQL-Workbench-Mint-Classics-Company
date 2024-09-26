SELECT 
    w.warehouseCode,
    w.warehouseName,
    SUM(CASE 
        WHEN (p.quantityInStock - COALESCE(total_ordered, 0)) > (2 * COALESCE(total_ordered, 0)) THEN 1
        ELSE 0
    END) AS overstocked_count,
    SUM(CASE 
        WHEN (p.quantityInStock - COALESCE(total_ordered, 0)) < 650 THEN 1
        ELSE 0
    END) AS understocked_count,
    SUM(CASE 
        WHEN (p.quantityInStock - COALESCE(total_ordered, 0)) BETWEEN 650 AND (2 * COALESCE(total_ordered, 0)) THEN 1
        ELSE 0
    END) AS well_stocked_count,
    COUNT(DISTINCT p.productCode) AS total_products
FROM 
    warehouses w
LEFT JOIN 
    products p ON w.warehouseCode = p.warehouseCode
LEFT JOIN 
    (SELECT 
        productCode, 
        SUM(quantityOrdered) as total_ordered
     FROM 
        orderdetails od
     JOIN 
        orders o ON od.orderNumber = o.orderNumber
     WHERE 
        o.status IN ('Shipped', 'Resolved')
     GROUP BY 
        productCode
    ) AS order_summary ON p.productCode = order_summary.productCode
GROUP BY 
    w.warehouseCode, w.warehouseName
ORDER BY 
    w.warehouseCode;