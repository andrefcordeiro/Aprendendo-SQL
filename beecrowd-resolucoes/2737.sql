 -- maior num clientes
SELECT name, customers_number
FROM lawyers
WHERE customers_number = 
    (SELECT MAX(customers_number) FROM lawyers)
UNION ALL
-- menor num clientes
SELECT name, customers_number
FROM lawyers
WHERE customers_number = 
    (SELECT MIN(customers_number) FROM lawyers)
UNION ALL
-- média do num de clientes
SELECT 'Average' AS name, 
    ROUND(AVG(customers_number), 0)
FROM lawyers