
DROP TABLE IF EXISTS clean_wdi_data;

-- Create the cleaned table
CREATE TABLE clean_wdi_data AS
SELECT 
    economy AS country_code,
    CASE economy
        WHEN 'IND' THEN 'India'
        WHEN 'PAK' THEN 'Pakistan'
        WHEN 'BGD' THEN 'Bangladesh'
        WHEN 'LKA' THEN 'Sri Lanka'
        WHEN 'NPL' THEN 'Nepal'
        WHEN 'BTN' THEN 'Bhutan'
        WHEN 'MDV' THEN 'Maldives'
        ELSE 'Other'
    END AS country_name,
    time AS year,
    -- Rename columns for better readability in Python
    ROUND("NY.GDP.PCAP.KD", 2) AS gdp_per_capita,
    ROUND("NY.GDP.MKTP.KD.ZG", 2) AS gdp_growth_pct,
    ROUND("SL.EMP.TOTL.SP.ZS", 2) AS employment_ratio,
    
    -- Flag the major global shock years
    CASE 
        WHEN time IN (1997) THEN 'Asian Financial Crisis'
        WHEN time IN (2008) THEN '2008 Financial Crisis'
        WHEN time IN (2020) THEN 'Covid'
        ELSE 'Normal'
    END AS shock_period_flag
    
FROM raw_wdi_data
--Filter out rows where all three indicators are completely missing
WHERE "NY.GDP.PCAP.KD" IS NOT NULL 
   OR "NY.GDP.MKTP.KD.ZG" IS NOT NULL 
   OR "SL.EMP.TOTL.SP.ZS" IS NOT NULL;
