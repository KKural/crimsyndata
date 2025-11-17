#!/usr/bin/env Rscript
# Export all crimsyndata datasets to CSV and Excel formats
# Run this script after installing the package

# Load required libraries
library(crimsyndata)
library(openxlsx)

# Create directories for exports if they don't exist
if (!dir.exists("exports")) {
  dir.create("exports")
}

if (!dir.exists("exports/csv")) {
  dir.create("exports/csv")
}

if (!dir.exists("exports/excel")) {
  dir.create("exports/excel")
}

# Function to safely export datasets
export_dataset <- function(dataset_name, data) {
  cat("Exporting", dataset_name, "...\n")
  
  # Export to CSV
  write.csv(data, 
            file = file.path("exports", "csv", paste0(dataset_name, ".csv")), 
            row.names = FALSE,
            na = "")
  
  # Export to Excel (individual files)
  write.xlsx(data, 
             file = file.path("exports", "excel", paste0(dataset_name, ".xlsx")),
             rowNames = FALSE)
  
  cat("✓", dataset_name, "exported successfully\n\n")
}

# Export all datasets
cat("=== Exporting crimsyndata datasets ===\n\n")

# Dataset 1: Crime statistics
export_dataset("crime_stats_ghent", crime_stats_ghent)

# Dataset 2: Fear of crime survey
export_dataset("fear_of_crime_survey", fear_of_crime_survey)

# Dataset 3: Neighborhood index
export_dataset("neighborhood_index", neighborhood_index)

# Dataset 4: Police effort index
export_dataset("police_effort_index", police_effort_index)

# Dataset 5: Crime journal notes (convert to data frame for CSV/Excel)
crime_notes_df <- data.frame(
  note_id = 1:length(crime_journal_notes),
  note_text = crime_journal_notes,
  stringsAsFactors = FALSE
)
export_dataset("crime_journal_notes", crime_notes_df)

# Create a combined Excel workbook with all datasets
cat("Creating combined Excel workbook...\n")
wb <- createWorkbook()

# Add each dataset as a separate worksheet
addWorksheet(wb, "crime_stats_ghent")
writeData(wb, "crime_stats_ghent", crime_stats_ghent)

addWorksheet(wb, "fear_of_crime_survey")
writeData(wb, "fear_of_crime_survey", fear_of_crime_survey)

addWorksheet(wb, "neighborhood_index")
writeData(wb, "neighborhood_index", neighborhood_index)

addWorksheet(wb, "police_effort_index")
writeData(wb, "police_effort_index", police_effort_index)

addWorksheet(wb, "crime_journal_notes")
writeData(wb, "crime_journal_notes", crime_notes_df)

# Add a summary worksheet
addWorksheet(wb, "README")
readme_content <- data.frame(
  Dataset = c("crime_stats_ghent", "fear_of_crime_survey", "neighborhood_index", 
              "police_effort_index", "crime_journal_notes"),
  Description = c("Yearly violent and property crimes by district (50 rows)",
                  "Survey with demographics and safety perceptions (200 rows)",
                  "SES indicators like poverty and unemployment (10 rows)",
                  "Police staffing, clearance rate, and programs (10 rows)",
                  "Qualitative quotes on neighborhood safety (10 rows)"),
  Variables = c("10 variables", "5 variables", "5 variables", "8 variables", "2 variables"),
  stringsAsFactors = FALSE
)
writeData(wb, "README", readme_content)

# Save the combined workbook
saveWorkbook(wb, "exports/crimsyndata_all_datasets.xlsx", overwrite = TRUE)

cat("✓ Combined Excel workbook created: crimsyndata_all_datasets.xlsx\n\n")

# Print summary
cat("=== Export Summary ===\n")
cat("CSV files created in: exports/csv/\n")
cat("Individual Excel files created in: exports/excel/\n")
cat("Combined Excel workbook: exports/crimsyndata_all_datasets.xlsx\n\n")

cat("Files exported:\n")
cat("- crime_stats_ghent.csv/.xlsx\n")
cat("- fear_of_crime_survey.csv/.xlsx\n")
cat("- neighborhood_index.csv/.xlsx\n")
cat("- police_effort_index.csv/.xlsx\n")
cat("- crime_journal_notes.csv/.xlsx\n")
cat("- crimsyndata_all_datasets.xlsx (combined)\n\n")

cat("All datasets have been successfully exported! 🎉\n")