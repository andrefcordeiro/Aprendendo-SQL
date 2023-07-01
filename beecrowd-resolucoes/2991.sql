SELECT d.nome, 
    FROM departamento d
    
    

-- qtd de empregados
SELECT COUNT(*)
    from departamento d, 
        empregado e
    WHERE e.lotacao = d.cod_dep
    GROUP BY d.cod_dep
    
-- media salarial
SELECT 