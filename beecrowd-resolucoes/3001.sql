SELECT s.name, s.price
FROM (SELECT p.id AS id, p.name AS name, 
    CASE
        WHEN p.type = 'A' THEN 20.0
        WHEN p.type = 'B' THEN 70.0
        WHEN p.type = 'C' THEN 530.5
    END price
FROM products p
ORDER BY price ASC, id DESC) s