# Faire une vue qui vas permettre d'afficher le nombre d'acteur et de catégorie
EXPLAIN select fi.film_id,
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

# Liste des film qui n'ont jamais été loué avec un CTE - table temporaire (Common Table Expression)
EXPLAIN WITH rental_cte(rental_id, film_id) AS (SELECT r.rental_id, i.film_id
                                        FROM rental r
                                                 JOIN inventory i ON r.inventory_id = i.inventory_id)
SELECT f.*
FROM film f
WHERE NOT EXISTS (SELECT 1
                  FROM rental_cte r
                  WHERE r.film_id = f.film_id);

# Faire une vue qui vas permettre d'afficher le nombre d'acteur et de catégorie avec une CTE
EXPLAIN WITH actor_count_cte AS (SELECT fa.film_id, COUNT(*) AS nombre_acteurs
                         FROM film_actor fa
                         GROUP BY fa.film_id),
     category_count_cte AS (SELECT fc.film_id, COUNT(*) AS nombre
                            FROM film_category fc
                            GROUP BY fc.film_id)
SELECT f.film_id,
         f.title,
         ac.nombre_acteurs,
         cc.nombre AS nombre_categories
FROM film f
            JOIN actor_count_cte ac ON f.film_id = ac.film_id
            JOIN category_count_cte cc ON f.film_id = cc.film_id
ORDER BY nombre_acteurs DESC;

# Meme requete qu'avant mais une seul CTE
EXPLAIN WITH combined_counts AS (SELECT f.film_id,
                                 f.title,
                                 COUNT(DISTINCT fa.actor_id)   AS nombre_acteurs,
                                 COUNT(DISTINCT fc.category_id) AS nombre_categories
                          FROM film f
                                   LEFT JOIN film_actor fa ON f.film_id = fa.film_id
                                   LEFT JOIN film_category fc ON f.film_id = fc.film_id
                          GROUP BY f.film_id, f.title)
SELECT *
FROM combined_counts
ORDER BY nombre_acteurs DESC;

# Meme requete qu'avant mais sans utiliser la table film dans la CTE
EXPLAIN WITH combined_counts AS (SELECT fa.film_id,
                                 COUNT(DISTINCT fa.actor_id)   AS nombre_acteurs,
                                 COUNT(DISTINCT fc.category_id) AS nombre_categories
                          FROM film_actor fa
                                   LEFT JOIN film_category fc ON fa.film_id = fc.film_id
                          GROUP BY fa.film_id)
SELECT f.film_id,
         f.title,
         cc.nombre_acteurs,
         cc.nombre_categories
FROM combined_counts cc
            JOIN film f ON f.film_id = cc.film_id
ORDER BY cc.nombre_acteurs DESC;