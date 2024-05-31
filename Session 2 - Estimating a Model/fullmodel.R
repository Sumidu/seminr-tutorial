# This file contains the full UTAUT2 model variables for reference
library(seminr)

# Step 1 ----
#
# Defining structure
#
# define the structural model as paths from constructs to constructs
structural_model <- relationships(
  paths(from = c("PE", "EE", "HAB", "SI", "FC", "HM", "PV"), "BI"),
  paths(from = c("nerrors"), to="PE")
)
plot(structural_model)




# Step 2 ----
#
# Defining constructs
#
# We use different constructs to represent different things.


# define the measurement model as reflective constructs
measurement_model <- constructs(
  # by adding individual constructs
  reflective("BI", multi_items("INT", 1:3)),
  reflective("PE", multi_items("PE", 1:3)),
  reflective("EE", multi_items("EE", 1:4)),
  reflective("HAB", multi_items("HAB", 1:3)),
  reflective("SI", multi_items("SI", 1:3)),
  reflective("FC", multi_items("FC", 1:3)),
  reflective("HM", multi_items("HM", 1:3)),
  reflective("PV", multi_items("PV", 1:3)),
  composite("nerrors", single_item("navigation_errors"))
)

# plot the measurement model
plot(measurement_model)