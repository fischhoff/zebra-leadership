#summarize original data
#how many observed leads were there?
ct = dim(leadlist)[1]
ct

#how many stallions observed?`
harems = unique(leadlist$harem_stallion)
num_harems = length(harems)
num_harems

#how many observed leaders were there?
leaders = unique(leadlist$individualid)
num_leaders = length(leaders)
num_leaders

#indicate how many runs of the randomization to do
runs =1000#note: to get a useful null distribution, do 1000 runs

#obs_var: observed variance
obs_var = var_leads(leadlist)

#var_dist: distribution of variance based on randomization
var_dist = replicate(runs, var_leads(Randomizeleads(haremlist, leadlist)))

#look at the real variance and var_dist values
list(obs_var=obs_var, var_dist)

#compare observed to null distribution to get p value
p = length(which(var_dist > obs_var))/runs
p
END
