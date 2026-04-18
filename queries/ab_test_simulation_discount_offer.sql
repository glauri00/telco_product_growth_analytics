WITH buckets AS(
	SELECT
		MOD(customerID, 2) AS bucket,
        CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END AS churn,
        TotalCharges
	FROM info
)

SELECT 
	bucket,
    ROUND(AVG(churn), 2) AS churn_rate,
    ROUND(AVG(CASE WHEN bucket = 0 THEN TotalCharges ELSE TotalCharges*0.9 END), 2) AS arpu,
    COUNT(*) AS customer_count
FROM buckets
GROUP BY bucket