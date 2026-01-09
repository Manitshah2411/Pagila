/* 
6. Active vs Inactive Customers
Task: Build a query to classify customers as:
* Active if they rented within the last 6 months.
* Inactive otherwise.Then, show customer_id, name, last_rental_date, total_rentals, status.
Bonus: Update the active flag in the customer table accordingly.
*/


SELECT 
	c.customer_id,
	CONCAT(c.first_name,' ',c.last_name) AS FullName,
	TO_CHAR((MAX(r.rental_date)::DATE),'DD Mon YYYY') AS last_rental_date,
	COUNT(DISTINCT r.rental_id) AS total_rentals,
	CASE 
		WHEN MAX(r.rental_date) >= (CURRENT_DATE - INTERVAL '6 months') THEN 'Active'
		-- (EXTRACT(YEAR FROM r.rental_date) = 2025) AND (EXTRACT(MONTH FROM r.rental_date) > 6) THEN 'Active'
		ELSE 'Inactive'
	END AS status
FROM customer AS c
INNER JOIN rental AS r
ON c.customer_id = r.customer_id
GROUP BY c.customer_id, FullName;
