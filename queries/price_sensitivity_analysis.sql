SELECT 
    quintile,
    AVG(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) AS churn_rate,
    ROUND(AVG(TotalCharges),2) AS arpu,
    COUNT(customerID) AS number_of_clients
FROM (
    SELECT 
        customerID,
        TotalCharges,
        Churn,
        NTILE(5) OVER (ORDER BY MonthlyCharges) AS quintile
    FROM info
) t
GROUP BY quintile
ORDER BY quintile;