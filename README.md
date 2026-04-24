# DATASCI 350 Final Project Group 2

**Group Members:** Christina Dai, Eric Wang, Kenneth He, Tina Piltner, Joe Xia

## Project Overview

This project analyzes economic development trends in South Asia, specifically evaluating the impact of three major global and regional crisis shocks: the 1997 Asian Financial Crisis, the 2008 Global Financial Crisis, and the COVID-19 pandemic. Using data from the World Bank World Development Indicators (WDI) database, our analysis focuses on seven countries — India, Pakistan, Bangladesh, Sri Lanka, Nepal, Bhutan, and Maldives — over the period 1990–2023.

We examine three indicators:

- GDP per capita (`NY.GDP.PCAP.KD`)
- GDP growth (`NY.GDP.MKTP.KD.ZG`)
- Employment-to-population ratio, ages 15+ (`SL.EMP.TOTL.SP.ZS`)

The project uses:
- **Python** to retrieve data from the World Bank API and generate visualizations
- **SQLite / SQL** to clean and transform the dataset
- **Quarto** to produce a reproducible final report in HTML and PDF format

## Repository Structure

```text
DATASCI350_finalproject_group2/
├── data/
│   ├── raw_wdi_data.csv
│   ├── clean_wdi_data.csv
│   └── wdi_database.db
├── documentation/
│   ├── codebook.md
│   ├── codebook.html
│   ├── entityRelationship.qmd
│   └── entityRelationship.html
├── figures/
│   └── [plots and figures used in the report]
├── scripts/
│   ├── fetch_script.ipynb
│   ├── init_db.py
│   ├── clean_data.sql
│   ├── 1997Crisis.ipynb
│   ├── 2008Crisis.ipynb
│   └── covid19.ipynb
├── Report.qmd
├── Report.html
├── Report.pdf
└── README.md
``` 

## Documentation Files

The `documentation/` folder contains the codebook and entity relationship diagram used to describe the dataset and workflow.

To render the entity relationship diagram:

```bash
quarto render documentation/entityRelationship.qmd
```

### Run the data analysis for the three final crises with:

```bash
jupyter nbconvert --to notebook --execute scripts/1997Crisis.ipynb --output 1997Crisis_executed.ipynb --output-dir=scripts
jupyter nbconvert --to notebook --execute scripts/2008Crisis.ipynb --output 2008Crisis_executed.ipynb --output-dir=scripts
jupyter nbconvert --to notebook --execute scripts/covid19.ipynb --output covid19_executed.ipynb --output-dir=scripts
```


### Render the final report with: 
```bash
quarto render Report.qmd 
```
