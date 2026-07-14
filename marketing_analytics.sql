USE marketing_analytics;
SHOW TABLES;
SELECT COUNT(*) AS total_customers
FROM `test-3`;
SELECT
    target,
    COUNT(*) AS customers,
    ROUND(COUNT(*) * 100.0 / (SELECT COUNT(*) FROM `test-3`),2) AS percentage
FROM `test-3`
GROUP BY target;
SELECT
    gender,
    COUNT(*) AS total_customers
FROM `test-3`
GROUP BY gender
ORDER BY total_customers DESC;
SELECT
    job,
    COUNT(*) AS total_customers
FROM `test-3`
GROUP BY job
ORDER BY total_customers DESC;
SELECT
    job,
    ROUND(AVG(accountBalance),2) AS avg_balance
FROM `test-3`
GROUP BY job
ORDER BY avg_balance DESC;
SELECT
    maritalStatus,
    COUNT(*) AS total
FROM `test-3`
GROUP BY maritalStatus;
SELECT
    education,
    COUNT(*) AS total
FROM `test-3`
GROUP BY education
ORDER BY total DESC;
SELECT
ROUND(AVG(duration),2) AS avg_call_duration
FROM `test-3`;
SELECT
id,
duration,
job,
target
FROM `test-3`
ORDER BY duration DESC
LIMIT 10;
SELECT
ROUND(AVG(age),2) AS average_age
FROM `test-3`;
SELECT
CASE
WHEN age BETWEEN 18 AND 25 THEN '18-25'
WHEN age BETWEEN 26 AND 35 THEN '26-35'
WHEN age BETWEEN 36 AND 45 THEN '36-45'
WHEN age BETWEEN 46 AND 55 THEN '46-55'
ELSE '56+'
END AS age_group,
COUNT(*) AS customers
FROM `test-3`
GROUP BY age_group;
SELECT
contactType,
COUNT(*) AS customers
FROM `test-3`
GROUP BY contactType;
SELECT
lastCampaignResult,
COUNT(*) AS customers
FROM `test-3`
GROUP BY lastCampaignResult
ORDER BY customers DESC;
SELECT
target,
ROUND(AVG(accountBalance),2) AS average_balance
FROM `test-3`
GROUP BY target;
SELECT
month,
COUNT(*) AS total_calls
FROM `test-3`
GROUP BY month
ORDER BY FIELD(month,
'jan','feb','mar','apr','may','jun',
'jul','aug','sep','oct','nov','dec');
SELECT
job,
COUNT(*) AS successful_campaigns
FROM `test-3`
WHERE target='yes'
GROUP BY job
ORDER BY successful_campaigns DESC;
SELECT
ROUND(AVG(numberOfContacts),2) AS avg_contacts
FROM `test-3`;
SELECT
house,
COUNT(*) AS customers
FROM `test-3`
GROUP BY house;
SELECT
credit,
COUNT(*) AS customers
FROM `test-3`
GROUP BY credit;
SELECT
COUNT(*) AS Total_Customers,
SUM(target='yes') AS Successful_Campaigns,
ROUND(AVG(accountBalance),2) AS Avg_Balance,
ROUND(AVG(duration),2) AS Avg_Call_Duration,
ROUND(AVG(age),2) AS Avg_Age
FROM `test-3`;
WITH job_success AS (
SELECT
job,
COUNT(*) AS successful_campaigns
FROM `test-3`
WHERE target = 'yes'
GROUP BY job
)

SELECT
job,
successful_campaigns,
RANK() OVER(ORDER BY successful_campaigns DESC) AS job_rank
FROM job_success;
SELECT
job,
COUNT(*) AS total_customers,
SUM(target='yes') AS successful_campaigns,
ROUND(SUM(target='yes')*100/COUNT(*),2) AS success_rate
FROM `test-3`
GROUP BY job
ORDER BY success_rate DESC
LIMIT 5;
WITH monthly_calls AS
(
SELECT
month,
COUNT(*) AS total_calls
FROM `test-3`
GROUP BY month
)

SELECT
month,
total_calls,
SUM(total_calls) OVER(ORDER BY FIELD(month,
'jan','feb','mar','apr','may','jun',
'jul','aug','sep','oct','nov','dec')) AS running_total
FROM monthly_calls;
SELECT
id,
accountBalance,
RANK() OVER(ORDER BY accountBalance DESC) AS balance_rank
FROM `test-3`;
SELECT
id,
accountBalance,
CASE
WHEN accountBalance < 1000 THEN 'Low Balance'
WHEN accountBalance BETWEEN 1000 AND 5000 THEN 'Medium Balance'
ELSE 'High Balance'
END AS balance_segment
FROM `test-3`;
SELECT
id,
accountBalance
FROM `test-3`
WHERE accountBalance >
(
SELECT AVG(accountBalance)
FROM `test-3`
);
SELECT
CASE
WHEN age BETWEEN 18 AND 30 THEN '18-30'
WHEN age BETWEEN 31 AND 40 THEN '31-40'
WHEN age BETWEEN 41 AND 50 THEN '41-50'
ELSE '51+'
END AS age_group,

COUNT(*) AS customers,

SUM(target='yes') AS successful_campaigns,

ROUND(SUM(target='yes')*100/COUNT(*),2) AS success_rate

FROM `test-3`

GROUP BY age_group

ORDER BY success_rate DESC;
SELECT
id,
duration,
DENSE_RANK() OVER(ORDER BY duration DESC) AS duration_rank
FROM `test-3`;
SELECT

lastCampaignResult,

COUNT(*) AS customers,

SUM(target='yes') AS successful_campaigns,

ROUND(SUM(target='yes')*100/COUNT(*),2) AS success_rate

FROM `test-3`

GROUP BY lastCampaignResult

ORDER BY success_rate DESC;
SELECT
id,
accountBalance,
NTILE(4) OVER(ORDER BY accountBalance DESC) AS customer_quartile
FROM `test-3`;
