# Step 6 Bootstrapping ----
#
#  Bootstrapping
#
#


# library loading if not already present
library(tidyverse)
library(seminr)
set.seed(123)

est_model <- read_rds("estimated_model.rds")

# run bootstrapping on model with 50 repetitions
# WARNING: This requires sufficient memory and approx. 10 seconds!
bst_model <- bootstrap_model(est_model, nboot = 100)
plot(bst_model)

# we can save any plot as pdf files to include in our paper
save_plot("bootstrapped_model.pdf")

# get summary statistics on the bootstrapped model
summary(bst_model)

# identify models with insufficient discriminant validity
plot_htmt(bst_model, htmt_threshold = 0.5)

