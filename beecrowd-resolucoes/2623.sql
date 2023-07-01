SELECT pd.name, cat.name
FROM products pd, categories cat
WHERE pd.id_categories = cat.id
    AND pd.amount > 100
    AND cat.id IN (1, 2, 3, 6, 9)
ORDER BY cat.id ASC