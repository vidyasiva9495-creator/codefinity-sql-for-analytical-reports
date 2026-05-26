-- Find continuous periods ("islands") of absence for each employee in the HR system
WITH absences AS (
  SELECT
    employee_id,
    absence_date
  FROM (
    -- Simulate an absence log for demonstration (replace with real absence table if available)
    VALUES
      (1, '2024-01-10'::date),
      (1, '2024-01-11'::date),
      (1, '2024-01-13'::date),
      (2, '2024-01-15'::date),
      (2, '2024-01-16'::date),
      (2, '2024-01-17'::date),
      (3, '2024-01-20'::date)
  ) AS t(employee_id, absence_date)
),
numbered AS (
  SELECT
    employee_id,
    absence_date,
    ROW_NUMBER() OVER (PARTITION BY employee_id ORDER BY absence_date) AS rn
  FROM absences
),
grouped AS (
  SELECT
    employee_id,
    absence_date,
    absence_date - INTERVAL '1 day' * (rn - 1) AS grp
  FROM numbered
)
SELECT
  employee_id,
  MIN(absence_date) AS period_start,
  MAX(absence_date) AS period_end,
  COUNT(*)         AS days_absent
FROM grouped
GROUP BY employee_id, grp
ORDER BY employee_id, period_start;