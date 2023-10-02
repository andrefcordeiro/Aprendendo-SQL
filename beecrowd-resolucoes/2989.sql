SELECT d.nome AS departamento, dv.nome AS divisao, valores.media, valores.maior
FROM departamento d
JOIN divisao dv ON d.cod_dep = dv.cod_dep
JOIN (
	-- media salarial da divisao e maior salario
	SELECT sal_bruto_div.lotacao_div, ROUND(AVG(salario_bruto - COALESCE(descontos, 0)), 2) AS media, 
		ROUND(MAX(salario_bruto - COALESCE(descontos, 0)), 2) AS maior 
	
-- 	SELECT * 
	FROM (
		-- salario_bruto
		SELECT e.matr, e.lotacao_div, COALESCE(SUM(v.valor), 0) as salario_bruto
		FROM empregado e
		LEFT JOIN emp_venc ev ON ev.matr = e.matr
		LEFT JOIN vencimento v ON v.cod_venc = ev.cod_venc
		GROUP BY e.matr, e.lotacao_div) sal_bruto_div

	LEFT JOIN (
		-- descontos
		SELECT e.matr, e.lotacao_div, SUM(des.valor) AS descontos
		FROM empregado e
		JOIN emp_desc ed ON ed.matr = e.matr
		JOIN desconto des ON des.cod_desc = ed.cod_desc
		GROUP BY e.matr, e.lotacao_div
	) descontos ON sal_bruto_div.matr = descontos.matr
	
	GROUP BY sal_bruto_div.lotacao_div
	
) valores ON dv.cod_divisao = valores.lotacao_div
ORDER BY valores.media DESC