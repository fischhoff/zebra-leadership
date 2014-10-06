print(summary(W2$Leadership_No))
#all the values seem to be numeric, so far so good.  

wlist = unique(W2$Leadership_No)
print(wlist)
#all of these look okay

na_test = subset(W2,is.na(Leadership_No))
print(na_test)
unique(na_test$Sightingno)
test_29 = subset(W2,Sightingno == "hl29")
summary(test_29)
#leadership_no appears fine!


#Don't seem to need this solution to change level (factor) to numeric 
#f = W2$Leadership_No
#f_num = as.numeric(levels(f))[as.integer(f)]
#W2$Leadership_No = f

