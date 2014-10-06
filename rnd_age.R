#find the number of adult and young individuals
table(haremlist06$age)

#how many individuals were observed leading in 2006?
length(unique(leadlist06$individualid))

#number of randomization runs
runs =1000

uage =c(0,1)
#find the counts of leads by each age class, after doing the randomization
#and run the procedure multiple times w replicate
rnd_diffs = replicate(runs,diff_age(RandomizeLeadsAge(haremlist06,leadlist06),uage))
rnd_diffs
#each column of rnd_diffs will be the result of one randomization run. each row is an age class. 

#now find the real, observed cts of leads by age class
agediff_rl = diff_age(leadlist06,uage)
agediff_rl


#find the number of times the rnd difference of leads is greater than the real
#ps will be the number of randomization runs for which rnd_diffs (randomly generated differences in leads by age class) is greater than the observed. 
ps =length(which(rnd_diffs > agediff_rl))

#if ps is in outside 0.05 of distribution, then significant. We have a priori hypothesis that adults lead more often. 
ps
END
