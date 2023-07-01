SELECT prod.name, prov.name
    FROM providers prov,
        products prod
    WHERE prod.id_providers = prov.id
        AND prov.name = 'Ajax SA'