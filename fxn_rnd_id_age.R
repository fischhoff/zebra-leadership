#compute variance in number of leads by individual
var_leads = function(leadlist){
	var(table(leadlist$individualid))
}

#Randomly sample from individuals within each group (harem) to fill 
#the observed leader spots. Preserve observed age of leader
#"haremlist" is the list of groups, with each individual having been assigned
#to one group. The field describing which harem an individual is in is 
#"harem_stallion"

#leadlist is the list of leaders of moves. For each record of a move, we 
#have indicated the harem_stallion of the leader. (This may be the same 
#as the identity of the leader, if the leader happens to be the stallion.)

RandomizeleadsIdControlAge = function(haremlist, leadlist){
	#unique list of the harem stallions we observed. 
	sids = unique(haremlist$harem_stallion)
	#number of groups (harems) we observed
	stallions = length(sids)

	out = NULL
	
	#for each stallion (representing a harem)
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

			#all the unique ids in group who are of this age
			id_list = id_age_tm$individualid

			#get the walking records only for this age
			htm_age = subset(htm,age == ages_obs[g])

			#sample from age-appropriate individual list,
			#with replacement, to fill all slots in htm_age
			rnd_id_leads = sample(id_list,dim(htm_age)[1],replace=TRUE)

			#assign this to htm_age
			htm_age$individualid = rnd_id_leads

			#output htm_age to out
			out = rbind(out,htm_age)
		#end loop through ages
		}
	#end loop through stals
	}
	#output "out" to use in separate function to recompute variance in leadership.
	out
#end function
}
END
