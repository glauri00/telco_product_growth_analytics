SELECT 
	contract,
	COUNT(DISTINCT customerID) AS num_customers,
    ROUND(AVG(TotalCharges),2) AS avg_revenue_per_customer,
    ROUND(SUM(TotalCharges),2) AS total_revenue_per_contract
FROM info
GROUP BY contract
ORDER BY ROUND(SUM(TotalCharges),2) DESC
