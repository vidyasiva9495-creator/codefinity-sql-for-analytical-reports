SELECT
  COUNT(*) AS total_leads,
  SUM(CASE WHEN status = 'Contacted' THEN 1 ELSE 0 END) AS contacted_leads,
  SUM(CASE WHEN status = 'Converted' THEN 1 ELSE 0 END) AS converted_leads,
  ROUND(
    100.0 * 
      (COUNT(*) - SUM(CASE WHEN status = 'Contacted' THEN 1 ELSE 0 END)) 
      / NULLIF(COUNT(*),0)
  , 2) AS dropoff_lead_to_contacted_pct,
  ROUND(
    100.0 * 
      (SUM(CASE WHEN status = 'Contacted' THEN 1 ELSE 0 END)
       - SUM(CASE WHEN status = 'Converted' THEN 1 ELSE 0 END))
      / NULLIF(SUM(CASE WHEN status = 'Contacted' THEN 1 ELSE 0 END),0)
  , 2) AS dropoff_contacted_to_converted_pct
FROM leads
WHERE campaign_id = (
  SELECT MAX(campaign_id) FROM campaigns
);