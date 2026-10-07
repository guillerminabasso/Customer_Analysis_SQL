WITH customer_ltv AS (
	SELECT
		DISTINCT customerkey,
		SUM(ca.total_net_revenue) AS total_ltv
	FROM cohort_analysis ca 
	GROUP BY ca.customerkey 
),

customer_segments AS (
	SELECT 
		PERCENTILE_CONT(0.25) WITHIN GROUP (ORDER BY total_ltv) AS percentile_25th,
		PERCENTILE_CONT(0.75) WITHIN GROUP (ORDER BY total_ltv) AS percentile_75th
	FROM customer_ltv
),

segment_values AS (
	SELECT 
		c.customerkey,
		c.total_ltv,
		CASE
			WHEN c.total_ltv < cs.percentile_25th THEN '1 - Low Value'
			WHEN c.total_ltv > cs.percentile_75th THEN '3 - High Value'
			ELSE '2 - Mid Value'
		END AS customer_segment	
	FROM customer_ltv c
	CROSS JOIN customer_segments cs
)

SELECT 
	customer_segment,
	SUM(total_ltv) AS total_ltv,
	SUM(total_ltv) / (SELECT SUM(total_ltv) FROM segment_values) * 100 AS ltv_percentage,
	COUNT(customerkey) AS customer_count,
	ROUND((COUNT(customerkey) / (SUM(COUNT(customerkey)) OVER())) * 100, 2) AS customer_percentage,
	SUM(total_ltv) / COUNT(customerkey) AS avg_ltv
FROM segment_values
GROUP BY customer_segment 
ORDER BY total_ltv DESC