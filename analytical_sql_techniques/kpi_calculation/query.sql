SELECT
  u.signup_date,
  COUNT(u.user_id) AS cohort_size,
  COUNT(s.user_id) AS retained_users,
  ROUND(
    COUNT(s.user_id)::decimal 
    / NULLIF(COUNT(u.user_id), 0) * 100,
    2
  ) AS retention_rate_percent
FROM users u
LEFT JOIN subscriptions s
  ON s.user_id = u.user_id
  AND s.start_date <= u.signup_date + INTERVAL '30 days'
  AND (s.end_date IS NULL OR s.end_date > u.signup_date + INTERVAL '30 days')
GROUP BY u.signup_date
ORDER BY u.signup_date;