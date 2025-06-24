# Script to generate synthetic criminology datasets with correlations

library(dplyr)
library(usethis)

# 1. Neighborhood index
set.seed(123)
neighborhood_index <- data.frame(
  neighborhood = paste0("N", 1:10),
  unemployment_rate = runif(10, 5, 25),
  poverty_rate = runif(10, 15, 40),
  urban_density = runif(10, 3000, 15000),
  ethnic_diversity = runif(10, 0.1, 0.9)
)
use_data(neighborhood_index, overwrite = TRUE)

# 2. Crime stats with correlation to poverty_rate
crime_stats_ghent <- neighborhood_index %>%
  rename(district = neighborhood) %>%
  slice(rep(1:n(), each = 5)) %>%
  mutate(
    year = rep(2020:2024, times = 10),
    population = round(runif(n(), 8000, 30000)),
    violent_crimes = round(20 + poverty_rate * 10 + rnorm(n(), 0, 10)),
    property_crimes = round(100 + poverty_rate * 30 + rnorm(n(), 0, 25))
  ) %>%
  mutate(across(c(violent_crimes, property_crimes), ~ ifelse(. < 0, 0, .)))
crime_types <- c("Theft", "Assault", "Burglary", "Robbery", "Vandalism")
crime_stats_ghent$crime_type <- sample(crime_types, nrow(crime_stats_ghent), replace = TRUE)
use_data(crime_stats_ghent, overwrite = TRUE)


# 3. Police effort index with inverse relation to poverty
police_effort_index <- neighborhood_index %>%
  rename(district = neighborhood) %>%
  mutate(
    officers_per_1000 = round(runif(10, 1.8, 3.0), 2),
    clearance_rate = round(0.9 - poverty_rate / 100 + rnorm(10, 0, 0.05), 2),
    community_programs = sample(1:5, 10, replace = TRUE)
  ) %>%
  mutate(clearance_rate = pmin(pmax(clearance_rate, 0.3), 0.95))
use_data(police_effort_index, overwrite = TRUE)

# 4. Fear of crime survey
set.seed(456)
fear_of_crime_survey <- data.frame(
  age = sample(18:80, 200, TRUE),
  gender = sample(c("Male", "Female", "Other"), 200, TRUE),
  income = sample(c("Low", "Medium", "High"), 200, TRUE)
) %>%
  mutate(
    feel_safe_day = 6 - as.numeric(factor(income, levels = c("High", "Medium", "Low"))) +
      ifelse(gender == "Female", -1, 0) + rnorm(200, 0, 0.5),
    feel_safe_night = 6 - as.numeric(factor(income, levels = c("High", "Medium", "Low"))) +
      ifelse(gender == "Female", -1.5, 0) + rnorm(200, 0, 0.6)
  ) %>%
  mutate(
    feel_safe_day = round(pmin(pmax(feel_safe_day, 1), 5)),
    feel_safe_night = round(pmin(pmax(feel_safe_night, 1), 5))
  )
use_data(fear_of_crime_survey, overwrite = TRUE)

# 5. Crime journal notes
crime_journal_notes <- c(
  "I don't feel safe walking at night.",
  "There's too much vandalism in this area.",
  "The police rarely patrol here.",
  "My neighbor was robbed last year.",
  "The new lights made a difference.",
  "I avoid going out alone.",
  "The community program helped a bit.",
  "Drug use has increased recently.",
  "We formed a neighborhood watch.",
  "Public transport stops feel unsafe at night."
)
use_data(crime_journal_notes, overwrite = TRUE)
