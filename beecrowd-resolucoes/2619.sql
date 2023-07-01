SELECT pd.name, pv.name, pd.price
FROM products pd, providers pv, categories cat
WHERE pd.id_providers = pv.id
    AND pd.id_categories = cat.id
    AND pd.price > 1000
    AND cat.name = 'Super Luxury'