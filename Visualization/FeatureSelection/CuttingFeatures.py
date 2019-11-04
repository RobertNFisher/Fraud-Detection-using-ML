import pandas as pd


f = open("FeatureCut.txt", "r")
f_array = []
rd = []

data = pd.read_csv("Training_Sample.csv", sep=",", index_col=0)


for line in f:
    f_array.append(line)

for i in f_array:
    if i not in rd:
        rd.append(i)



for i in rd:
    temp = i.replace("\n","")
    data.drop(temp, axis = 1, inplace = True)




data.to_csv(r'Removed_Features.csv')


f.close()
