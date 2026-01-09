/* 
7. Staff Performance & Store Insights
Task:For each staff member, generate a report:
* Total rentals handled, total revenue collected, average payment size.
* Show their rank within the store by revenue.
* Also show which store overall has the highest revenue.
*/

SELECT * FROM staff;
SELECT * FROM store;
SELECT * FROM rental;

WITH CTE_staff AS
(SELECT 
	s.staff_id,
	CONCAT(s.first_name,' ',s.last_name) AS Fullname,
	st.store_id,
	COUNT(DISTINCT r.rental_id) AS total_rental_handled
FROM staff AS s
INNER JOIN rental AS r
ON r.staff_id = s.staff_id
INNER JOIN store AS st
ON st.store_id = s.store_id
GROUP BY s.staff_id,
		 CONCAT(s.first_name,' ',s.last_name),
		 st.store_id
), CTE_aggre AS
(
SELECT 
	cs.staff_id,
	cs.Fullname,
	cs.store_id,
	cs.total_rental_handled,
	SUM(p.amount) AS total_revenue,
	ROUND(AVG(p.amount),2) AS avg_payment_size
FROM CTE_staff AS cs
INNER JOIN payment AS p 
ON p.staff_id = cs.staff_id
GROUP BY cs.staff_id,
	cs.Fullname,
	cs.store_id,
	cs.total_rental_handled
)
SELECT 
	ca.*,
	RANK() OVER(PARTITION BY ca.store_id ORDER BY ca.total_revenue DESC) AS ranked_on_total_revenue,
	CASE 
		WHEN MAX(total_revenue) OVER(PARTITION BY ca.store_id)= ca.total_revenue THEN 'Highest'
		ELSE NULL
	END AS max_store_revnue
FROM CTE_aggre ca;