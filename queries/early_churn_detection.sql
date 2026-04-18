WITH clusters AS(
	SELECT 
		Churn,
        customerID,
		CASE WHEN tenure <= 3 THEN '3 months'
			WHEN tenure <= 6 THEN '6 months'
			WHEN tenure <= 12 THEN '12 months' 
            ELSE '12+ months'END AS cluster
	FROM info
)

SELECT 
	cluster,
    COUNT(customerID) AS total_customers_per_cluster,
    AVG(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) AS churn_rate
FROM clusters
GROUP BY cluster
ORDER BY churn_rate DESC