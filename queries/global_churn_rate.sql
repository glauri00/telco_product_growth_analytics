WITH churn_rates AS (
    SELECT AVG(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) AS total_churn_rate
    FROM info
)
SELECT 
    Contract,
    PaymentMethod,
    AVG(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) AS churn_rate,
    (SELECT total_churn_rate FROM churn_rates) AS total_churn_rate
FROM info
GROUP BY Contract, PaymentMethod;