#Define functions to a) compute variance of lead counts from dataset of leads; b) compute table of how often individuals have led; c) subset table of individual lead counts for a particular set of individuals; d) Find fraction of leads for each individual, within their harem; e) compute variance based on tabulated counts; f) randomize leads with respect to individual, while holding both age and sex of leader constant.

#a)
#compute variance in number of leads by individual
var_leads = function(leadlist){
	var(table(leadlist$individualid))
}

#b)
#Function leads_tab computes table of how often individuals have led. We use this function so that we can make a figure comparing the distribution of observed individual leads to the distribution from the randomization with the median variance.  
leads_tab = function(leadlist){
	table(leadlist$individualid)
}

#c) 
#Function that takes only the rows of leads_tab that correspond to individuals in harems being watched in leadlist. Use haremlist to know the appropriate individuals
tab_ids = function(leads_tab,haremlist){
	index_list = NULL
	#get the list of appropriate ids
	ids = haremlist$individualid
	for (a in 1:length(ids)){
		new = which(names(leads_tab)==ids[a])
		index_list = c(index_list,new)
	}
	#now take only the tabulated results for the appropriate ids
	leads_tab[index_list]
}

#d)
#Find the proportion of a harem's leads, by individual
frac_hrm = function(tab,haremlist){
	haremlist$individualid=as.character(haremlist$individualid)	
	haremlist$harem_stallion=as.character(haremlist$harem_stallion)
	out = NULL#output that will be tab_order
	inds = NULL
	us = unique(haremlist$harem_stallion)
	for (a in 1:length(us)){
		hrminds = NULL
		tmp = subset(haremlist,harem_stallion==us[a])
		harem_ids = rep(NA,dim(tmp)[1])
		harem_ids[1] = us[a]
		tmp = subset(tmp,individualid != us[a])
		harem_ids[2:length(harem_ids)] = tmp$individualid
		#now find the tabulated leads for these ids
		for (b in 1:length(harem_ids)){
			id_index = which(names(tab)==harem_ids[b])
			inds= c(inds,id_index)
			hrminds = c(hrminds,id_index)
		}
	#find how many sightings for harem
	hrm_ct = sum(tab[hrminds])
	#divide counts for harem by total obs for harem
	frac_tmp = tab[hrminds]/hrm_ct
	out = c(out,frac_tmp)
	#end harem_stallion
	}
   out	
}

#e) 
#Compute variance based on leads_tab table. This is only for use with the randomization results, in which each column will contain the individually-tabulated results of one run.  
var_tab = function(tab_cts){
	apply(tab_cts,2,function(i){
	var(i)}
	#close apply
	)
#close function
}

#f) 
#Randomly sample from individuals within each group (harem) to fill 
#the observed leader spots. Preserve observed age  and sex of leader
#"haremlist" is the list of groups, with each individual having been assigned
#to one group. The field describing which harem an individual is in is 
#"harem_stallion"

#leadlist is the list of leaders of moves. For each record of a move, we 
#have indicated the harem_stallion of the leader. (This may be the same 
#as the identity of the leader, if the leader happens to be the stallion.)

RandomizeleadsIdCtrlAgesex = function(haremlist, leadlist){
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
		rtm = subset(haremlist,harem_stallion == sids[a])
	
		#get all the unique ages in the group
		ages_obs = unique(rtm$age)

		#for each age seen, find the individuals in that age

		for (g in 1:length(ages_obs)){
	
			#find the id records for this age
			id_age_tm = subset(rtm,age == ages_obs[g])

			#find the sexes of these individuals
			sexes_obs = unique(id_age_tm$sex)

			#for each sex seen, within the age class, find the ids
			for (h in 1:length(sexes_obs)){
				id_age_sex_tm = subset(id_age_tm,sex == sexes_obs[h])

				#all the unique ids in group who are of this age/sex
				id_list = id_age_sex_tm$individualid

				#get only walking records for this age
				htm_age = subset(htm,age == ages_obs[g])

				#further subset, get only recs for this sex
				htm_age_sex = subset(htm_age,sex == sexes_obs[h])

				#sample from age- and sex-appropriate individual list,
				# with replacement, to fill all slots in htm_age_sex
				rnd_id_leads=sample(id_list,dim(htm_age_sex)[1],replace=TRUE)

				#assign this to htm_age_sex
				htm_age_sex$individualid = rnd_id_leads

				#output htm_age_sex to out
				out = rbind(out,htm_age_sex)
			#end loop through sexes_obs
			}
		#end loop through ages
		}
	#end loop through stals
	}
	#(we will recompute variance of randomized data in separate function)
	out
#end function
}
END
