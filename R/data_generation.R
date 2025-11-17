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
  # Ratio scale variables
  age = sample(18:80, 200, TRUE),
  annual_income = round(rnorm(200, 45000, 15000)), # Annual income in euros
  years_in_neighborhood = sample(0:40, 200, TRUE),
  
  # Nominal scale variables
  gender = sample(c("Male", "Female", "Other"), 200, TRUE, prob = c(0.48, 0.5, 0.02)),
  education = sample(c("Primary", "Secondary", "Bachelor", "Master", "PhD"), 200, TRUE, 
                     prob = c(0.1, 0.3, 0.35, 0.2, 0.05)),
  employment = sample(c("Employed", "Unemployed", "Student", "Retired", "Self-employed"), 200, TRUE,
                      prob = c(0.6, 0.08, 0.12, 0.15, 0.05)),
  
  # Ordinal scale variables
  income_category = sample(c("Very Low", "Low", "Medium", "High", "Very High"), 200, TRUE,
                          prob = c(0.15, 0.25, 0.35, 0.2, 0.05)),
  neighborhood_safety = sample(c("Very Unsafe", "Unsafe", "Neutral", "Safe", "Very Safe"), 200, TRUE,
                              prob = c(0.1, 0.2, 0.25, 0.35, 0.1))
) %>%
  mutate(
    # Ensure income consistency
    annual_income = pmax(annual_income, 15000), # Minimum wage
    annual_income = case_when(
      income_category == "Very Low" ~ round(runif(n(), 15000, 25000)),
      income_category == "Low" ~ round(runif(n(), 25000, 35000)),
      income_category == "Medium" ~ round(runif(n(), 35000, 55000)),
      income_category == "High" ~ round(runif(n(), 55000, 80000)),
      income_category == "Very High" ~ round(runif(n(), 80000, 120000)),
      TRUE ~ annual_income
    ),
    
    # Interval scale variables (Likert scales)
    feel_safe_day = case_when(
      neighborhood_safety == "Very Unsafe" ~ sample(1:2, n(), TRUE),
      neighborhood_safety == "Unsafe" ~ sample(2:3, n(), TRUE),
      neighborhood_safety == "Neutral" ~ sample(2:4, n(), TRUE),
      neighborhood_safety == "Safe" ~ sample(3:5, n(), TRUE),
      neighborhood_safety == "Very Safe" ~ sample(4:5, n(), TRUE)
    ),
    feel_safe_night = pmax(1, feel_safe_day - sample(0:2, n(), TRUE, prob = c(0.3, 0.5, 0.2))),
    
    # Additional interval variables
    police_trust = round(pmin(pmax(
      3 + ifelse(neighborhood_safety %in% c("Safe", "Very Safe"), 1, -1) +
      ifelse(education %in% c("Bachelor", "Master", "PhD"), 0.5, -0.5) +
      rnorm(n(), 0, 0.8),
      1), 5)),
    
    crime_concern = round(pmin(pmax(
      6 - feel_safe_night + 
      ifelse(gender == "Female", 1, 0) +
      ifelse(age > 65, 0.5, 0) +
      rnorm(n(), 0, 0.6),
      1), 5)),
    
    # Additional ordinal variable
    previous_victimization = sample(c("Never", "Once", "2-3 times", "4-5 times", "More than 5"), 200, TRUE,
                                   prob = c(0.6, 0.2, 0.12, 0.05, 0.03))
  ) %>%
  mutate(
    feel_safe_day = round(feel_safe_day),
    feel_safe_night = round(feel_safe_night)
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
