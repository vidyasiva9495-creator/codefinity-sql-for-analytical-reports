SELECT
  category,
  EXTRACT(YEAR FROM sale_date) AS year,
  SUM(total_sales) AS yearly_revenue,
  LAG(SUM(total_sales)) OVER (
    PARTITION BY category
    ORDER BY EXTRACT(YEAR FROM sale_date)
  ) AS last_year_revenue,
  SUM(total_sales)
    - LAG(SUM(total_sales)) OVER (
        PARTITION BY category
        ORDER BY EXTRACT(YEAR FROM sale_date)
      ) AS revenue_change
FROM product_sales
GROUP BY category, EXTRACT(YEAR FROM sale_date)
ORDER BY category, year;