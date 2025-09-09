# Faire une vue qui vas permettre d'afficher le nombre d'acteur et de catégorie
select fi.film_id,
       fi.title,
       COUNT(distinct fa.actor_id)   as 'nombre_acteurs',
       COUNT(distinct f.category_id) as 'nombre_categories'
from film_category f
         JOIN category c ON c.category_id = f.category_id
         JOIN film_actor fa ON fa.film_id = f.film_id
         JOIN film fi ON fi.film_id = f.film_id
GROUP BY fi.film_id, fi.title
ORDER BY nombre_categories DESC;

select f.film_id, f.title, c.category_id
from film f
         JOIN film_category fc ON fc.film_id = f.film_id
         JOIN category c ON c.category_id = fc.category_id
WHERE f.film_id = 55;

# Faire une requete qui vas permettre d'avoir les films qui ont le plus d'acteurs
SELECT f.film_id,
       f.title,
       (SELECT COUNT(DISTINCT fa.actor_id)
        FROM film_actor fa
        WHERE fa.film_id = f.film_id) AS actor_count
FROM film f
ORDER BY actor_count DESC;

# Liste des film qui n'ont jamais été loué avec un exists
SELECT f.film_id,
       f.title
FROM film f
WHERE NOT EXISTS (SELECT r.rental_id
                  FROM rental r
                  WHERE r.inventory_id IN (SELECT i.inventory_id
                                           FROM inventory i
                                           WHERE i.film_id = f.film_id));