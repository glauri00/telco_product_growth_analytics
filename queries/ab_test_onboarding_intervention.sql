WITH buckets AS(
	SELECT 
		CASE WHEN MOD(customerID, 2) = 0 THEN 'control' ELSE 'treatment' END AS bucket,
        CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END AS churn
	FROM info
)
SELECT 
	bucket,
    AVG(churn) AS churn_rate
FROM buckets
GROUP BY bucket