/*
3. Store Revenue vs Targets
Task:Management set a monthly target of $10,000 per store. Build a query to:
* Show store_id, month, total revenue, target_status (Above/Below Target).
* For each store, calculate the running total revenue across months.
* Highlight the first month when the store crossed $30,000 cumulative revenue.
*/
SELECT
	x.store_id,
	TO_CHAR(x.mon_date,'Mon YYYY') AS mon,
	x.total_revenue,
	x.target_status,
	x.running_total,
	CASE 
		WHEN x.running_total > 30000
		AND COALESCE(LAG(x.running_total) OVER(PARTITION BY x.store_id ORDER BY x.mon_date),0) < 30000 
		THEN 'Milestone Month'
		ELSE NULL
	END AS Milestone_month
FROM
(SELECT
	t.store_id,
	t.mon_date,
	t.total_revenue,
	t.target_status,
	SUM(t.total_revenue) OVER(PARTITION BY t.store_id ORDER BY t.mon_date) AS running_total
FROM
(SELECT 
	s.store_id,
	DATE_TRUNC('month', r.rental_date) AS mon_date,
	SUM(p.amount) AS total_revenue,
	CASE 
		WHEN SUM(p.amount) > 10000 THEN 'Above Target'
		ELSE 'Below Target'
	END AS target_status
FROM store AS s
INNER JOIN inventory AS i
ON i.store_id = s.store_id
INNER JOIN rental AS r
ON r.inventory_id = i.inventory_id
INNER JOIN payment AS p
ON p.rental_id = r.rental_id
GROUP BY s.store_id,
		 DATE_TRUNC('month', r.rental_date))t)x;
