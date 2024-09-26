SELECT 
    pl.productLine,
    SUM(od.quantityOrdered) AS total_quantity_sold
FROM 
    productlines pl
JOIN 
    products p ON pl.productLine = p.productLine
JOIN 
    orderdetails od ON p.productCode = od.productCode
GROUP BY 
    pl.productLine
ORDER BY 
    total_quantity_sold DESC;