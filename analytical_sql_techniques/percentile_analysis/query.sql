SELECT
  e.employee_id,
  e.first_name,
  e.last_name,
  e.department_id,
  d.name AS department_name,
  p.score,
  NTILE(4) OVER (
    PARTITION BY e.department_id
    ORDER BY p.score DESC
  ) AS performance_quartile
FROM
  hr_employees e
  JOIN performance p ON e.employee_id = p.employee_id
  JOIN departments d ON e.department_id = d.department_id
ORDER BY
  e.department_id,
  performance_quartile,
  p.score DESC;