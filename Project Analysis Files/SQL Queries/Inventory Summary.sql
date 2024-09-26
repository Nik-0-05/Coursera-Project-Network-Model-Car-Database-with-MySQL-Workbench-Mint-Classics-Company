SELECT 
    p.warehouseCode AS warehouseCode,
    w.warehouseName AS warehouseName,
    p.productCode AS productCode,
    p.productName AS productName,
    p.quantityInStock AS quantityInStock,
    SUM(od.quantityOrdered) AS total_ordered,
    p.quantityInStock - SUM(od.quantityOrdered) AS remaining_stock,
    CASE 
        WHEN (p.quantityInStock - SUM(od.quantityOrdered)) > (2 * SUM(od.quantityOrdered)) THEN 'Overstocked'
        WHEN (p.quantityInStock - SUM(od.quantityOrdered)) < 650 THEN 'Understocked'
        ELSE 'Well-Stocked' 
    END AS inventory_status
FROM 
    products AS p
JOIN 
    warehouses AS w ON p.warehouseCode = w.warehouseCode
JOIN 
    orderdetails AS od ON p.productCode = od.productCode
JOIN 
    orders o ON od.orderNumber = o.orderNumber
WHERE 
    o.status IN ('Shipped', 'Resolved')
GROUP BY 
    p.warehouseCode, w.warehouseName, p.productCode, p.productName, p.quantityInStock
ORDER BY 
    warehouseCode, productCode;