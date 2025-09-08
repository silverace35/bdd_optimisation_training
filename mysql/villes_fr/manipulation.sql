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
    JOIN departement d ON d.departement_id = v.ville_departement
order by v.ville_population_2012 DESC
LIMIT 10;

# Récuperer le nombre de ville associé a chaque département et accessoirement on peu ranger par nombre de ville
select d.departement_nom, COUNT(d.departement_nom) as 'nombre_de_ville'
from villes_france_free v
JOIN departement d WHERE d.departement_id = v.ville_departement
GROUP BY d.departement_nom
ORDER BY nombre_de_ville desc

#