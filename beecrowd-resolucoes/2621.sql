SELECT pd.name
FROM providers pv, products pd
WHERE pd.id_providers = pv.id
    AND pd.amount BETWEEN 10 AND 20
    AND LEFT(pv.name, 1) = 'P'