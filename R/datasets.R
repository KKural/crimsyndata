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
#' A synthetic dataset from a survey on citizens' fear of crime with variables 
#' representing different measurement scales for statistical education.
#'
#' @format A data frame with 200 rows and 13 variables:
#' \describe{
#'   \item{age}{Respondent age in years (ratio scale)}
#'   \item{annual_income}{Annual income in euros (ratio scale)}
#'   \item{years_in_neighborhood}{Years living in current neighborhood (ratio scale)}
#'   \item{gender}{Respondent gender - Male, Female, Other (nominal scale)}
#'   \item{education}{Education level - Primary, Secondary, Bachelor, Master, PhD (nominal scale)}
#'   \item{employment}{Employment status - Employed, Unemployed, Student, Retired, Self-employed (nominal scale)}
#'   \item{income_category}{Income category - Very Low, Low, Medium, High, Very High (ordinal scale)}
#'   \item{neighborhood_safety}{Perceived neighborhood safety - Very Unsafe to Very Safe (ordinal scale)}
#'   \item{previous_victimization}{Times been victim of crime - Never to More than 5 (ordinal scale)}
#'   \item{feel_safe_day}{Feeling of safety during the day, 1-5 scale (interval scale)}
#'   \item{feel_safe_night}{Feeling of safety at night, 1-5 scale (interval scale)}
#'   \item{police_trust}{Trust in police effectiveness, 1-5 scale (interval scale)}
#'   \item{crime_concern}{General concern about crime, 1-5 scale (interval scale)}
#' }
#' @source Synthetic data generated for teaching measurement scales
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
