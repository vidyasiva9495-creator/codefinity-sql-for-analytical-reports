SELECT
  st.name AS department,
  s.first_name,
  s.last_name,
  s.total_sales,
  s.rn
FROM (
  SELECT
    e.employee_id,
    e.store_id,
    e.first_name,
    e.last_name,
    SUM(sa.total_amount) AS total_sales,
    ROW_NUMBER() OVER (
      PARTITION BY e.store_id
      ORDER BY SUM(sa.total_amount) DESC
    ) AS rn
  FROM retail_employees e
  JOIN sales sa ON sa.employee_id = e.employee_id
  GROUP BY e.employee_id, e.store_id, e.first_name, e.last_name
) s
JOIN stores st ON s.store_id = st.store_id
WHERE s.rn <= 3
ORDER BY st.name, s.total_sales DESC;