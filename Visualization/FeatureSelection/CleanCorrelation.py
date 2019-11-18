import pandas as pd
import numpy as np
import matplotlib.pyplot as plt
import seaborn as sb
import time

def createCorrMatrix(data, tOverall0):
    t0 = time.time()
    all_abs_corr_matrix = data.corr().abs()
    t1 = time.time()
    print("Clock @ {}; TT @ {}  \t\tAbsolute correlation matrix for all data created. Code time: {}".format(tOverall0, t1 - tOverall0, t1 - t0))

    t0 = time.time()
    all_abs_corr_matrix.to_csv('C:/Users/reave/PycharmProjects/Capstone/venv/All_Data_Absolute_Correlation.csv')
    t1 = time.time()
    print(
        "Clock @ {}; TT @ {}  \t\tCorrelation matrix (and absolute correlation matrix) converted to CSV. Code time: {}".format(
            tOverall0, t1 - tOverall0, t1 - t0))

    # Upper triangle of correlation matrix
    t0 = time.time()
    print(all_abs_corr_matrix)
    upper = all_abs_corr_matrix.where(np.triu(np.ones(all_abs_corr_matrix.shape), k=1).astype(np.bool))
    t1 = time.time()
    print("Clock @ {}; TT @ {}  \t\tUpper triangle created. Code time: {}".format(tOverall0, t1 - tOverall0, t1 - t0))

    return all_abs_corr_matrix, upper

def cleanDataOfCorr(data, all_abs_corr_matrx, upper, corrCap, tOverall0):
    # Find index of feature columns with correlation greater than corrCap
    t0 = time.time()
    to_drop = [column for column in upper.columns if any(upper[column] > corrCap)]
    print("\tNumber of dropped columns: {}\n\tColumns dropped: {}".format(len(to_drop), to_drop))
    data.drop(data[to_drop], axis=1)
    t1 = time.time()
    print("Clock @ {}; TT @ {}  \t\tData dropped. Code time: {}".format(tOverall0, t1 - tOverall0, t1 - t0))

    t0 = time.time()
    data.to_csv(r'CleanedOfCorrelationData_{}cap.csv'.format(corrCap))
    t1 = time.time()
    print("Clock @ {}; TT @ {}  \t\tCleaned data converted to CSV. Code time: {}".format(tOverall0, t1 - tOverall0, t1 - t0))

def plot(data, corr_matrix):
    plt.matshow(corr_matrix)
    f = plt.figure()
    plt.matshow(data.corr(), fignum=f.number)
    plt.xticks(range(data.shape[1]), data.columns, fontsize=14, rotation=45)
    plt.yticks(range(data.shape[1]), data.columns, fontsize=14)
    cb = plt.colorbar()
    cb.ax.tick_params(labelsize=14)
    plt.title('Correlation Matrix', fontsize=16)
    plt.show()

def run():
    print("Starting...")
    tOverall0 = time.time()

    t0 = time.time()
    data = pd.read_csv('C:/Users/reave/PycharmProjects/Capstone/venv/train_transaction.csv', sep=',')  # data frame
    t1 = time.time()
    print("Clock @ {}; TT @ {}  \t\tData imported. Code time: {}".format(tOverall0, t1 - tOverall0, t1 - t0))

    all_abs_corr_matrix, upper = createCorrMatrix(data, tOverall0)

    flag = False
    while(flag == False):
        cap = float(input("Correlation percentage cap (as decimal with leading 0 before decimal) >> "))

        cleanDataOfCorr(data, all_abs_corr_matrix, upper, cap, tOverall0)

        contFlag = input("\nPlot data? (Y/N) >>> ")
        if ((contFlag is "y") or (contFlag is "Y") or (contFlag is "yes")):
            plotFlag = False
        else:
            plotFlag = True

        while(plotFlag == False):
            t0 = time.time()
            plot(data, all_abs_corr_matrix)
            t1 = time.time()
            print("Clock @ {}; TT @ {}  \t\tPlot created. Code time: {}".format(tOverall0, t1 - tOverall0, t1 - t0))

        cont = input("\nClean dataset with new cap? (Y/N) >>> ")
        if ((cont is "y") or (cont is "Y") or (cont is "yes")):
            flag = False
        else:
            flag = True

    tOverall1 = time.time()
    print("Clock @ {}; TT @ {}  \t\tCompleted.".format(tOverall0, tOverall1-tOverall0))


run()