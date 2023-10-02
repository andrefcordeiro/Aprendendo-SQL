SELECT d.name, ROUND(SUM((att.hours * 150) +  ((att.hours * 150) * ws.bonus/100)), 1) AS salary
FROM doctors d
JOIN attendances att ON d.id = id_doctor
JOIN work_shifts ws ON att.id_work_shift = ws.id
GROUP BY d.name
ORDER BY salary DESC