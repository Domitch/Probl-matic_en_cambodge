# Les rêquetes 
-- Voir toutes les villes disponibles
SELECT * FROM villes;

-- Voir tous les hôtels avec leur ville
SELECT h.nom, v.ville, h.note, h.prix
FROM hotels h
JOIN villes v ON h.ville_id = v.id;

-- Voir toutes les attractions avec la ville correspondante
SELECT a.nom, v.ville, a.note, a.prix
FROM attractions a
JOIN villes v ON a.ville_id = v.id;

-- Trouver les hôtels de Phnom Penh avec plus de 4 étoiles
SELECT h.nom, h.etoiles, v.ville
FROM hotels h
JOIN villes v ON h.ville_id = v.id
WHERE v.ville = 'Phnom Penh' AND h.etoiles >= 4;

-- Liste des attractions de Siem Reap qui coûtent moins de 20€
SELECT a.nom, a.prix
FROM attractions a
JOIN villes v ON a.ville_id = v.id
WHERE v.ville = 'Siem Reap' AND a.prix < 20;

-- Nombre d'hôtels par ville
SELECT v.ville, COUNT(*) AS nb_hotels
FROM hotels h
JOIN villes v ON h.ville_id = v.id
GROUP BY v.ville;

-- Note moyenne des attractions par ville
SELECT v.ville, ROUND(AVG(a.note), 2) AS note_moyenne
FROM attractions a
JOIN villes v ON a.ville_id = v.id
GROUP BY v.ville
ORDER BY note_moyenne DESC;

-- Trouver les villes avec au moins 5 hôtels ET 3 attractions
SELECT v.ville, COUNT(DISTINCT h.id) AS nb_hotels, COUNT(DISTINCT a.id) AS nb_attractions
FROM villes v
LEFT JOIN hotels h ON h.ville_id = v.id
LEFT JOIN attractions a ON a.ville_id = v.id
GROUP BY v.ville
HAVING nb_hotels >= 5 AND nb_attractions >= 3;

-- Voir les hôtels et les attractions dans la même ville
SELECT v.ville, h.nom AS hotel, a.nom AS attraction
FROM villes v
JOIN hotels h ON h.ville_id = v.id
JOIN attractions a ON a.ville_id = v.id
WHERE v.ville = 'Kampot';
-- Hôtels les mieux notés dans chaque ville
SELECT v.ville, h.nom, h.note
FROM hotels h
JOIN villes v ON h.ville_id = v.id
WHERE h.note = (
    SELECT MAX(h2.note)
    FROM hotels h2
    WHERE h2.ville_id = h.ville_id
)
ORDER BY v.ville;

# Liste des villes avec le nombre d’hôtels et d’attractions
SELECT v.ville,COUNT(DISTINCT h.id) AS nb_hotels,COUNT(DISTINCT a.id) AS nb_attractions
FROM villes v LEFT JOIN hotels h ON v.id = h.ville_id LEFT JOIN attractions a ON v.id = a.ville_id GROUP BY v.ville;
# Moyenne de prix des hôtels par ville
SELECT v.ville, AVG(h.prix) AS prix_moyen_hotel FROM villes v JOIN hotels h ON v.id = h.ville_id GROUP BY v.ville ;
#Attraction la mieux notée par ville
SELECT v.ville, a.nom AS attraction, a.note FROM villes v JOIN attractions a ON v.id = a.ville_id WHERE a.note = ( SELECT MAX(note) FROM attractions 
WHERE ville_id = v.id);
#Top 5 hôtels les moins chers avec au moins 4 étoiles
SELECT h.nom, v.ville, h.etoiles, h.prix FROM hotels h JOIN villes v ON h.ville_id = v.id WHERE h.etoiles >= 4 ORDER BY h.prix ASC LIMIT 5;
# Comparer les villes selon le rapport qualité/prix
SELECT v.ville, AVG(h.note / h.prix) AS score_qualite_prix_hotel, AVG(a.note / a.prix) AS score_qualite_prix_attraction
FROM villes v LEFT JOIN hotels h ON v.id = h.ville_id LEFT JOIN attractions a ON v.id = a.ville_id GROUP BY v.ville;
#




