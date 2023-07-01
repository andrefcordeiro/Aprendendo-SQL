SELECT c.name, o.id
FROM customers c, orders o
WHERE o.id_customers = c.id
    AND extract(month FROM o.orders_date) < 7