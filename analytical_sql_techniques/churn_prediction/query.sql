SELECT
    u.user_id,
    u.username,
    u.full_name,
    s.plan,
    s.status,
    s.end_date
FROM users u
JOIN subscriptions s ON u.user_id = s.user_id
WHERE
    (s.status = 'Expired' OR s.plan <> u.plan_at_signup)
    AND s.end_date >= '2023-01-01'
ORDER BY s.end_date DESC;