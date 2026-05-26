SELECT
  d.name AS department,
  COUNT(CASE WHEN he.position = 'Manager' THEN 1 END)         AS manager_count,
  COUNT(CASE WHEN he.position = 'Sales Representative' THEN 1 END) AS sales_rep_count,
  COUNT(CASE WHEN he.position = 'Software Engineer' THEN 1 END)    AS software_eng_count,
  COUNT(CASE WHEN he.position = 'HR Specialist' THEN 1 END)        AS hr_specialist_count
FROM departments d
LEFT JOIN hr_employees he
  ON d.department_id = he.department_id
GROUP BY d.name
ORDER BY d.name;