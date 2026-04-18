WITH buckets AS(
	SELECT 
		CASE WHEN MOD(customerID, 2) = 0 THEN 'control' ELSE 'treatment' END AS bucket,
        CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END AS churn
	FROM info
),
churns AS (
		SELECT 
		AVG(CASE WHEN bucket = 'control' THEN churn END ) AS control_rate,
		AVG(CASE WHEN bucket = 'treatment' THEN churn END ) AS treatment_rate
	FROM buckets
)
SELECT 
	control_rate,
    treatment_rate,
    treatment_rate - control_rate AS absolute_difference,
    ROUND((treatment_rate - control_rate)/control_rate,2) AS lift
FROM churns
