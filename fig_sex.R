#look at the real difference and random differences
list(real=sexdiff_rl,rand=sexdiff_rnd)

#find male fractions in null distribution
m_frac = rnd_cts[2,]/colSums(rnd_cts)

#make boxplot of m_frac
boxplot(m_frac,
	ylim = c(0.2,0.4),
	ylab = "Fraction of leads by male",
	outline = FALSE#do not draw outliers
	)

#find fraction of leads by male in observed data
m_rl = sexcts_rl[2]/sum(sexcts_rl)

#plot observed male fraction
points(1,m_rl,pch = 23)

#make legend for observed value
legend(1.1,0.4,"Observed value",pch = 23)

END
