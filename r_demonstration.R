## R BASICS

## VARIABLES AND VECTORS
# Save variables
i <- 11
i <- "String"
i <- 1

# define vectors
vector <- c(3, 4, 5)
vector

# DATAFRAMES
# Define empty dataframe
data <- data.frame(x=numeric(0),y=numeric(0))
# Show data frame
data
# Append row to dataframe
row <- c(1,4)
data[length(data[,1])+1,] <- row
row <- c(2,5)
data[length(data[,1])+1,] <- row
row <- c(3,8)
data[length(data[,1])+1,] <- row
data
# get row from dataframe
data[1,]
# get element from dataframe
data[2,2]


## PLOTS
# Scatterplot
x <- c(1,2,3)
y <- c(4,5,8)
plot(x,y)

# Boxplot
x <- c("exp 1", "exp 1", "exp 1", "exp 2", "exp 2", "exp 2")
y <- c(2,3,0,3,4,7)
boxplot(y~x)


# LINEAR REGRESSION
# Fit function to data
nls <- nls(y ~ (a*x)+b, data=data, start=list(a=1,b=1))
# get coefficients from 'nls'
k <- coef(nls)
# show data and fitted function
plot (data)
curve ( k["a"] * x + k["b"], add=T )


## READ FROM CSV-FILE
# set working directory - ATTENTION: path different on your machine! 
setwd("/home/thor/phd/angers/rnetlogo")

# read from csv file "data.csv", ski p first 6 lines of file
data <- read.csv("data.csv", skip=6)

# show data
data

# select rows with 'x==0.1' from data frame
data[data$x==0.1,]

# visualize data in box plot
boxplot(data$y~data$x)

