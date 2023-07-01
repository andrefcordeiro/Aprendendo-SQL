SELECT c.name
FROM customers c, legal_person l
WHERE c.id = l.id_customers