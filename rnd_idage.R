#indicate how many runs of the randomization to do
runs =1000

#obs_var: observed sum of squares
obs_var= var_leads(leadlist06)
obs_var

#ss_dist: distribution of sum of squares based on randomization
var_dist = replicate(runs, var_leads(RandomizeleadsIdControlAge(haremlist06, leadlist06)))

list(obs_var = obs_var , var_dist = var_dist)

#find the number of times the randomization variance of leads is greater than the real
ps =length(which(var_dist > obs_var))
ps
END





