import pandas as pd
import numpy as np
import matplotlib.pyplot as plt
import seaborn as sb



data = pd.read_csv('train_transaction.csv', sep=',')
dataFraud = data.loc[data['isFraud'] == 1]
dataNotFraud = data.loc[data['isFraud'] == 0]


fraud_matrix = dataFraud.corr()
norm_matrix = dataNotFraud.corr()


d = data.corr().unstack().sort_values().drop_duplicates()
d1 = d.abs()


d.to_csv(r'All_Data_Correlation.csv')
d1.to_csv(r'All_Data_AbsCorr.csv')


sb.heatmap(fraud_matrix)
plt.figure()
sb.heatmap(norm_matrix)

plt.show()
