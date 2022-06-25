SELECT c.name, SUM(amount)
    FROM products p, 
        categories c
    WHERE p.id_categories = c.id
    GROUP BY c.name