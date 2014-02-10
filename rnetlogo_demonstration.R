# R SCRIPT TO TEST RNETLOGO

# if you installed RNetLogo successfully, you can load the library:
library(RNetLogo)

# store netlogo installation path in 'nl.path'
# path depends on your system
# ATTENTION: use slash (/) instead of backslash (\) on Windows systems!
nl.path <- "/home/thor/bin/netlogo-5.0.2" 

# start netlogo
NLStart(nl.path)

# store (relative) path to fire model in 'model.path' 
model.path <- "/models/Sample Models/Earth Science/Fire.nlogo"

# load example model
NLLoadModel(paste(nl.path,model.path,sep=""))

# run some commands in NetLogo
NLCommand("set density 77")
NLCommand("setup")
NLCommand("go")
NLCommand("print \"Hello NetLogo, calling from R!\"")

# store number in 'density.in.r'
density.in.r <- 88

# run a chain of commands in NetLogo
NLCommand("set density ", density.in.r,"setup","go")

# run 'go' 10 times in NetLogo
NLDoCommand(10,"go")

# report number of ticks in R
NLReport("ticks")

# save number of ticks in 'ticks'
ticks <- NLReport("ticks")
# print 'ticks'
print(ticks)


### EXAMPLE 1
# setup simulation
NLCommand("setup")

# WHILE: there are still unburned trees:
#   execute 'go' in NetLogo
#   save percentage of burned trees to 'burned'
burned<-NLDoReportWhile("any? turtles",
                        "go",
                        c("ticks","(burned-trees / initial-trees) * 100"),
    as.data.frame=TRUE,df.col.names=c("tick","burned"))

# investigate burned
burned

# plot percentage of burned trees over time
plot(burned,type="s")


### EXAMPLE 2
# Something you cannot do with NetLogo: sensitivity analysis

# create empty data frame
data <- data.frame( density=numeric(0) , burned=numeric(0) )

# iterate through different densities
# ATTENTION: uncheck 'view updates' to speed up!
for ( density in c(30, 40, 50, 60, 70, 80) ) {
  # repeat 20 times
  for ( j in 1:20 ) {
    # set density, setup, burn down
    NLCommand("set density ",density,"setup","while [any? turtles] [go]")
    # store 'percentage of burned trees'
    burned <- NLReport("(burned-trees / initial-trees) * 100")
    # save density and 'percentage of burned trees' to data frame
    data <- rbind(data, c(density, burned))
  }
}

# plot boxplot
boxplot(data[,2]~data[,1], xlab="density", ylab="burned")

# Quit NetLogo
NLQuit()
