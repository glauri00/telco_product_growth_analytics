WITH buckets AS (
    SELECT
        CASE 
            WHEN tenure <= 6 THEN '0-6'
            WHEN tenure <= 12 THEN '6-12'
            WHEN tenure <= 24 THEN '12-24'
            WHEN tenure <= 48 THEN '24-48'
            ELSE '48+'
        END AS bucket,
        TotalCharges,
        Churn
    FROM info
)

SELECT
    bucket,
    COUNT(*) AS total_clients,
    ROUND(AVG(TotalCharges), 2) AS arpu,
    ROUND(AVG(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END), 2) AS churn_rate
FROM buckets
GROUP BY bucket
ORDER BY 
    CASE bucket
        WHEN '0-6' THEN 1
        WHEN '6-12' THEN 2
        WHEN '12-24' THEN 3
        WHEN '24-48' THEN 4
        ELSE 5
    END;