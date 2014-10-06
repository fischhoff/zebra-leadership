include $(MKDIR)/standard.def

###################################################################

target: fig_sex.R.out 

#The data used in our analyses are contained in the file lead.R.env. This is an R environment file containing leadership data and data on the composition of herds. The environment contains subsets of the data for particular years, and age classes, as appropriate to particular tests. Other users may wish to replace lead.R.env with their own data. In this case, users will need to change dataframe field names as appropriate, either in their own data or in the R scripts. 

#----------------------------------------------------------------------
#Randomization test for individual differences in leadership. This set of scripts tests for significant evenness/unevenness of distribution of leadership among individuals in a group.

#Randomly resample among individuals within harems to fill lead observations; use to generate null distribution of variance in leadership. 
fxn_rnd_id.R.out: fxn_rnd_id.R

#Get summary statistics of observed data. Replicate many runs of the randomization fxn_rnd_id.R to generate null distribution of variance in leadership. Determine p value of test for variance in individual leads. Environment for this is lead.R.env, which contains all the leadership observations. 
rnd_id.R.out: lead.R.env fxn_rnd_id.R.env rnd_id.R

#----------------------------------------------------------------------
#Randomization tests for phenotypic differences. These scripts test for effects of phenotype on leadership. 

#Phenotypic factor: Age

#Functions to a) Find the difference in number of leads by adults and young. b) to randomize leads with respect to age, controlling for individual differences by keeping constant the number of leads by each individual. 
fxn_agernd.R.out: fxn_agernd.R 

#run function fxn_agernd.R many (e.g. 1000) times to determine null distributions of difference in leadership by adult vs. young, and compare real to null. only use data for which there is no bias with respect to age in sampling.
rnd_age.R.out: fxn_agernd.R.env lead.R.env rnd_age.R

#Phenotypic factor: Sex

#Define a) Function to find count of leads by sex. b) Function to randomize with respect to sex, while maintaining the observed number of leads by each individual. 
fxn_sexrnd.R.out: fxn_sexrnd.R

#run function fxn_sexrnd.R many (e.g. 1000) times to determine null distributions of leadership by sex, and compare real to null. 
rnd_sex.R.out: fxn_sexrnd.R.env lead.R.env rnd_sex.R

#Make figure showing boxplot of null (randomization) distribution of fraction of male leads, with observed proportion also shown as point
fig_sex.R.out: rnd_sex.R.env fig_sex.R

#----------------------------------------------------------------------
#Randomization test for individual differences, controlling for phenotype. Here we test for significant evenness/unevenness among individuals in  leadership, while accounting for possible variation due to phenotypic factors. 

#Examine individual variation, controlling for age. 
fxn_rnd_id_age.R.out: fxn_rnd_id_age.R

#Run randomization fxn_rnd_id_age.R 1000 times to generate distribution, and compare observed test statistics to null distribution.
rnd_idage.R.out: fxn_rnd_id_age.R.env lead.R.env rnd_idage.R

#Randomize leadership with respect to individual, while holding age and sex of leader constant. Organize results in various ways, so as to make figures later. 
fxn_rnd_id_agesex.R.out: fxn_rnd_id_agesex.R

#Run randomization in fxn_rnd_id_agesex.R
rnd_agesex.R.out: fxn_rnd_id_agesex.R.env lead.R.env rnd_agesex.R

#Make figure showing observed distribution of the fraction of leads taken by individual, within each's harem; make analogous figure for the results from the randomization run with median variance.
fig_lead_dist.R.out: rnd_agesex.R.env fig_lead_dist.R

###################################################################

include $(MKDIR)/standard.mk

