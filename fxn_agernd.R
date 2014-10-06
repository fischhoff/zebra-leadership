
#This function computes the difference in the number of leads by each age class. Input the ages of interest (uage). If you have more than two age classes, then this code would need some changes to accommodate.
diff_age = function(leadlist,uage){
	uage = sort(uage)
	tmp = rep(NA,length(uage))
	for (a in 1:length(uage)){
		l_tm = subset(leadlist,age == uage[a])
		tmp[a] = dim(l_tm)[1]
	}
	#output to diff_age 
	tmp[2]-tmp[1]
}

#randomization with respect to age
RandomizeLeadsAge = function(haremlist,leadlist){
	
	#unique list of the harem stallions we observed. 
	sids = unique(haremlist$harem_stallion)
	#number of groups (harems) we observed
	stallions = length(sids)

	out = NULL

	#for each stallion (harem)
	for (a in 1:stallions){
		#find all the leads for this harem
		htm = subset(leadlist,harem_stallion == sids[a])

		#who is in the harem? take only the records with this stallion.
		#Note: "age" must be a field within haremlist
		id_recs = subset(haremlist,harem_stallion == sids[a])
		#print(dim(id_recs)[1] == length(unique(htm$individualid)))

		#find unique ids in harem
		uid = id_recs$individualid

		#vector of ages observed
		age_obs = id_recs$age

		#find the individuals who have actually been observed as leaders
		id_obs = unique(htm$individualid)

		#find number of individuals observed as leaders; will randomly sample among observed ages in group to fill this list. note that not all individuals may have led in observed data.
		n_obs_leaders = length(id_obs)

		#randomize age label list without replacement
		age_rnd = sample(age_obs,size = n_obs_leaders,replace = FALSE)

		#now go through and assign ages to observed leads, by assigning each individual a randomly chosen age from the individuals of the harem
		for (b in 1:n_obs_leaders){

			#get all records for id
			idtm =subset(htm,individualid == id_obs[b])

			#assign pseudo age
			idtm$age = age_rnd[b]
			#output to out
			out = rbind(out,idtm)
		}
	#end loop through stals
	}
	#age-randomized leadlist
	out
#end of function
}
END
