#this takes a while to run
names(H)
Hb = H #save backup

print(dim(H))
#get rid of the NA Walking_event_number. this gets rid of one record
H = subset(H,!is.na(Walking_event_number))
print(dim(H))

H = subset(H,Initiation_order != 0)
print(dim(H))

#list of unique sighting numbers
sts = levels(H$Sighting_Number)
#initialize tmp output to which walk events will be added bit by bit
tmp_out= NULL
#for each sighting
for (a in 1:5){
#for (a in 1:length(sts)){
	#get all records for the sighting
	stmp = subset(H,Sighting_Number == sts[a])
	#order by walking event number
	stmp = stmp[order(stmp$Walking_event_number),]
	#ws is vector of all the Walking_event_number
	ws = unique(stmp$Walking_event_number)
	#go through all ws
	for (b in 1:length(ws)){
		#find all recs for b'th walk
		wtmp = subset(stmp,Walking_event_number == ws[b])
		#how many leaders are there?
		if (dim(wtmp)[1]>0){
			lct = length(which(wtmp$Initiation_order == 1))
			#assign lct to wtmp$number_leaders
			wtmp$number_leaders = lct
			#add wtmp to tmp_out
			tmp_out = rbind(tmp_out,wtmp)
			#finish if for adding it
		}
	#end of ws
	}
#end of sighting
}
summary(tmp_out)
H = tmp_out
print(dim(H))
print(summary(H$number_leaders))
