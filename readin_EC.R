W <- read.csv(file="elise_walk.csv",head=TRUE,sep=",", na.strings=c("NA", "NOTE"))
print(names(W))
#R appears to change blank to NA, at least when rest of entries are numeric

