/*
1. Customer Lifetime Value (CLV) Analysis
Task:Management wants to identify the top 10 highest value customers. For each customer:
* Show their total number of rentals, total revenue generated, and average payment amount.
* Add their ranking within their city based on revenue.
* Only include customers who have rented more than 20 films.
*/
SELECT
	t.customer_id,
	t.first_name,
	t.total_rentals,
	t.total_revenue,
	t.avg_payment,
	CONCAT(ad.address,', ',ci.city) AS city_address,
	RANK() OVER(PARTITION BY ci.city ORDER BY total_revenue DESC) AS rankings_based_on_revenue
FROM
(SELECT 
	customer_id,
	first_name,
	address_id,
	total_rentals,
	total_revenue,
	ROUND(total_revenue / total_rentals,2) AS avg_payment
FROM
(SELECT 
	c.customer_id,
	c.first_name,
	c.address_id,
	COUNT(DISTINCT r.rental_id) AS total_rentals,
	SUM(p.amount) AS total_revenue
FROM customer AS c
INNER JOIN rental AS r
ON c.customer_id = r.customer_id
INNER JOIN payment AS p
ON p.rental_id = r.rental_id
GROUP BY c.customer_id, c.first_name, c.address_id))t 
INNER JOIN address AS ad
ON ad.address_id = t.address_id
INNER JOIN city AS ci
ON ci.city_id = ad.city_id
WHERE total_rentals >= 20;
