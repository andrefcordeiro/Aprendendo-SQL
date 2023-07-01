SELECT * 
FROM 
( -- maior
SELECT price
FROM products p
WHERE p.price = 
    (SELECT MAX(p.price)
    FROM products p)
) maxim, 
( -- menor
SELECT price
FROM products p
WHERE p.price = 
    (SELECT MIN(p.price)
    FROM products p)
) minim
