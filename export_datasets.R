#!/usr/bin/env Rscript
# Export all crimsyndata datasets to CSV and Excel formats
# Run this script after installing the package

# Load required libraries
library(crimsyndata)
library(openxlsx)

# Create directories for exports if they don't exist
if (!dir.exists("csv")) {
  dir.create("csv")
}

if (!dir.exists("excel")) {
  dir.create("excel")
}

# Function to safely export datasets
export_dataset <- function(dataset_name, data) {
  cat("Exporting", dataset_name, "...\n")
  
  # Export to CSV
  write.csv(data, 
            file = file.path("csv", paste0(dataset_name, ".csv")), 
            row.names = FALSE,
            na = "")
  
  # Export to Excel (individual files)
  write.xlsx(data, 
             file = file.path("excel", paste0(dataset_name, ".xlsx")),
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



# Print summary
cat("=== Export Summary ===\n")
cat("CSV files created in: csv/\n")
cat("Excel files created in: excel/\n\n")

cat("Files exported:\n")
cat("- crime_stats_ghent.csv/.xlsx\n")
cat("- fear_of_crime_survey.csv/.xlsx\n")
cat("- neighborhood_index.csv/.xlsx\n")
cat("- police_effort_index.csv/.xlsx\n")
cat("- crime_journal_notes.csv/.xlsx\n\n")

cat("All datasets have been successfully exported! 🎉\n")