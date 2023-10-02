SELECT lr.name, ROUND(lr.omega*1.618, 3) as fator_n
FROM life_registry lr, dimensions d
WHERE lr.dimensions_id = d.id
    AND d.name IN ('C875', 'C774')
    AND split_part(lr.name, ' ', 1) = 'Richard'
ORDER BY fator_n ASC