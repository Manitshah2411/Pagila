/*
8. Longest Rental Streaks
Task:Find customers with the longest streak of consecutive days with at least one rental.
* Output customer_id, customer_name, streak_length, streak_start, streak_end.
* Ignore gaps larger than 1 day.
*/


WITH rental_dates AS
(
SELECT 
	DISTINCT 
	customer_id,
	rental_date::DATE AS rental_day
FROM rental AS r
), consecutive AS
(
SELECT 
	customer_id,
	rental_day,
	rental_day - ROW_NUMBER() OVER(PARTITION BY customer_id ORDER BY rental_day)::int AS grp
FROM rental_dates
), streak AS
(
SELECT 
	customer_id,
	MIN(rental_day) AS start_streak,
	MAX(rental_day) AS end_streak,
	COUNT(*) AS streak_length
FROM consecutive 
GROUP BY customer_id, grp
), ranked AS
(
SELECT 	
	st.*,
	RANK() OVER(PARTITION BY st.customer_id ORDER BY st.streak_length DESC) AS rnk
FROM streak AS st
)
SELECT 
	c.customer_id,
	CONCAT(c.first_name,' ',c.last_name) AS fullname,
	r.streak_length,
	r.start_streak,
	r.end_streak
FROM ranked AS r
INNER JOIN customer AS c
ON r.customer_id = c.customer_id
WHERE r.rnk = 1 
ORDER BY r.streak_length DESC, c.customer_id
	
