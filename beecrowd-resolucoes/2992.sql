SELECT s1.nome AS departamento, s2.nome AS divisao, s1.media
FROM (
	SELECT d.nome, 
		   MAX(media) AS media
	FROM (
		-- media salarial de cada divisao
		SELECT sal_bruto_div.lotacao_div, sal_bruto_div.lotacao, 
		ROUND(AVG(salario_bruto - COALESCE(descontos, 0)), 2) AS media

		FROM (
			-- salario_bruto
			SELECT e.matr, e.lotacao_div, e.lotacao, COALESCE(SUM(v.valor), 0) as salario_bruto
			FROM empregado e
			LEFT JOIN emp_venc ev ON ev.matr = e.matr
			LEFT JOIN vencimento v ON v.cod_venc = ev.cod_venc
			GROUP BY e.matr, e.lotacao_div, e.lotacao) sal_bruto_div

		LEFT JOIN (
			-- descontos
			SELECT e.matr, e.lotacao_div, e.lotacao, SUM(des.valor) AS descontos
			FROM empregado e
			JOIN emp_desc ed ON ed.matr = e.matr
			JOIN desconto des ON des.cod_desc = ed.cod_desc
			GROUP BY e.matr, e.lotacao_div, e.lotacao) descontos 
		ON sal_bruto_div.matr = descontos.matr

		GROUP BY sal_bruto_div.lotacao_div, sal_bruto_div.lotacao

	) AS media_sal_div
	JOIN departamento d ON d.cod_dep = media_sal_div.lotacao

	GROUP BY d.nome) AS s1
	
JOIN (
	-- media salarial de cada divisao
	SELECT sal_bruto_div.lotacao_div, d.nome, sal_bruto_div.lotacao, 
	ROUND(AVG(salario_bruto - COALESCE(descontos, 0)), 2) AS media

	FROM (
		-- salario_bruto
		SELECT e.matr, e.lotacao_div, e.lotacao, COALESCE(SUM(v.valor), 0) as salario_bruto
		FROM empregado e
		LEFT JOIN emp_venc ev ON ev.matr = e.matr
		LEFT JOIN vencimento v ON v.cod_venc = ev.cod_venc
		GROUP BY e.matr, e.lotacao_div, e.lotacao) sal_bruto_div

	LEFT JOIN (
		-- descontos
		SELECT e.matr, e.lotacao_div, e.lotacao, SUM(des.valor) AS descontos
		FROM empregado e
		JOIN emp_desc ed ON ed.matr = e.matr
		JOIN desconto des ON des.cod_desc = ed.cod_desc
		GROUP BY e.matr, e.lotacao_div, e.lotacao) descontos 
	ON sal_bruto_div.matr = descontos.matr
	
	JOIN divisao d ON d.cod_divisao = sal_bruto_div.lotacao_div

	GROUP BY sal_bruto_div.lotacao_div, sal_bruto_div.lotacao, d.nome
	
) s2 ON s1.media = s2.media 
ORDER BY s1.media DESC