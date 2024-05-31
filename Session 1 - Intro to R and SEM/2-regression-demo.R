#** Example: Linear regression analysis

# The following code runs a short regression analysis on data, and shows us a
# short, simple workflow. Note that comments (descriptive text that does not
# run) is prefixed with a pound sign ("#").

# load data from a file into a variable using the "read.csv" function

course_data <- read.csv("Session 1 - Intro to R and SEM/course_data.csv")

# run a regression analysis

intention_regr <- lm(formula = INT1 ~ PE1 + EE1, data = course_data)

# show a summary of results from the regression on screen

summary(intention_regr)

# save the summary to a variable for further inspection

regr_report <- summary(intention_regr)

# Variables, like the regression report we are storing in `regr_report`, often
# contain a deeper structure of values that one can inspect:

str(regr_report)

regr_report$coefficients
regr_report$r.squared
