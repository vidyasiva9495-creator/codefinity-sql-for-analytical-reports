WITH signup_cohorts AS (
  SELECT
    user_id,
    DATE_TRUNC('week', signup_date) AS cohort_week
  FROM users
  WHERE signup_date >= '2023-01-01'
),
first_week_activity AS (
  SELECT
    cohort_week,
    COUNT(DISTINCT user_id) AS cohort_size
  FROM signup_cohorts
  GROUP BY cohort_week
),
activity_weeks AS (
  SELECT
    u.user_id,
    u.cohort_week,
    s.start_date,
    FLOOR((s.start_date - u.cohort_week::date) / 7.0) AS week_number
  FROM signup_cohorts u
  JOIN subscriptions s ON u.user_id = s.user_id
  WHERE s.start_date >= u.cohort_week
),
retention_by_week AS (
  SELECT
    cohort_week,
    week_number,
    COUNT(DISTINCT user_id) AS retained_users
  FROM activity_weeks
  GROUP BY cohort_week, week_number
)
SELECT
  r.cohort_week,
  r.week_number,
  r.retained_users,
  f.cohort_size,
  ROUND(100.0 * r.retained_users / f.cohort_size, 2) AS retention_rate_percent
FROM retention_by_week r
JOIN first_week_activity f ON r.cohort_week = f.cohort_week
ORDER BY r.cohort_week, r.week_number;