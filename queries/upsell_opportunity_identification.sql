WITH median_calc AS (
	SELECT 
		PERCENTILE_DISC(0.5) WITHIN GROUP (ORDER BY MonthlyCharges) AS Mediana
	FROM info
)
SELECT COUNT(customerID)
FROM info
WHERE tenure> 24 AND MonthlyCharges < (SELECT Mediana FROM median_calc)