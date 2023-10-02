SELECT sal_bruto.nome, 
	ROUND(salario_bruto - COALESCE(descontos, 0), 2) AS salario
FROM (
	-- salario_bruto
	SELECT e.matr, e.lotacao_div, e.nome, SUM(v.valor) as salario_bruto
	FROM empregado e
	JOIN emp_venc ev ON ev.matr = e.matr
	JOIN vencimento v ON v.cod_venc = ev.cod_venc
	GROUP BY e.matr, e.lotacao_div, e.nome
) sal_bruto 
LEFT JOIN (
	-- descontos
	SELECT e.matr, SUM(des.valor) AS descontos
	FROM empregado e
	JOIN emp_desc ed ON ed.matr = e.matr
	JOIN desconto des ON des.cod_desc = ed.cod_desc
	GROUP BY e.matr
) descontos ON descontos.matr = sal_bruto.matr
WHERE ROUND(salario_bruto - COALESCE(descontos, 0), 2) >= 8000 
	AND ROUND(salario_bruto - COALESCE(descontos, 0), 2) > (
		
		-- media salarial da divisao
		SELECT ROUND(AVG(salario_bruto - COALESCE(descontos, 0)), 2)
		FROM (
			-- salario_bruto
			SELECT e.matr, SUM(v.valor) as salario_bruto
			FROM empregado e
			JOIN emp_venc ev ON ev.matr = e.matr
			JOIN vencimento v ON v.cod_venc = ev.cod_venc
			WHERE e.lotacao_div = sal_bruto.lotacao_div
			GROUP BY e.matr) sal_bruto_div
		LEFT JOIN (
			-- descontos
			SELECT e.matr, SUM(des.valor) AS descontos
			FROM empregado e
			JOIN emp_desc ed ON ed.matr = e.matr
			JOIN desconto des ON des.cod_desc = ed.cod_desc
			WHERE e.lotacao_div = sal_bruto.lotacao_div
			GROUP BY e.matr) 
		descontos ON sal_bruto_div.matr = descontos.matr
)
ORDER BY sal_bruto.lotacao_div, sal_bruto
