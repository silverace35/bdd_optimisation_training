use villes_fr;

# 10 plus peuplé
select ville_id, ville_nom, ville_population_2012 from villes_france_free
ORDER BY ville_population_2012 DESC
LIMIT 10;

# 10 plus petite superficie
select ville_id, ville_nom, ville_surface from villes_france_free
ORDER BY ville_surface ASC
LIMIT 10;

# Liste des départements d'outre-mer
select departement_id, departement_nom, departement_code from departement
WHERE departement_code LIKE '97%'

# Les 10 villes les plus peuplé avec le département associé
select v.ville_id, v.ville_nom, d.departement_nom, v.ville_population_2012
from villes_france_free v
    JOIN departement d ON d.departement_code = v.ville_departement
order by v.ville_population_2012 DESC
LIMIT 10;

# Récuperer le nombre de ville associé a chaque département et accessoirement on peu ranger par nombre de ville
select d.departement_nom, COUNT(d.departement_nom) as 'nombre_de_ville'
from villes_france_free v
JOIN departement d WHERE d.departement_code = v.ville_departement
GROUP BY d.departement_nom
ORDER BY nombre_de_ville desc

# La liste des 10 plus grand départements en terme de superficie
select SUM(ville_surface) as 'superficie_total', d.departement_nom
from departement d
join villes_france_free v ON v.ville_departement = d.departement_code
GROUP BY d.departement_nom
ORDER BY superficie_total DESC;

# Le nombre de ville dont le nom commence par "saint"
select count(v.ville_nom) as 'villes'
from villes_france_free v
WHERE v.ville_nom LIKE 'saint%';

# La liste des villes qui ont un nom dupliqué
select v.ville_nom, COUNT(v.ville_nom) as 'compte'
from villes_france_free v
group by v.ville_nom
having COUNT(v.ville_nom) > 1;

# La liste des villes dont la superfici est supérieur a la superficie moyenne en tout
SELECT v.ville_nom, v.ville_surface
FROM villes_france_free v
WHERE v.ville_surface > (
    SELECT AVG(v2.ville_surface)
    FROM villes_france_free v2
)
ORDER BY v.ville_surface DESC;

# Afficher toute les villes qui ont la plus grande surface
select v.ville_nom, v.ville_surface
from villes_france_free v
WHERE v.ville_surface = (select MAX(ville.ville_surface)
                         from villes_france_free ville
    );

# Tout les départements qui possede plus de 2M d'habitant
select SUM(v.ville_population_2012), d.departement_nom
from villes_france_free v
JOIN departement d On departement_code = v.ville_departement
group by  d.departement_nom
having SUM(v.ville_population_2012) > 2000000;
