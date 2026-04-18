WITH total_rev_customer AS (
SELECT
	customerID AS customer_id,
	SUM(TotalCharges) AS total_revenue_per_customer
FROM info
GROUP BY customerID
),
ranked_customers AS(
SELECT
	NTILE(10) OVER(ORDER BY total_revenue_per_customer DESC) AS ranking,
    total_revenue_per_customer
FROM total_rev_customer
),
top_customers AS(
SELECT 
	ROUND(SUM(CASE WHEN ranking = 1 THEN total_revenue_per_customer END),2) AS top_10_revenue,
    ROUND(SUM(CASE WHEN ranking <= 2 THEN total_revenue_per_customer END),2) AS top_20_revenue,
    ROUND(SUM(CASE WHEN ranking <= 5 THEN total_revenue_per_customer END),2) AS top_50_revenue,
    ROUND(SUM(total_revenue_per_customer), 2) AS total_rev
FROM ranked_customers
)
SELECT 
	ROUND(top_10_revenue/total_rev, 2) AS top_10_pct,
    ROUND(top_20_revenue/total_rev, 2) AS top_20_pct,
    ROUND(top_50_revenue/total_rev, 2) AS top_50_pct
FROM top_customers