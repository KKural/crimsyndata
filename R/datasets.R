#' Crime statistics in fictional districts
#'
#' A dataset with synthetic police-recorded crime data for fictional districts.
#'
#' @format A data frame with 50 rows and 10 variables:
#' \describe{
#'   \item{district}{Fictional district name}
#'   \item{unemployment_rate}{Unemployment rate}
#'   \item{poverty_rate}{Poverty rate}
#'   \item{urban_density}{Urban density (residents per sq. km)}
#'   \item{ethnic_diversity}{Diversity index (0–1)}
#'   \item{year}{Year of record (2020–2024)}
#'   \item{population}{Total population}
#'   \item{violent_crimes}{Number of violent crimes}
#'   \item{property_crimes}{Number of property crimes}
#'   \item{crime_type}{Type of recorded crime}
#' }
#' @source Synthetic data generated for teaching
"crime_stats_ghent"

#' Survey on fear of crime
#'
#' A synthetic dataset from a survey on citizens’ fear of crime.
#'
#' @format A data frame with 200 rows and 5 variables:
#' \describe{
#'   \item{age}{Respondent age}
#'   \item{gender}{Respondent gender (Male, Female, Other)}
#'   \item{income}{Income group (Low, Medium, High)}
#'   \item{feel_safe_day}{Feeling of safety during the day (1–5)}
#'   \item{feel_safe_night}{Feeling of safety at night (1–5)}
#' }
#' @source Synthetic data generated for teaching
"fear_of_crime_survey"

#' Socioeconomic indicators by neighborhood
#'
#' A dataset with synthetic socioeconomic characteristics by neighborhood.
#'
#' @format A data frame with 10 rows and 5 variables:
#' \describe{
#'   \item{neighborhood}{Neighborhood name}
#'   \item{unemployment_rate}{Unemployment rate}
#'   \item{poverty_rate}{Poverty rate}
#'   \item{urban_density}{Urban density (residents per sq. km)}
#'   \item{ethnic_diversity}{Diversity index (0–1)}
#' }
#' @source Synthetic data generated for teaching
"neighborhood_index"

#' Police effort index
#'
#' A dataset with synthetic police resource and performance indicators by district.
#'
#' @format A data frame with 10 rows and 8 variables:
#' \describe{
#'   \item{district}{District name}
#'   \item{unemployment_rate}{Unemployment rate}
#'   \item{poverty_rate}{Poverty rate}
#'   \item{urban_density}{Urban density (residents per sq. km)}
#'   \item{ethnic_diversity}{Diversity index (0–1)}
#'   \item{officers_per_1000}{Police officers per 1000 inhabitants}
#'   \item{clearance_rate}{Proportion of crimes cleared (0–1)}
#'   \item{community_programs}{Number of community crime prevention programs}
#' }
#' @source Synthetic data generated for teaching
"police_effort_index"

#' Crime journal notes
#'
#' A character vector of fictional citizen notes related to crime concerns.
#'
#' @format A character vector with 10 observations
#' @source Synthetic data generated for teaching
"crime_journal_notes"
