# Intermediate SQL - Sales Analysis

This project has been built to better understand our customers and their contribution to the revenue.

## Overview

## Business Questions

1. **Customer Segmentation Analysis:** Who are our most valuable customers?
2. **Cohort Analysis:** How do different customer groups generate revenue?
3. **Customer Retention:** Which customers haven't purchased recently?

## Create View

- Aggregated revenue and order activity at customer/date level.
- Joined sales and customer data to enrich the analysis with country information.
- Calculated first purchase date and cohort year using window functions.

## Analysis

### 1. Customer Segmentation

🖥️ Query: [Customer Segmentation SQL](sql\1_customer_segmentation.sql)

- Calculated customer lifetime value (LTV) by aggregating total net revenue for each customer.
- Segmented customers by LTV using the 25th and 75th percentiles to identify Low-, Mid-, and High-Value customers.
- Analyzed segment performance by comparing total LTV, revenue contribution, customer count, and average LTV across segments.

📈 Visualization:

![Customer Segmentation](/images/1_customer_segmentation.png)

📊 Key Findings:

- High-Value segment (25% of customers) represents 66% of the revenue.
- Mid-Value segment (50 % of customers) represents 32% of the revenue. 
- Low-Value segment (25% of customers) represents only 2.1% of the revenue.

💡 Business Insights

- **High-Value:** Prioritize retention and loyalty initiatives to protect the largest share of revenue and strengthen long-term customer value.

- **Mid-Value:** Look for opportunities to upsell and cross-sell and move more customers into the High-Value group.

- **Low-Value:** Use simple, low-cost campaigns to test whether these customers can be encouraged to increase their spending.

💡 Next Steps

**Value × Potential:** Customer value should be combined with future potential to define more targeted strategies. Potential could be assessed using purchase frequency, recency, repeat purchase behavior, and spending trends. This would allow the business to distinguish between low-value customers worth developing and customers better suited to low-cost or reduced-service strategies.

![](/images/1_value_vs_potential_matrix.png)  


### 2. Cohort Analysis

🖥️ Query: [Customer Segmentation SQL](sql\2_cohort_analysis.sql)

- Tracked revenue and customer count per cohort
- Cohorts were grouped by year of first purchase
- Analyzed customer retention at a cohort level

📈 Visualizations

Two different approaches were taken. The first one accounts for all of the purchases of each customer. Here the results: 

![Cohort Analysis not adjusted in time](/images/2a_cohort_analysis.png)

From this chart we see the less influence into the revenue for newer customers which can give biased results. Moreover, a deeper analysis of purchase date was made, and we found out that 60% of the total revenue comes from customers buying on their first day of purchase. That is why a second query was built taking in account only for the first day of purchase of each customer (QUERY HERE). Here the resulted chart: 

![Cohort Analysis adjusted in time](/images/2b_cohort_analysis.png)

📊 Key Findings

- 60% of total revenue is generated on customers' first day of purchase.
- Revenue per customer on the first purchase shows a declining trend across cohorts.
- More recent cohorts generate less revenue per customer at their initial purchase than earlier cohorts.

💡 Business Insights

- The decline in initial revenue per customer suggests that newer customers are generating less value at the start of their relationship with the company. This could indicate changes in customer purchasing behavior, product mix, pricing, or customer profile. Further analysis would be required to determine the underlying cause.
- Reduced customer purchasing power could be one possible explanation, but this cannot be confirmed with the available data.

After finding that newer customers generate less value, a 3-month rolling average chart was built to analyze how revenue and customer count fluctuate over time.

![Revenue vs Customer 3-months rolling](/images/2c_revenue_vs_customers.png)

The trend shows that in 2023 and 2024, customer count recovered more strongly than revenue. This suggests that the decline in revenue was not driven solely by having fewer customers. Revenue per customer also declined, meaning that customers were generating less revenue on average.

### 3. Customer Retention

🖥️ Query: [Retention Analysis SQL](sql\3_retention_analysis.sql)

- Identified customers at risk of churning
- Analyzed last purchase patterns
- Calculated customer-specific metrics

📈 Visualization:

![Active vs Churned Customers](/images/3_customer_status.png)

*For each customer cohort, current status was determined by purchase recency: customers with no purchase in the last six months were classified as churned, while those who purchased within the last six months were classified as active; customers acquired within the last six months were excluded.*

📊 Key Findings:

- Approximately 90% of customers are classified as churned, while only around 10% remain active, indicating a very low current retention rate across the customer base.
- The active-to-churned distribution is consistently similar across cohorts, suggesting that the high churn rate is not specific to customers acquired in a particular year.
- More recent cohorts show a similar pattern to earlier cohorts, indicating that the overall retention issue has persisted over time.

💡 Business Insights:

- Strengthen customer retention: The high proportion of churned customers highlights an opportunity to increase customer lifetime by improving ongoing engagement and repeat purchasing.
- Prioritize high-value customers: Rather than applying broad retention campaigns, focus re-engagement efforts on high-value churned customers, where successful reactivation could generate a higher return on investment.
- Identify at-risk customers earlier: Since churn is defined based on six months of inactivity, customer-specific purchase patterns could be used to identify customers approaching this threshold and trigger targeted interventions before they become churned.

## Strategic Recommendations

1. **Customer Value Optimization** *(Customer Segmentation)*
   - Prioritize retention and loyalty initiatives for High-Value customers, who represent 25% of the customer base but generate approximately 66% of total revenue.
   - Develop upselling and cross-selling strategies for Mid-Value customers to increase their contribution and move more customers into the High-Value segment.
   - Use low-cost, targeted campaigns for Low-Value customers to test opportunities to increase purchase frequency and spending.

2. **Customer Revenue & Cohort Strategy** *(Cohort Analysis)*
   - Investigate the decline in revenue per customer among newer cohorts by analyzing changes in product mix, pricing, purchasing behavior, and customer profiles.
   - Focus on increasing the value generated during customers' initial purchases, given that 60% of total revenue is generated on the first day of purchase.
   - Monitor both customer count and revenue per customer, as the analysis shows that revenue can decline even when customer numbers recover.

3. **Retention & Churn Prevention** *(Customer Retention)*
   - Address the high proportion of churned customers by strengthening engagement and encouraging repeat purchases.
   - Prioritize high-value churned customers for targeted win-back campaigns, where successful reactivation could generate a higher return on investment.
   - Use purchase recency and customer-level behavior to identify customers approaching the six-month inactivity threshold and trigger proactive re-engagement actions.

## Connection with the Revenue Decline Analysis Project

This project builds on my previous **Revenue Decline Analysis**, which investigated the revenue declines observed in 2020 and 2023 and identified the main factors associated with each decline.

The previous analysis showed that **customer and order volume were important drivers of the revenue declines**, particularly in 2020, when the business experienced a substantial loss of customers. In 2023, however, the decline was more balanced, with both lower order volume and lower revenue per order contributing to the decrease. The analysis also identified **weaker customer and cohort performance and declining order value as areas requiring further investigation**.

This project takes the customer analysis one step further by moving from overall customer volume to **customer value and purchasing behavior**. In particular, it investigates why customers may be generating less revenue over time by analyzing customer segmentation, cohort performance, initial purchase value, and retention.

The objective is therefore not to repeat the previous revenue decline analysis, but to **deepen one of the questions it raised: beyond changes in customer volume, how is customer value changing, and what customer behaviors may help explain the decline in revenue?**

In short, the first project identified where and when revenue declined; this project investigates customer value and behavior to better understand why.