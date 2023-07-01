SELECT id, name
FROM customers 
WHERE id NOT IN
    (SELECT c.id 
        FROM customers c,
            locations l
        WHERE l.id_customers = c.id)
ORDER BY id