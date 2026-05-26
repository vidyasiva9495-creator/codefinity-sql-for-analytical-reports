SELECT
  c.customer_id,
  c.first_name,
  c.last_name,
  COUNT(o.order_id) AS frequency,
  SUM(o.total)      AS monetary
FROM
  customers c
JOIN
  orders o 
  ON c.customer_id = o.customer_id
GROUP BY
  c.customer_id,
  c.first_name,
  c.last_name
HAVING
  COUNT(o.order_id) >= 2
  AND SUM(o.total) >= 1000
ORDER BY
  monetary DESC;