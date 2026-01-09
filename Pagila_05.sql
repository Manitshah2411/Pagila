/*
5. Films Never Rented vs. Low Performers
Task:Management wants to clean up the catalog. Build a query that outputs:
* All films that were never rented.
* Films rented but earned less than $50 total revenue.
* Union these two sets together and flag them as never_rented or low_performer.
*/

SELECT * FROM rental;
SELECT * FROM film;
SELECT * FROM inventory;
SELECT * FROM payment;

SELECT 
	'never_rented' AS category,
	f.film_id,
	f.title
FROM film AS f
LEFT JOIN inventory AS i
ON i.film_id = f.film_id
LEFT JOIN rental AS r
ON r.inventory_id = i.inventory_id
WHERE r.rental_id IS NULL

UNION ALL

SELECT
	'low_performer' AS category,
	f.film_id,
	f.title
FROM film AS f
INNER JOIN inventory AS i
ON i.film_id = f.film_id
INNER JOIN rental AS r
ON r.inventory_id = i.inventory_id
INNER JOIN payment AS p
ON p.rental_id = r.rental_id
GROUP BY f.film_id,
		 f.title
HAVING SUM(p.amount) < 50;

