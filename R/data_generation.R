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
  annual_income = round(rnorm(200, 45000, 15000)), # Annual income in euros (€)
  years_in_neighborhood = sample(0:40, 200, TRUE),
  
  # Nominal scale variables
  gender = sample(c("Male", "Female", "Other"), 200, TRUE, prob = c(0.48, 0.5, 0.02)),
  education = sample(c("Primary", "Secondary", "Bachelor", "Master", "PhD"), 200, TRUE, 
                     prob = c(0.1, 0.3, 0.35, 0.2, 0.05)),
  employment = sample(c("Employed", "Unemployed", "Student", "Retired", "Self-employed"), 200, TRUE,
                      prob = c(0.6, 0.08, 0.12, 0.15, 0.05))
) %>%
  mutate(
    # Adjust income based on employment status (logical income)
    annual_income = case_when(
      employment == "Student" ~ round(runif(n(), 0, 8000)), # Part-time/no income
      employment == "Unemployed" ~ round(runif(n(), 0, 12000)), # Benefits/minimal income
      employment == "Retired" ~ round(runif(n(), 18000, 35000)), # Pension income
      employment == "Self-employed" ~ round(runif(n(), 25000, 80000)), # Variable income
      employment == "Employed" ~ pmax(annual_income, 20000), # Regular salary
      TRUE ~ annual_income
    ),
    
    # Generate safety feelings first
    feel_safe_day = sample(1:5, n(), TRUE, prob = c(0.1, 0.15, 0.25, 0.35, 0.15)),
    feel_safe_night = pmax(1, feel_safe_day - sample(0:2, n(), TRUE, prob = c(0.3, 0.5, 0.2))),
    
    # Derive overall neighborhood safety based on individual safety feelings (1-5 scale)
    avg_safety = (feel_safe_day + feel_safe_night) / 2,
    overall_neighborhood_safety = round(pmin(pmax(
      avg_safety + rnorm(n(), 0, 0.3), # Add some variation
      1), 5)),
    
    # Additional interval variables based on safety perceptions
    police_trust = round(pmin(pmax(
      1 + (overall_neighborhood_safety - 1) * 0.8 + 
      ifelse(education %in% c("Bachelor", "Master", "PhD"), 0.5, -0.5) +
      rnorm(n(), 0, 0.6),
      1), 5)),
    
    crime_concern = round(pmin(pmax(
      6 - overall_neighborhood_safety + 
      ifelse(gender == "Female", 0.8, 0) +
      ifelse(age > 65, 0.5, 0) +
      rnorm(n(), 0, 0.5),
      1), 5)),
    
    # Additional ratio variable (numeric count)
    previous_victimization = sample(0:8, n(), TRUE, prob = c(0.6, 0.2, 0.08, 0.04, 0.03, 0.02, 0.015, 0.01, 0.005))
  ) %>%
  mutate(
    feel_safe_day = round(feel_safe_day),
    feel_safe_night = round(feel_safe_night)
  ) %>%
  select(-avg_safety) # Remove the temporary variable
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
