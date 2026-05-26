SELECT
  DATE_TRUNC('month', signup_date) AS registration_month,
  COUNT(*) AS new_users
FROM users
WHERE signup_date >= (CURRENT_DATE - INTERVAL '2 year')
GROUP BY registration_month
ORDER BY registration_month;
