WITH
  customer_segments AS (
    SELECT
      c.customer_id,
      SUM(o.total) AS total_spend,
      CASE
        WHEN SUM(o.total) >= 2000 THEN 'High Value'
        WHEN SUM(o.total) >= 500  THEN 'Mid Value'
        ELSE 'Low Value'
      END AS segment
    FROM customers c
    JOIN orders o ON c.customer_id = o.customer_id
    GROUP BY c.customer_id
  ),
  segment_avg_order_value AS (
    SELECT
      segment,
      COUNT(DISTINCT customer_id)        AS customer_count,
      SUM(total_spend)                   AS segment_total_spend,
      SUM(total_spend) / COUNT(*)        AS avg_order_value
    FROM customer_segments
    GROUP BY segment
  )
SELECT
  segment,
  customer_count,
  segment_total_spend,
  ROUND(avg_order_value, 2) AS avg_order_value
FROM segment_avg_order_value
ORDER BY
  CASE segment
    WHEN 'High Value' THEN 1
    WHEN 'Mid Value'  THEN 2
    ELSE 3
  END;