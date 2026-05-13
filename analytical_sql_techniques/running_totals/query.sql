SELECT
  TO_CHAR(signup_date, 'YYYY-MM') AS month,
  COUNT(*) AS new_users,
  SUM(COUNT(*)) OVER (
    ORDER BY TO_CHAR(signup_date, 'YYYY-MM')
  ) AS cumulative_users
FROM users
GROUP BY TO_CHAR(signup_date, 'YYYY-MM')
ORDER BY TO_CHAR(signup_date, 'YYYY-MM');