SELECT pd.name, pv.name, cat.name
FROM products pd, providers pv, categories cat
WHERE pd.id_providers = pv.id
    AND pd.id_categories = cat.id
    AND pv.name = 'Sansul SA'
    AND cat.name = 'Imported'