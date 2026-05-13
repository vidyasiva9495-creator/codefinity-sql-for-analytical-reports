-- Show the percentage of users from each signup month who are still active after 3 months
WITH signup_cohorts AS (
  SELECT
    user_id,
    DATE_TRUNC('month', signup_date) AS cohort_month,
    signup_date
  FROM users
),
third_month_status AS (
  SELECT
    u.user_id,
    c.cohort_month,
    u.is_active,
    (c.cohort_month + INTERVAL '3 month')::DATE AS month_3_date
  FROM users u
  JOIN signup_cohorts c ON u.user_id = c.user_id
)
SELECT
  cohort_month,
  COUNT(user_id) AS cohort_size,
  SUM(CASE
        WHEN is_active = TRUE
          AND CURRENT_DATE >= month_3_date
        THEN 1 ELSE 0 END) AS retained_after_3_months,
  ROUND(
    100.0 * SUM(CASE
                  WHEN is_active = TRUE
                    AND CURRENT_DATE >= month_3_date
                THEN 1 ELSE 0 END) / COUNT(user_id),
    2
  ) AS retention_rate_after_3_months
FROM third_month_status
GROUP BY cohort_month
ORDER BY cohort_month;