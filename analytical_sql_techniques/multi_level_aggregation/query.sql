SELECT region,
 SUM(total_sales) AS total_revenue
    FROM product_sales
GROUP BY region
ORDER BY region;
