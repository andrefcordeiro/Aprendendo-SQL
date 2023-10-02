SELECT name, CAST (extract(day FROM payday) AS INTEGER) as day
FROM loan