DROP VIEW departement_stats IF EXISTS;
CREATE VIEW departement_stats AS
SELECT departement_id, COUNT(*) AS nbr_items,
       SUM(v.ville_surface) AS dpt_surface,
       SUM(v.ville_population_2012) AS dpt_population_2012
FROM departement d
         INNER JOIN villes_france_free v ON d.departement_code = v.ville_departement
GROUP BY departement_id;

select dv.dpt_surface, d.departement_nom, d.departement_code, d.departement_id
from departement_stats dv
JOIN departement d ON d.departement_id = dv.departement_id
order by dpt_surface desc
limit 5;