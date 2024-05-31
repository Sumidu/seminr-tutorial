



# Load the tidyverse for reading in data
library(tidyverse)

# Load the SEMinR package
library(seminr)


# Step 1 Structural Model----
#
# Defining structure
#
# define the structural model as paths from constructs to constructs
structural_model <- relationships(
  paths(from = c("Performance Expectancy", "Effort Expectancy", "Social Influence"), to="Behavioral Intention"),
  paths(from = c("Navigation Errors"), to="Effort Expectancy"),
  paths(from = c("Successful Tasks"), to="Performance Expectancy")
)
plot(structural_model)

## H1 Homework ----
# Try to add Hedonic Motivation (HM) as an antecedent to Behavioral Intention


# Step 2 Measurement Model ----
#
# Defining constructs
#
# We use different constructs to represent different things.


# define the measurement model as reflective constructs
measurement_model <- constructs(
  # by adding individual constructs
  composite("Behavioral Intention", multi_items("INT", 1:3)),
  composite("Performance Expectancy", multi_items("PE", 1:3)),
  composite("Effort Expectancy", multi_items("EE", 1:4)),
  composite("Social Influence", multi_items("SI", 1:2)),
  composite("Navigation Errors", single_item("navigation_errors")),
  composite("Successful Tasks", single_item("successful_tasks"))
)

# plot the measurement model
plot(measurement_model)

## H2 Homework ----
# Add the construct items for hedonic motivation
# for this look inside the data dictionary linked in session2.html




# Step 3 Model setup ----
#
# Model setup
#

# specify the model by combining the measurement and structural model
our_model <- specify_model(measurement_model = measurement_model,
                                   structural_model = structural_model)

plot(our_model)
## H2 Homework ----
# This one is simple. Plot your new model.

# Step 3b gather data ----
#
# we've done that for you :)


# Step 4 Data prep ----
#
# Data preparation
#
# read in the data file
trello_utaut <- read_csv("Session 2 - Estimating a Model/course_data.csv")
# list the variable names
names(trello_utaut)
# View(trello_utaut)







# Step 5 Estimation ----
#
# Model estimation
#

# estimate the specified model using the partial least squares algorithm
est_model <- estimate_pls(model = our_model, data = trello_utaut)
plot(est_model)


# provide summary statistics for the model
summary(est_model)


# write our model to the drive as a savepoint before bootstrapping
write_rds(est_model, "estimated_model.rds")

## Homework
# Think about the results of your model. How does considering hednoc
# motivation impact your model?


# If you want to cite seminr in your work this command will give you
# a markdown and a bibtex entry
citation("seminr")
