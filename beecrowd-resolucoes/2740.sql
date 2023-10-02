SELECT name from 
  (-- 3 primeiros
  SELECT 'Podium: ' || team AS name, position
  FROM league
  WHERE position < 4
  UNION
  -- 2 últimos
  SELECT 'Demoted: ' || team AS name, position
  FROM league
  WHERE position > 13) s
 ORDER BY position