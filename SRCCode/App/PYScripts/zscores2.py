"""
1) replace zeros with half min detection limit
2) calculate Z-scores - in array of same format as compiled_mammals
    a) Within each metal calculate mean
    b) within each metal caclulate SD
    c) for each value calculate (value - mean)/SD
3) Generate CSVs with the following outputs for each location for each species
    a) column 1: 'Variable' - which metal, listed 3 times
    b) column 2: 'Total" - Average Z-score for that location
    c) column 3: 'Sex' - Female, Male, Unknown, for each metal
    d) column 4: 'Sex value' - average of measured values for the given sex at that location
    e) column 5: 'Count' - number of measurments for each of sex and metal at that location
    f) column 6: 'Reference' - this will be the same within each species for each location - imported from another CSV

(row,column) = [i,j]
"""
import numpy as np
import pandas as pd
"""
compiled_mammals = pd.read_csv("/Users/robertgutgesell/Documents/Alison Holloway/KT Project/DataScience/compiled_mammals.csv")
mammals=np.asarray(compiled_mammals)
mammals_metalonly = mammals[:,9:] #taking metals only, ignoring first 8 columns
MDLs = pd.read_csv("/Users/robertgutgesell/Documents/Alison Holloway/KT Project/DataScience/MDLs_MO.csv")
MDLs_array=np.asarray(MDLs)

n_iter_col_len = len(mammals_metalonly[1,:])
n_iter_col = np.arange(n_iter_col_len)
n_iter_row_len = len(mammals_metalonly[:,1])
n_iter_row = np.arange(n_iter_row_len)



for j in n_iter_col:
    #print(n_iter_col)
    for i in n_iter_row:
        #print(n_iter_row)
        if mammals_metalonly[i,j] == 0:
           # print(mammals[i,j])
            mammals_metalonly[i,j] = MDLs_array[j,1]/2  #jth element in mmo = ith element of MDLs array

len(MDLs_array[:,1]) == len(mammals_metalonly[1,:]) #logic check to see if above comment true. It is.

#remove nan, i.e. every other row,

mammals_metalonly_nonan= np.delete(mammals_metalonly, list(range(0, mammals_metalonly.shape[0], 2)), axis=0)

np.savetxt("mmo_MDLs.csv", mammals_metalonly_nonan, fmt = "%s", delimiter=",")
"""

"""
Calculating Z-scores

Make a new array with z-scores in place of measured values
Z = (x-u)/s
where x = measured value, u = mean of that metal, s = standard deviation of that metal
"""

colen = len(inarray[1,:])
colen_iter = np.arange(colen)
rolen = len(inarray[:,1])
rolen_iter = np.arange(rolen)


#mammals_metalonly_nonan[np.isnan(mammals_metalonly_nonan)] = 0
"""
for i in rolen_iter:
    for j in colen_iter:
        try:
            if type(inarray[i,j]) == str :
                inarray[i,j] = float(inarray[i,j])
        except ValueError:
            print(i,j)

inarray[201,0] = 0

for i in rolen_iter:
    for j in colen_iter:
        if type(mammals_metalonly_nonan[i,j]) == str :
            mammals_metalonly_nonan[i,j] = float(mammals_metalonly_nonan[i,j])

for i in rolen_iter:
    for j in colen_iter:
        mammals_metalonly_nonan[i,j] = np.nan_to_num(mammals_metalonly_nonan[i,j], nan=0.0)
"""
zscore_array = np.zeros((rolen,colen))
for j in colen_iter:
    u = np.mean(inarray[:,j])
    s = np.std(inarray[:,j])
    for i in rolen_iter:
        x = inarray[i,j]
        z = (x - u)/s
        zscore_array[i,j] = z

"""
PPA_array = np.zeros((rolen,colen))
for j in colen_iter:
    u = np.mean(mammals_metalonly_nonan[:,j])
    for i in rolen_iter:
        x = mammals_metalonly_nonan[i,j]
        p = (x / u) * 100
        PPA_array[i,j] = p
"""
"""
Outputting CSVs

"""
"""
mammals_nonan = np.delete(mammals, list(range(0, mammals.shape[0], 2)), axis=0)

np.savetxt("mam_nonan.csv", mammals_nonan, fmt = "%s", delimiter=",")

spe_sex_loc = np.asarray(mammals_nonan[:,2:5])

z_master_metals = np.concatenate([spe_sex_loc, zscore_array], axis=1)

ppa_master_metals = np.concatenate([spe_sex_loc, PPA_array], axis=1)



loc = z_master_metals[:,2]
spec = z_master_metals[:,0]
uniq_loc = list(dict.fromkeys(loc))
uniq_spec = list(dict.fromkeys(spec))

loc_len = len(uniq_loc)
loc_iter = np.arange(loc_len)
spec_len = len(uniq_spec)
spec_iter = np.arange(spec_len)

col = len(z_master_metals[1,:])
col_iter = np.arange(col)
rol = len(z_master_metals[:,1])
rol_iter = np.arange(rol)

A = np.random.randint(0, 10, size=345).reshape(69, 5)
col_names = ['Total','Sex','	Sex Value','Count','Reference']
row_names = ['Hg','Hg','Hg','Li','Li','Li','V','V','V','Mn','Mn','Mn','Fe','Fe','Fe','Co','Co','Co','Ni','Ni','Ni','Cu','Cu','Cu','Zn','Zn','Zn','Ga','Ga','Ga','As','As','As','Se','Se','Se','Rb','Rb','Rb','Sr','Sr','Sr','Mo','Mo','Mo','Ag','Ag','Ag','Cd','Cd','Cd','Sn','Sn','Sn','Sb','Sb','Sb','Ba','Ba','Ba','Tl','Tl','Tl','Pb','Pb','Pb','Bi','Bi','Bi']
df = pd.DataFrame(A, index=row_names, columns=col_names)





count = 0
sizecalc = []



for i in loc_iter:
    if uniq_loc[i] == 'FleetCreek/JackpineRidg':
        uniq_loc[i] = 'FleetCreekJackpineRidg'

#determining how many times locations come up
for i in uniq_loc:
    for j in rol_iter:
        if i == z_master_metals[j,2]:
            count = count+1
    sizecalc.append(count)
    count=0


#create arrays for each location that are the appropriate dimensions
for j in loc_iter:
    i = uniq_loc[j]
    indic = sizecalc[j]
    loc[i] = pd.DataFrame(np.nan, index=[i], columns=[j])
    #exec('loc%s= pd.DataFrame() %(i)') #try again with pandas



#assigning rows from z_master_metals to loc%s :

#try again with dataframe
for j in loc_iter:
    x = uniq_loc[j]
    for i in rol_iter:
        if x == z_master_metals[i,2]:
            #print(z_master_metals[i,2])
            for l in range(0,sizecalc[j]):
               exec('loc%s[l,:] = z_master_metals[i,:]'  %(x))
"""

