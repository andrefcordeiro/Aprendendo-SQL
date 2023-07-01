SELECT format('%s.%s.%s-%s', 
left(np.cpf, 3), substring(np.cpf, 4, 3), 
substring(np.cpf, 7, 3), substring(np.cpf, 10, 2))
FROM customers c, natural_person np
WHERE np.id_customers = c.id