SELECT d.nome, COUNT(*) AS numero_de_empregados,
		ROUND(AVG(salario_bruto - COALESCE(descontos, 0)), 2) AS media, 
		ROUND(MAX(salario_bruto - COALESCE(descontos, 0)), 2) AS maior,
		
		CASE WHEN MIN(salario_bruto - COALESCE(descontos, 0)) = 0 
			THEN CAST(MIN(salario_bruto - COALESCE(descontos, 0)) AS INT)
		ELSE MIN(salario_bruto - COALESCE(descontos, 0))
		END AS menor	
FROM (	
	-- salario_bruto
	SELECT e.matr, e.lotacao, COALESCE(SUM(v.valor), 0) AS salario_bruto
	FROM empregado e
	LEFT JOIN emp_venc ev ON ev.matr = e.matr
	LEFT JOIN vencimento v ON v.cod_venc = ev.cod_venc
	GROUP BY e.matr, e.lotacao
) sal_bruto_div

LEFT JOIN (
	-- descontos
	SELECT e.matr, e.lotacao, SUM(des.valor) AS descontos
	FROM empregado e
	JOIN emp_desc ed ON ed.matr = e.matr
	JOIN desconto des ON des.cod_desc = ed.cod_desc
	GROUP BY e.matr, e.lotacao
) descontos ON sal_bruto_div.matr = descontos.matr

JOIN departamento d ON d.cod_dep = sal_bruto_div.lotacao
GROUP BY d.nome
ORDER BY ROUND(AVG(salario_bruto - COALESCE(descontos, 0)), 2) DESC
