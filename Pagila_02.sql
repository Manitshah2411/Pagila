/*
2. Film Performance by Category
Task:The marketing team needs a report of the top 3 most rented films in each category. For each film:
* Show category name, film title, rental count, total revenue.
* Rank films within each category using rental count.
* Exclude categories with fewer than 1000 rentals total.
*/
SELECT 
	x.title,
	x.name,
	total_rentals,
	total_revenue,
	rankings,
	category_total	
FROM(SELECT 
	t.title,
	t.name,
	total_rentals,
	total_revenue,
	rankings,
	SUM(total_rentals) OVER(PARTITION BY t.name) AS category_total
FROM
(SELECT 
	f.title,
	ca.name,
	COUNT(DISTINCT r.rental_id) AS total_rentals,
	SUM(p.amount) AS total_revenue,
	DENSE_RANK() OVER(PARTITION BY ca.name ORDER BY COUNT(DISTINCT r.rental_id) DESC) AS rankings
FROM film AS f

INNER JOIN inventory AS i
ON f.film_id = i.film_id
INNER JOIN rental AS r
ON r.inventory_id = i.inventory_id
INNER JOIN payment AS p
ON p.rental_id = r.rental_id
INNER JOIN film_category AS fc
ON fc.film_id = f.film_id
INNER JOIN category AS ca
ON ca.category_id = fc.category_id
GROUP BY f.title, ca.name)t)x
WHERE category_total > 1000;