#' Crime statistics in fictional districts
#'
#' A dataset with synthetic police-recorded crime data.
#'
#' @format A data frame with 60 rows and 5 variables:
#' \describe{
#'   \item{district}{Fictional district name}
#'   \item{year}{Year}
#'   \item{violent_crimes}{Number of violent crimes}
#'   \item{property_crimes}{Number of property crimes}
#'   \item{population}{Total population}
#' }
"crime_stats_ghent"

#' Survey on fear of crime
#'
#' @format A data frame with 200 rows and 5 variables
"fear_of_crime_survey"

#' Socioeconomic indicators by neighborhood
#'
#' @format A data frame with 10 rows and 4 variables
"neighborhood_index"

#' Police effort index
#'
#' @format A data frame with 10 rows and 3 variables
"police_effort_index"

#' Crime journal notes
#'
#' @format A character vector with 10 observations
"crime_journal_notes"




# 1. Create a new package project
usethis::create_package("C:/Users/kukumar/Desktop/crimsyndata")

# 2. Open that folder or set it as working directory
setwd("C:/Users/kukumar/Desktop/crimsyndata")

# 3. Copy your datasets creation script here, e.g., data-raw/synthetic_data.R
usethis::use_data_raw(name = "synthetic_data", open = TRUE)

# 4. Paste your dataset-generation code inside that file and run it

# 5. Add Roxygen documentation to an R script:
usethis::use_r("datasets")  # then paste your Roxygen documentation here

# 6. Document the package
devtools::document()

# 7. Test that everything loads
devtools::load_all()
