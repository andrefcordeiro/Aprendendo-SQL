SELECT s1.amount 
	FROM (
     SELECT amount, COUNT(*) AS c
          FROM value_table
          GROUP BY amount
    ) s1, 
    (
      SELECT MAX(s.c) max
    	FROM (
          SELECT amount, COUNT(*) AS c
          FROM value_table
          GROUP BY amount) s
    ) s2
	WHERE s1.c = max