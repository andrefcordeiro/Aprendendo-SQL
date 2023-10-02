SELECT DISTINCT ON (t.name) t.name, t.investment, t.month AS month_of_payback, (t.cumulative_profit - t.investment) AS return
FROM (
	SELECT c.id, c.investment, c.name, o.month, 
		SUM(o.profit) OVER (PARTITION BY o.client_id ORDER BY o.month) AS cumulative_profit
	FROM clients c
	JOIN operations o ON c.id = o.client_id
	ORDER BY o.month ASC
) t
INNER JOIN clients c ON t.id = c.id
WHERE t.cumulative_profit >= t.investment
ORDER BY t.name