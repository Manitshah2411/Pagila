📊 Business Analytics & Data Engineering on Pagila Database

Overview 

This project simulates how a real company would analyze transactional data using SQL and analytics engineering techniques.

I used the Pagila PostgreSQL database (a DVD rental system similar to Sakila) and built business-driven queries to help management understand:
	•	Customer value
	•	Film performance
	•	Store revenue trends
	•	Retention & churn
	•	Staff efficiency
	•	Product cleanup decisions

The focus of this project was not just writing SQL, but designing queries that answer real business questions.

⸻

🗄️ Dataset

Pagila PostgreSQL DB

Contains:
	•	Customers
	•	Rentals
	•	Payments
	•	Films
	•	Categories
	•	Stores
	•	Staff

This mimics a real transactional system used by a media rental business.

⸻

🧩 Business Problems Solved

1. Customer Lifetime Value (CLV)

Identified the top revenue-generating customers by:
	•	Total rentals
	•	Total revenue
	•	Average payment
	•	City-wise ranking

This helps marketing target high-value customers.

⸻

2. Film Performance by Category

For each film category:
	•	Ranked the top rented films
	•	Calculated revenue per film
	•	Excluded low-volume categories

This helps decide which content to promote or remove.

⸻

3. Store Revenue vs Targets

Built a monthly revenue tracker per store:
	•	Compared revenue against a $10,000 target
	•	Calculated running totals
	•	Flagged the month when a store crossed $30,000

This is exactly how financial dashboards are built.

⸻

4. Customer Retention Cohorts

Created a cohort analysis where:
	•	Customers were grouped by first rental month
	•	Retention was measured at 2, 3 and 6 months

This shows customer loyalty and churn patterns.

⸻

5. Never-Rented & Low-Performing Films

Identified:
	•	Films that were never rented
	•	Films that earned less than $50

This helps the business clean up inventory.

⸻

6. Active vs Inactive Customers

Classified customers as:
	•	Active (rented in last 6 months)
	•	Inactive

Also calculated:
	•	Last rental date
	•	Total rentals

Useful for re-engagement campaigns.

⸻

7. Staff Performance

For each staff member:
	•	Total rentals handled
	•	Total revenue
	•	Average payment size
	•	Ranked within each store

This helps evaluate employee performance.

⸻

8. Customer Rental Streaks

Calculated:
	•	Longest streak of consecutive rental days per customer
	•	Start and end of each streak

This shows high-engagement users.

⸻

🛠️ Skills Demonstrated
	•	Advanced SQL (CTEs, window functions, ranking, time logic)
	•	Business-driven analytics
	•	Cohort analysis
	•	Revenue tracking
	•	Performance analytics
	•	Data modeling thinking
	•	PostgreSQL
