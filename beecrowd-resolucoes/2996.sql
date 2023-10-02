SELECT p.year, send.name as sender, rec.name as receiver
FROM packages p
JOIN users send
	ON p.id_user_sender = send.id
JOIN users rec
	ON p.id_user_receiver = rec.id
WHERE (p.color = 'blue' OR p.year = 2015) -- pacotes azuis ou do ano de 2015 
	AND send.address != 'Taiwan' -- cujo remetente não é de Taiwan
	AND rec.address != 'Taiwan' -- cujo destinatário não é de Taiwan
ORDER BY p.year DESC