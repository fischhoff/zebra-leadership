#look at the real variance, and a few of the randomization run results
obs_var
var_dist[1:10]

#organize observed lead distribution for use in figure.
#take only those rows for individuals observed in 2006. do this so we can make a figure of observed individual-level variation. use function tab_ids
tab_obs = tab_ids(tab_obs,haremlist06)

#Find the proportion of a harem's leads, by individual
tab_obs_frac = frac_hrm(tab_obs,haremlist06)

obs_hist = hist(tab_obs_frac,plot=F)

#organize randomization results to make figure.
#find the median value of var_dist
#note: this might run into trouble if the median is not found, because median is in between two values in the vector. this is unlikely to be a problem if there var_dist has many values (e.g., 1000)
med_index = which(var_dist == median(var_dist))

#now take the individual-level distribution of lead counts for the median-value randomization run:
med_tab = tab_dist[,med_index[1]]

#now use function tab_ids to take only those individuals sampled in 2006
med_tab = tab_ids(med_tab,haremlist06)

#Find the proportion of each harem's leads, by individual
tab_med_frac = frac_hrm(med_tab,haremlist06)

rnd_hist = hist(tab_med_frac,plot=F)

#put both observed and random histogram counts together
bar_x = obs_hist$counts
bar_x = rbind(bar_x,rnd_hist$counts)

#make a barplot of the histograms
barplot(bar_x,
	beside=TRUE,
	legend.text = c("Observed","Randomization"),
	xlab = "Fraction of leads by individual",
	ylab = "Number of individuals",
	names.arg = obs_hist$mids
	)

END
