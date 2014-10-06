intersect(names(H), names(W))
HW = merge(H, W)
print(names(HW))

print(nrow(H))
print(nrow(W))
print(nrow(HW))
#THere should be one-one correspondence between Sight_Num and Date. Visually inspect. 
Sightings = unique(data.frame(H$Sighting_Number, H$Date))
print(Sightings)

print(nrow(unique(data.frame(H$Sighting_Number))))
print(nrow(unique(data.frame(H$Sighting_Number, H$Date))))
print(nrow(unique(data.frame(H$Sighting_Number, H$Date, H$Harem_stallion))))

