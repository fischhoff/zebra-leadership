H <- read.csv(file="fixed_harems.csv",head=TRUE,sep=",")
names(H)[names(H)=="Harem_members"] = "Individual_ID"
print(names(H))

