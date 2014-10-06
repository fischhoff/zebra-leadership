#what are the unique values of Clock angle of the move?
print(unique(W2$Clock))

#reassign to NA if clock == 0
nainds = which(W2$Clock == 0)
W2$Clock[nainds] = NA

#now check reassigned to NA
print(unique(W2$Clock))

#what are the unique values of Car_bearing angle of the move?
unique(W2$Car_Bearing)
#make sure none over 360
print(length(which(W2$Car_Bearing>360)) == 0)

#reassign to NA if clock == 0, because don't know if that's really north or zero
nainds = which(W2$Car_Bearing== 0)
W2$Car_Bearing[nainds] = NA

#now check reassigning worked
print(unique(W2$Car_Bearing))

#turn clock number into compass direction by walking around the clock from car_bearing
ang = W2$Car_Bearing + 30*W2$Clock
#find inds for which ang > 360
hi = which(ang > 360)
#subtract 360 from these
ang[hi] = ang[hi]-360

W2 = transform(W2,Compass_bearing = ang)
print(unique(W2$Compass_bearing))
