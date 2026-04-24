# Codebook: clean_wdi_data

## Dataset construction

This project uses data from the World Bank World Development Indicators (WDI) API. We retrieved three indicators for seven South Asian countries (India, Pakistan, Bangladesh, Sri Lanka, Nepal, Bhutan, and Maldives) for the years 1990–2023. The indicators were:

- `NY.GDP.PCAP.KD` — GDP per capita 
- `NY.GDP.MKTP.KD.ZG` — GDP growth (annual %)
- `SL.EMP.TOTL.SP.ZS` — Employment to population ratio, ages 15+, total (%)

The data were first stored in a raw SQLite table called `raw_wdi_data`, where each row represented a country-year observation and the three indicators appeared as separate columns. We then created a cleaned table called `clean_wdi_data` for analysis. In this cleaning step, we renamed variables for readability, converted country codes to country names, rounded numeric variables to two decimal places, created a crisis-period indicator (`shock_period_flag`), and removed rows where all three indicators were missing.

## Unit of observation

Each row in `clean_wdi_data` represents one country in one year.

## Codebook

| Variable | Type | Description | Unit / Values | Source / Notes |
|---|---|---|---|---|
| country_code | TEXT | 3-letter World Bank country code | IND, PAK, BGD, LKA, NPL, BTN, MDV | Renamed from `economy` in `raw_wdi_data` |
| country_name | TEXT | Country name corresponding to country code | India, Pakistan, Bangladesh, Sri Lanka, Nepal, Bhutan, Maldives | Created from `country_code` using a SQL `CASE` statement |
| year | INTEGER | Observation year | 1990–2023 | Renamed from `time` in `raw_wdi_data` |
| gdp_per_capita | REAL | GDP per capita | Constant 2015 US$ | From `NY.GDP.PCAP.KD`, rounded to 2 decimals |
| gdp_growth_pct | REAL | Annual GDP growth rate | Percent (%) | From `NY.GDP.MKTP.KD.ZG`, rounded to 2 decimals |
| employment_ratio | REAL | Employment-to-population ratio for ages 15+ | Percent (%) | From `SL.EMP.TOTL.SP.ZS`, rounded to 2 decimals |
| shock_period_flag | TEXT | Label indicating whether the year was treated as a major global shock year in the analysis | `Asian Financial Crisis`, `2008 Financial Crisis`, `Covid`, `Normal` | Created from `year` using a SQL `CASE` statement |

## Missing data notes

Some country-year observations contain missing values (`NULL`) for one or more indicators because the World Bank does not report every indicator for every country-year. However, rows were kept as long as at least one of the three main indicators was available. Rows where all three indicators were missing were excluded from `clean_wdi_data`.