import wbgapi as wb
import pandas as pd
import sqlite3
import os

# Create project directories if they don't exist
os.makedirs('data', exist_ok=True)
os.makedirs('scripts', exist_ok=True)
os.makedirs('figures', exist_ok=True)

print("Fetching data from World Bank API...")

# Define our parameters
indicators = [
    'NY.GDP.PCAP.KD',    # GDP per capita
    'SL.EMP.TOTL.SP.ZS', # Employment to population ratio
    'NY.GDP.MKTP.KD.ZG'  # GDP growth (annual %)
]
# South Asian countries
countries = ['IND', 'PAK', 'BGD', 'LKA', 'NPL', 'BTN', 'MDV']
years = range(1990, 2024)

# Fetch data using wbgapi
df_raw = wb.data.DataFrame(indicators, countries, years, numericTimeKeys=True, columns='series')

# Reset index to turn 'economy' (country code) and 'time' (year) into normal columns
df_raw.reset_index(inplace=True)

print("Connecting to SQLite database...")
# Connect to a local SQLite database (this will create the file if it doesn't exist)
conn = sqlite3.connect('data/wdi_database.db')

# Dump the raw data into a SQL table
df_raw.to_sql('raw_wdi_data', conn, if_exists='replace', index=False)
conn.close()

print("Raw data successfully saved to data/wdi_database.db")
