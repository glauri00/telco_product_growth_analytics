WITH buckets AS(
	SELECT 
		CASE WHEN OnlineSecurity = 'Yes' THEN 'online_sec'
			WHEN TechSupport = 'Yes' THEN 'tech_support'
            WHEN StreamingTV = 'Yes' THEN 'streaming_tv'
            ELSE 'streaming_movies' END AS bucket,
		Churn
	FROM info
)
SELECT 
	bucket,
	AVG(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) AS churn_rate,
    COUNT(*) AS total_customers
FROM buckets
GROUP BY bucket
ORDER BY bucket