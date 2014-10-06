#The inputs for this function are:

#1. leadlist: records of leads by individuals. Each record is an instance of an individual beginning to walk and being followed by at least half the group within one minute.
#The field names of leadlist are:
#a) individualid: the unique identifier of the individual who initiated the walk.
#b) harem_stallion: the identity of the stallion of the harem.
#c) age: categories are 0 (foal), 1 (subadult), 2 (adult)
#d) sex: M (male), F (female)

#2. haremlist: records of membership of harem. The field names are: 
#a) individualid: a member of the harem
#b) harem_stallion: stallion of the harem
#c) age: age category of individual during field season of observation

#----------------------------------------------------------------------

#compute variance in number of leads by individual
var_leads = function(leadlist){
	var(table(leadlist$individualid))
}

#function to randomize leader identity
Randomizeleads = function(haremlist, leadlist){
	sids = unique(haremlist$harem_stallion)
	stallions = length(sids)

	out = NULL

	for (a in 1:stallions){
		#find all the leads for this harem
		htm = subset(leadlist,harem_stallion == sids[a])

		#identify individuals in the harem
		rtm = subset(haremlist,harem_stallion == sids[a])
		id_list = rtm$individualid

		#sample from individual list with replacement to fill all slots in htm (all lead events)
		htm$individualid = sample(id_list,nrow(htm),replace = TRUE)

		#output htm to out
		out = rbind(out,htm)
	#end loop through stals
	}
	out
}
END
