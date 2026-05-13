WITH emp_totals AS (
  SELECT
    hr.department_id,
    hr.employee_id,
    hr.first_name,
    hr.last_name,
    SUM(s.total_amount) AS total_sales
  FROM hr_employees hr
  JOIN sales s
    ON s.employee_id = hr.employee_id
  GROUP BY
    hr.department_id,
    hr.employee_id,
    hr.first_name,
    hr.last_name
)
SELECT
  department_id,
  employee_id,
  first_name,
  last_name,
  total_sales,
  RANK() OVER (
    PARTITION BY department_id
    ORDER BY total_sales DESC
  ) AS sales_rank
FROM emp_totals
ORDER BY department_id, sales_rank;