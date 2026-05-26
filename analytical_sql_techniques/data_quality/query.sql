SELECT
  sale_id,
  store_id,
  employee_id,
  sale_date,
  product,
  category,
  quantity,
  unit_price,
  total_amount
FROM sales
WHERE total_amount <= 0;