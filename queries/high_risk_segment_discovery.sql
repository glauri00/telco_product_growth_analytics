SELECT 
	Contract,
	InternetService,
    PaymentMethod,
    AVG(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) AS churn_rate
FROM info
GROUP BY Contract, InternetService, PaymentMethod
ORDER BY churn_rate DESC
LIMIT 5