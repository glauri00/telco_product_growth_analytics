SELECT
    Contract,
    ROUND(SUM(CASE WHEN Churn = 'Yes' THEN MonthlyCharges*12 ELSE 0 END), 2) AS revenue_at_risk,
    ROUND(SUM(CASE WHEN Churn = 'No' THEN MonthlyCharges*12 ELSE 0 END), 2) AS revenue_not_at_risk
FROM info
GROUP BY Contract;

