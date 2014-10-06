#indicate how many runs of the randomization to do
runs =1000

#tab_obs: observed table of number of times leading by individual.
tab_obs = leads_tab(leadlist06)

#Find the variance using function var_leads
#obs_var: observed sum of squares
obs_var = var_leads(leadlist06)

#Run the randomization using replicate,RandomizeleadsIdCtrlAgesex, and leads_tab
#output is tab_dist: table in which each column is the counts of leads by individual from one run of randomization
tab_dist = replicate(runs, leads_tab(RandomizeleadsIdCtrlAgesex
(haremlist06, leadlist06)))

#Compute distribution of variance from randomization, based on tab_dist. Use function var_tab
var_dist = var_tab(tab_dist)

#find the number of times the rnd variance of leads is greater than the real
ps =length(which(var_dist > obs_var))
ps
END
