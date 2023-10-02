SELECT d.nome AS "Departamento", sal_bruto.nome AS "Empregado", 
	sal_bruto.salario_bruto AS "Salario Bruto", COALESCE(descontos, 0) AS "Total Desconto" ,
	sal_bruto.salario_bruto - COALESCE(descontos, 0) AS "Salario Liquido"

FROM (
	-- salario_bruto
	SELECT e.matr, e.nome, e.lotacao, e.lotacao_div, COALESCE(SUM(v.valor), 0) AS salario_bruto
	FROM empregado e
	LEFT JOIN emp_venc ev ON ev.matr = e.matr
	LEFT JOIN vencimento v ON v.cod_venc = ev.cod_venc
	GROUP BY e.matr, e.nome, e.lotacao, e.lotacao_div) sal_bruto

LEFT JOIN (
	-- descontos
	SELECT e.matr, SUM(des.valor) AS descontos
	FROM empregado e
	JOIN emp_desc ed ON ed.matr = e.matr
	JOIN desconto des ON des.cod_desc = ed.cod_desc
	GROUP BY e.matr) descont
ON sal_bruto.matr = descont.matr

JOIN departamento d ON sal_bruto.lotacao = d.cod_dep
GROUP BY d.nome, sal_bruto.nome, 
	sal_bruto.salario_bruto, descontos,
	"Salario Liquido"
ORDER BY "Salario Liquido" DESC, sal_bruto.nome DESC