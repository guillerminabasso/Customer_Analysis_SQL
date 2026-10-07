SELECT 
	cohort_year,
	SUM(ca.total_net_revenue) AS net_revenue,
	COUNT(DISTINCT customerkey) AS customer_count,
	SUM(ca.total_net_revenue) / COUNT(DISTINCT customerkey) avg_revenue
FROM cohort_analysis ca 
GROUP BY cohort_year;

WITH purchase_days AS (
	SELECT
	    customerkey,
	    total_net_revenue,
	    orderdate - MIN(orderdate) OVER (PARTITION BY customerkey) AS days_since_first_purchase
	FROM cohort_analysis
)

SELECT
	days_since_first_purchase, 
	SUM(total_net_revenue) AS total_revenue,
	SUM(total_net_revenue) / (SELECT SUM(total_net_revenue) FROM cohort_analysis ca) * 100 AS percentage_of_total_revenue,
	SUM(SUM(total_net_revenue) / (SELECT SUM(total_net_revenue) FROM cohort_analysis ca) * 100) OVER (ORDER BY days_since_first_purchase) AS acum_perc_of_rev
FROM purchase_days
GROUP BY days_since_first_purchase 

SELECT
    cohort_year,
    SUM(total_net_revenue) AS total_revenue,
    COUNT(DISTINCT customerkey) AS total_customers,
    SUM(total_net_revenue) / COUNT(DISTINCT customerkey) AS customer_revenue
FROM cohort_analysis
WHERE orderdate = first_purchase_date
GROUP BY 
    cohort_year;

SELECT 
	COUNT(DISTINCT customerkey) AS customers,
	SUM(total_net_revenue) AS net_revenue,
	TO_CHAR(orderdate, 'YYYY-MM') AS year_month
FROM cohort_analysis ca 
GROUP BY TO_CHAR(orderdate, 'YYYY-MM')
ORDER BY year_month