
#* Introduction SEM

# Structural Equation Modeling excels at allowing researchers to measure
# relationships between multi-item constructs. *Constructs* are statistical
# representation of concepts that are hard to measure in with a singular metric,
# and are best represented by multiple measurements.

# Each SEM is defined by two models: a **measurement model** that describes how
# each construct is measured using multiple items, and **structural model** that
# describes the structure of causal relationships between the constructs. The
# parameters of an SEM can then be **estimated** and **visualized** by the
# SEMinR package.

#* Installing and Using SEMinR

# If you have never installed SEMinR on your computer, install it as follows:

install.packages("seminr", dependencies = TRUE)

# You do not have to run that function call again unless you want to update
# SEMinR to a newer version.

# However, everytime you restart RStudio to work on an SEM project, you must
# *load* the SEMinR package back into RStudio:

library(seminr)

# From here,you are ready to write and run code that defines and estimates your
# SEM models.

#* Load Data

# R natively supports comma-seperated-values (CSV) file format
# You can install packages that support other file formats: Excel, SPSS, etc.

course_data <- read.csv("Session 2 - Estimating a Model/course_data.csv")

#* Measurement Model

# We can define the measurement model of an SEM simply by describing each
# construct by its set of *measurement items* that *reflect* the underlying
# concept. Let's see a simplified example from the Trello model and dataset
# we will use:

intention_mm <- constructs(
  reflective("PE", multi_items("PE", 1:3)),
  reflective("EE", multi_items("EE", 1:4)),
  reflective("BI", multi_items("INT", 1:3))
)

# Three constructs are defined in this measurement model. Note how the
# constructs are collectively defined within the `constructs()` function. Each
# construct is defined as being reflected in their measurement items using the
# `reflective()` function. And the multiple items reflecting each construct are
# defined by the `multi_items()` function. **The syntax of our SEMinR package
# closely matches the vocabulary that researchers use to describe such models!**

#* Structural Model

intention_sm <- relationships(
  paths(from = c("PE", "EE"), to = "BI")
)

# Note that we defined a set of three relationships at once. In the `paths()`
# function call above, we defines two paths, one from each of `PE` and `EE` to
# the `BI` outcome.

intention_model <- estimate_pls(
  measurement_model = intention_mm,
  structural_model  = intention_sm,
  data = course_data)

# The `intention_model` object in which the estimation is stored does not
# contain a full report that researchers would be interested in. Instead,
# researchers will want to ask SEMinR to *summarize* the results cogently for
# interpretation.

summary(intention_model)

# The summary includes, but does not show, a wealth of other estimated values
# that researchers might wish to inspect or report.

# We start by storing the summary report into a variable:

intention_report <- summary(intention_model)

# We can now extract the structural paths that researchers often hypothesize:

intention_report$paths

# You can find the full structure of the report by typing:

str(intention_report)

#* Visualization

# Researchers often find that it is helpful to get a high-level glimpse of
# their model description and results from a visualization.

plot(intention_model)


#* Join us

#** Collaboration and Feedback

# Github: https://github.com/sem-in-r/seminr
# Issues and bugs: https://github.com/sem-in-r/seminr/issues

#** Social Media

# https://www.facebook.com/groups/seminr

