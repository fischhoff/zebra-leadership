#This has scripts for cleaning up and analyzing two datasets on leadership in zebras.

#run script to read in harem walking events data (W) collected by Elise in 2006
source("readin_EC.R")

# Read in corrected harem descriptions (H) for each sightings of Elise's data.  
#Also, correct stupid field name.
#this requires fixed_harems.csv  
source("readin_hrm.R")

# Merge W and H into one data.frame using merge
source("merge.R")

# Check what lead types are in Elise data. there are aggressive, passive, and 3 blank entries. 
source("lead_type_elise.R")

# Read in harem walking data from Heather. need heather_lead.csv as input. 
source("rd_H_lead.R")

# Error-checking: Check leadership_no in Heather's data to see why later showing up as NA. 
#but all seems to be numeric, so never mind.
source("chk_lead_no.R")

# Change clock angle to compass direction in Heather's data
source("clock_ang.R")

# Remove NA Walk events and 0 Initiation_orders. 
#Find number of individuals referred to as leader for each walking event
source("lead_id.R")

# Assign stallion to heather data
source("/Users/ilyafischhoff/GitHub/zebra-movement/stal_sght_heather.R")

#Fix Interaction_type in Heather's data to match passive vs. aggressive as in Elise's data
source("/Users/ilyafischhoff/GitHub/zebra-movement/fix_H_lead_type.R")

# Compare field names of Heather and Elise data, then combine the two. where I left off. need to 
#check on lactation state, lead type, end activity. 
#Lead_type is not uniform
#there is a warning message I'm ignoring, not sure which field it affected
source("/Users/ilyafischhoff/GitHub/zebra-movement/field_names_comp.R")

# Fix displacements to take our non-real values; change to numeric 
#ignoring error message re NAs introduced by coercion
source("/Users/ilyafischhoff/GitHub/zebra-movement/disp_fix.R")

# Check, fix the compass bearing data
source("/Users/ilyafischhoff/GitHub/zebra-movement/ang_check.R")

#Remove records for which Initiation_order is zero, or NA. 
#Find number of individuals referred to as leader for each walking event; field name: number_leaders. 
#there are some records with 0 leaders. 
source("/Users/ilyafischhoff/GitHub/zebra-movement/lead_id.R")

# Examine walk events with strange number of initiators
#there seem to be some records w/ more than one leader that could be 
#actual ties. but we don't remember what happened in the field, and notebooks may exist but 
#are a pain to dig out. so we are including for now only those records w/ one and only one leader.
#there also seem to be a few cases where the same walking event # has been assigned for two walking events. 
source("/Users/ilyafischhoff/GitHub/zebra-movement/init_odd.R")

# Are there ids who are unknown, or represent whole harem? 
#Create known_id field to indicate those records from known individuals
source("/Users/ilyafischhoff/GitHub/zebra-movement/id_chk.R")

# Add a serial field
source("/Users/ilyafischhoff/GitHub/zebra-movement/serial_add.R")

# Should make sure only one record for each individual per walking event
#one_id_per.R
