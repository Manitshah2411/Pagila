/* 4. Customer Retention Cohort Analysis
Task:The business wants to analyze customer retention by cohort:
* Define cohort month = month of first rental.
* For each cohort, show how many customers rented again in the 2nd, 3rd, and 6th month after joining.
* Present it as: cohort_month | month_offset | retained_customers.. */

WITH CTE_cohort_month AS
(
SELECT 
	customer_id,
	DATE_TRUNC('month',MIN(rental_date)) AS cohort_month
FROM rental
GROUP BY customer_id
),
CTE_month_offset AS
(
SELECT 
	r.customer_id,
	ccm.cohort_month,
	(EXTRACT(YEAR FROM r.rental_date) - EXTRACT(YEAR FROM ccm.cohort_month)) * 12 +
	(EXTRACT(MONTH FROM r.rental_date) - EXTRACT(MONTH FROM ccm.cohort_month)) AS month_offset
FROM CTE_cohort_month AS ccm
INNER JOIN rental AS r
ON r.customer_id = ccm.customer_id
)
SELECT 
	cohort_month,
	month_offset,
	COUNT(DISTINCT customer_id) AS customer_retention
FROM CTE_month_offset AS cmo
GROUP BY cohort_month, month_offset;
