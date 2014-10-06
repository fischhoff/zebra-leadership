#number of randomization runs
runs = 1000

#randomization with respect to sex, controlling for individual variation
#Randomizeleadssex = function(haremlist,leadlist){

usex=c("F","M")

rnd_cts = replicate(runs,ct_sex(Randomizeleadssex(haremlist_adult,leadlist_adult),usex))
#each column of rnd_cts will be the result of one randomization run. each row is an sex class. 

#now find the differences between female and male counts in the randomization runs
sexdiff_rnd = rnd_cts[1,]-rnd_cts[2,]

#now find the real, observed cts of leads by sex class
sexcts_rl = ct_sex(leadlist_adult,usex)

#find the observed difference in counts of leads by sex
sexdiff_rl = sexcts_rl[1]-sexcts_rl[2]
sexdiff_rl

#find the number of times the sexdiff_rnd is greater than the sexdiff_rl
ps =length(which(sexdiff_rnd > sexdiff_rl))
ps

#divide ps by 1000. find the smaller of this fraction and 1 minus this fraction. multiply the result by 2 and you have the two-sides p value. 

END
