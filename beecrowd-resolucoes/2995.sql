SELECT s.temperature, s.number_of_records
FROM (
SELECT temperature, mark, COUNT(*) AS number_of_records
FROM records
GROUP BY temperature, mark
ORDER BY mark) s