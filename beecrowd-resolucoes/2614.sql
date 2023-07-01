SELECT c.name, r.rentals_date
FROM rentals r, customers c
WHERE r.id_customers = c.id
    AND extract(month FROM r.rentals_date) = 9