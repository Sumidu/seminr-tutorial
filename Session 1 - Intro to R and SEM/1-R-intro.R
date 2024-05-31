#* Introduction to R

# The best way to learn R from scratch is by installing and running the
# [Swirl](https://swirlstats.com/students.html) tutorials in RStudio. Here we
# review the basic essentials to R to quickly get a first glimpse of SEMinR.

#** R Basics

# Variables: R allows you to store data, values, and results of your analyses
# in variables. Here is an example of how to assign values to variables:

value <- 5
construct_name <- "PE"

# Collections: Multiple values can be defined and stored together. Vectors are
# collections of simple values (numbers, characters). Lists are collections of
# simple values or even other collections

# Vectors are collection of basic data elements
# Vector of five numbers:

numbers <- c(1, 2, 3, 4, 5)

numbers <- 1:5

# Vector of two character expressions (letters, symbols, numbers in quotes):

item_names <- c("PE1", "PE2")

# We can then extract what we have stored in these collections as we need them.

item_names[1]
item_names[2]

# List of values and vectors

construct_definition <- list(
  name = "Performance Expectancy",
  items = c("PE1", "PE2", "PE3", "PE4")
)

construct_definition$items

# You can see what class (type) of object is stored in a variable:

class(construct_definition)

# You can see the structure of data in a variable using str():

str(construct_definition)

# **Operations**: Simple mathematical operations can be computed on values
# (numbers, words, etc.) or on variables. R is specially suited to performing
# operations on vectors (like our `numbers` from above).

5 * 2

numbers <- 1:5

numbers

numbers^2

# The real beauty of vectorized operations is that is allows us to express 
# statistical formula simply:

num_variance <- sum( (numbers - mean(numbers))^2 ) / (length(numbers) - 1)

# **Functions**: Purposeful sequence of operations that are encapsulated in R
# code. Functions can be called by their name and supplying them with any input
# necessary for them to run. Functions typically return results that can be
# assigned to a variable. Some functions also output reports to the screen.

seq(1, 5)

seq(1, 5, by = 0.5)

sum(numbers)

help(seq)
?seq

