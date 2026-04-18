WITH traslation AS (
	SELECT 
		(CASE WHEN OnlineSecurity = 'Yes' THEN 1 ELSE 0 END) AS online_sec,
		(CASE WHEN OnlineBackup = 'Yes' THEN 1 ELSE 0 END) AS online_back,
		(CASE WHEN DeviceProtection = 'Yes' THEN 1 ELSE 0 END) AS dev_prot,
		(CASE WHEN TechSupport = 'Yes' THEN 1 ELSE 0 END) AS tech_supp,
		(CASE WHEN StreamingTV = 'Yes' THEN 1 ELSE 0 END) AS stream_tv,
		(CASE WHEN StreamingMovies = 'Yes' THEN 1 ELSE 0 END) AS stream_mov,
        tenure,
        Churn,
        TotalCharges
	FROM info),
total_services AS(
	SELECT 
		online_sec + online_back + dev_prot + tech_supp + stream_tv + stream_mov AS num_yes,
        tenure,
        Churn,
        TotalCharges
    FROM traslation
)

	
SELECT 
	ROUND(AVG(CASE WHEN num_yes >= 3 AND Churn = 'Yes' THEN 1 ELSE 0 END), 2) AS more_than_3_addson_churn_rate,
    ROUND(AVG(CASE WHEN num_yes < 3 AND Churn = 'Yes' THEN 1 ELSE 0 END), 2) AS less_than_3_addson_churn_rate
FROM total_services