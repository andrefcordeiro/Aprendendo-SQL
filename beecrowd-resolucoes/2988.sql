SELECT 
	t.name, (COALESCE(victories, 0) + COALESCE(defeats, 0) + COALESCE(draws, 0)) AS matches,
	COALESCE(victories, 0) AS victories, COALESCE(defeats, 0) AS defeats, COALESCE(draws, 0) AS draws,
	(COALESCE(victories, 0)*3 + COALESCE(draws, 0)) AS score
FROM teams t
FULL OUTER JOIN (
    -- vitorias
    SELECT t.id, COUNT(*) victories
    FROM teams t, matches m
    WHERE (m.team_1 = t.id AND team_1_goals > team_2_goals) 
        OR (m.team_2 = t.id AND team_2_goals > team_1_goals)
    GROUP BY t.id
) vic ON t.id = vic.id

FULL OUTER JOIN (
    -- derrotas
    SELECT t.id, COUNT(*) defeats
    FROM teams t, matches m
    WHERE (m.team_1 = t.id AND team_1_goals < team_2_goals) 
        OR (m.team_2 = t.id AND team_2_goals < team_1_goals)
    GROUP BY t.id
) def ON t.id = def.id 

FULL OUTER JOIN (
    -- empates
    SELECT t.id, COUNT(*) draws
    FROM teams t, matches m
    WHERE (m.team_1 = t.id AND team_1_goals = team_2_goals) 
        OR (m.team_2 = t.id AND team_2_goals = team_1_goals)
    GROUP BY t.id
) draw ON t.id = draw.id

ORDER BY score DESC
