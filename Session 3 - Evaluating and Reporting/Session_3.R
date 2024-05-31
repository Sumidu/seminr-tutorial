# Session 3: Evaluating & Reporting

# References:
# Hair Jr, J. F., Hult, G. T. M., Ringle, C. M.,
# Sarstedt, M., Danks, N. P., & Ray, S. (2021).
# Partial least squares structural equation modeling (PLS-SEM)
# using R: A workbook (p. 197). Springer Nature.

# Prep:
## Load SEMinR library
library(seminr)

## Load the data
utaut_data <- read.csv(file = "Session 3 - Evaluating and Reporting/course_data.csv")

# 1. Model Specification in PLS ----
## Specify the measurement model
measurement_model <- constructs(
  composite("PE", multi_items("PE", 1:4)),
  composite("EE", multi_items("EE", 1:4)),
  composite("SI", multi_items("SI", 1:3)),
  composite("FC", multi_items("FC", 1:4)),
  composite("BI", multi_items("INT", 1:3))
)

## Specify the structural model
structural_model <- relationships(
  paths(from = c("PE","EE","SI","FC"), to = "BI")
)

## Estimate the PLS Model
pls_model <- estimate_pls(data = utaut_data[,-66],
                          measurement_model = measurement_model,
                          structural_model = structural_model)

# produces an error unless all constructs are set to be reflective
pls_model <- estimate_cbsem(data = utaut_data[,-66],
                          measurement_model = measurement_model,
                          structural_model = structural_model)

## Plot PLS Model
plot(pls_model)

## Summarize the PLS Model
sum_pls_model <- summary(pls_model)

## Inspect reports and metrics in summary object
sum_pls_model$paths
#sum_pls_model$
sum_pls_model$validity
sum_pls_model$reliability

# 2. Measurement Model Evaluation in PLS ----
# 2.1. Reflectively measured constructs ----
# Hair et al. (2021) Chapter 4

# Inspect the outer loadings
sum_pls_model$loadings

# Inspect the indicator reliability
sum_pls_model$loadings^2

# Inspect the internal consistency and reliability
sum_pls_model$reliability

# Plot the reliabilities of constructs
plot(sum_pls_model$reliability)

# Table of the FL criteria
sum_pls_model$validity

# HTMT Ratio
sum_pls_model$validity$htmt

# Bootstrap the model
boot_pls <- bootstrap_model(seminr_model = pls_model,
                            nboot = 1000,
                            cores = 1,
                            seed = 123)

# Store the summary of the bootstrapped model
sum_boot_pls <- summary(boot_pls, alpha = 0.1)

# Extract the bootstrapped HTMT
sum_boot_pls$bootstrapped_HTMT

# 2.2. Formatively measured constructs ----
# Hair et al. (2021) Chapter 5

# UTAUT has no formatively measured constructs, but I will manufacture
# one in order to demonstrate the principles of formative model evaluation.

# Specify the REVISED measurement model
rev_measurement_model <- constructs(
  composite("PE", multi_items("PE", 1:4), weights = mode_A),
  composite("EE", multi_items("EE", 1:4), weights = mode_A),
  composite("SI", multi_items("SI", 1:3)),
  composite("FC", multi_items("FC", 1:4)),
  composite("BI", multi_items("INT", 1:3))
)

## Estimate the revised PLS Model
pls_model_rev <- estimate_pls(
  data = utaut_data[,-66],
  measurement_model = rev_measurement_model,
  structural_model = structural_model)

## Estimate the revised PLS Model
sum_pls_model_rev <- summary(pls_model_rev)

## Bootstrap the revised PLS Model
boot_pls_rev <- bootstrap_model(
  seminr_model = pls_model_rev,
  nboot = 1000,
  cores = 1,
  seed = 123)

plot(boot_pls_rev)
# Summarize the bootstrapped model
sum_boot_pls_rev <- summary(boot_pls_rev)

# EE Redundancy analysis ----
# Create measurement model
EE_redundancy_mm <- constructs(
  composite("EE", multi_items("EE", 1:3), weights = mode_B),
  composite("EE_G", single_item("EE4"))
)

# Create structural model
EE_redundancy_sm <- relationships(
  paths(from = c("EE"), to = c("EE_G"))
)

# Estimate the model
EE_redundancy_pls_model <- estimate_pls(
  data = utaut_data,
  measurement_model = EE_redundancy_mm,
  structural_model  = EE_redundancy_sm)

# Summarize the model
sum_EE_red_model <- summary(EE_redundancy_pls_model)

# Check the path coefficients for convergent validity
sum_EE_red_model$paths

# EE Collinearity analysis ----
sum_pls_model_rev$validity

sum_pls_model_rev$validity$vif_items$EE

# Inspect the bootstrapping results for outer weights
sum_boot_pls$bootstrapped_weights

# Inspect the bootstrapping results for the outer loadings
sum_boot_pls_rev$



# 3. Evaluation of the structural model ----
# Hair et al. (2021) Chapter 6

## Estimate the PLS Model (from section 1 above)
pls_model <- estimate_pls(data = utaut_data[,-66],
                          measurement_model = measurement_model,
                          structural_model = structural_model)

sum_pls_model <- summary(pls_model)

# Bootstrap the model ----
boot_pls <- bootstrap_model(
  seminr_model = pls_model,
  nboot = 1000,
  cores = 1,
  seed = 123)

# Summarize the results of the bootstrap
sum_boot_pls <- summary(boot_pls,
                        alpha = 0.05)

# Inspect the structural model collinearity VIF
sum_pls_model$vif_antecedents

# Inspect the structural paths
sum_boot_pls$bootstrapped_paths

# Inspect the model RSquares
sum_pls_model$paths

# Inspect the effect sizes
sum_pls_model$fSquare

# Generate the model predictions
predict_pls <- predict_pls(
  model = pls_model,
  noFolds = 10,
  reps = 10)

# Summarize the prediction results
sum_predict_pls <- summary(predict_pls)

# Analyze the distribution of prediction error
par(mfrow=c(1,3))
plot(sum_predict_pls, indicator = "INT1")
plot(sum_predict_pls, indicator = "INT2")
plot(sum_predict_pls, indicator = "INT3")
par(mfrow=c(1,1))

# Inspect the results of PLSpredict
sum_predict_pls

# For more info on mediation and moderation, see the textbook Hair et al. (2021)
