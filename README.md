# crimsyndata

**crimsyndata** is an R package containing realistic synthetic datasets for criminology education and practice. The datasets include crime statistics, survey data, police effort indicators, neighborhood socioeconomic profiles, and qualitative crime notes. All data are synthetic and generated with realistic patterns and correlations to support basic and advanced criminological analysis.

## 📦 Installation

You can install the package from GitHub using:

```r
install.packages("remotes")  # If not already installed
remotes::install_github("KKural/crimsyndata")
library(crimsyndata)
```

## 📊 Datasets

| Dataset              | Description                                        |
|----------------------|----------------------------------------------------|
| crime_stats_ghent    | Yearly violent and property crimes by district     |
| fear_of_crime_survey | Survey with demographics and safety perceptions    |
| neighborhood_index   | SES indicators like poverty and unemployment       |
| police_effort_index  | Police staffing, clearance rate, and programs      |
| crime_journal_notes  | Qualitative quotes on neighborhood safety          |

## 📁 Data Export Options

### Quick CSV Export
You can export individual datasets like this:
```r
write.csv(crime_stats_ghent, "crime_stats_ghent.csv", row.names = FALSE)
```

### Export All Datasets (CSV + Excel)
To export all datasets to both CSV and Excel formats, run the included export script:
```r
source("export_datasets.R")
```

This will create:
- **CSV files** in `exports/csv/` folder
- **Individual Excel files** in `exports/excel/` folder  
- **Combined Excel workbook** `exports/crimsyndata_all_datasets.xlsx` with all datasets as separate worksheets

**Requirements for full export**: Install the `openxlsx` package first:
```r
install.packages("openxlsx")
```

## 🧪 Sample Teaching Questions

1. Is there a significant difference in fear of crime between income groups?  
   → Use ANOVA or Kruskal-Wallis test.

2. Are poverty rates correlated with violent crime rates?  
   → Use `cor.test()` or linear regression.

3. Does police clearance rate decrease with rising poverty?  
   → Use `lm(clearance_rate ~ poverty_rate, data = police_effort_index)`

4. What themes emerge from the `crime_journal_notes`?  
   → Use qualitative content coding.

---

## 🔧 Development

To recreate the synthetic datasets:

```r
source("R/data_generation.R")
```

Then rebuild and install:

```r
devtools::document()
devtools::install()
```

---
