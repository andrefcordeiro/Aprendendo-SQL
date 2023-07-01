SELECT e.cpf, e.enome, d.dnome
    FROM empregados e,
        departamentos d
    WHERE e.dnumero = d.dnumero
    AND e.cpf NOT IN (
    SELECT e.cpf 
     FROM empregados e, trabalha t
     WHERE e.cpf = t.cpf_emp
    )
    ORDER BY e.cpf