
#This function compute the number of leads by each sex class. Input is the list of sexes. We use this to make a figure
ct_sex = function(leadlist,usex){
	usex = sort(usex)
	tmp = rep(NA,length(usex))
	for (a in 1:length(usex)){
		l_tm = subset(leadlist,sex == usex[a])
		tmp[a] = dim(l_tm)[1]
	}
	#output to ct_leads_sex
	tmp
}

#Randomization with respect to sex, controlling for individual variation
Randomizeleadssex = function(haremlist,leadlist){
	
	#unique list of the harem stallions we observed. 
	sids = unique(haremlist$harem_stallion)
	#number of groups (harems) we observed
	stallions = length(sids)

	out = NULL

	#for each stallion/harem
	for (a in 1:stallions){

		#find all the leads for this harem
		htm = subset(leadlist,harem_stallion == sids[a])

		#who is in the harem? take only the records with this stallion.
		id_recs = subset(haremlist,harem_stallion == sids[a])
		#find unique ids in harem
		uid = id_recs$individualid

		#vector of sexes observed
		sex_obs = id_recs$sex

		#find the individuals who have actually been observed as leaders, which may be fewer than the number in group
		id_obs = unique(htm$individualid)

		#find number of individuals observed as leaders; will randomly sample among observed sexs in group to fill this list. note that not all individuals may have led in observed data.
		n_obs_leaders = length(id_obs)

		#randomize sex label list without replacement
		sex_rnd = sample(sex_obs,size = n_obs_leaders,replace = FALSE)

		#now go through and assign sex to observed leads, by assigning each individual a randomly chosen sex from the individuals of the harem
		for (b in 1:n_obs_leaders){
			#get all records for id
			idtm =subset(htm,individualid == id_obs[b])

			#assign pseudo sex
			idtm$sex = sex_rnd[b]
			#output to out
			out = rbind(out,idtm)
		}
	#end loop through stals
	}
	#sex-randomized leadlist
	out
}
END
