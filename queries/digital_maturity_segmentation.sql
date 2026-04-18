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
	num_yes AS number_of_services, 
    count(*) AS number_of_users,
    ROUND(AVG(tenure), 2) AS average_tenure,
    ROUND(AVG(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END), 2) AS churn_rate,
    ROUND(AVG(TotalCharges), 2) AS arpu
FROM total_services
GROUP BY num_yes