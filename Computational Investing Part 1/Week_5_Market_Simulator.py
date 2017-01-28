
import QSTK.qstkutil.qsdateutil as du
import QSTK.qstkutil.tsutil as tsu
import QSTK.qstkutil.DataAccess as da
import datetime as dt
import matplotlib.pyplot as plt
import pandas as pd
import numpy as np
import time
from scipy.optimize import minimize
import math
import copy
import QSTK.qstkstudy.EventProfiler as ep
import csv
import sys


def marketsim(cash,orders_file,values_file):
    
    orders = df.read_csv(orders_file,index_col='Date',parse_dates=True,header=None)
    ls_symbols = list(set(orders['X.4'].values))
    df_lastrow = len(orders) - 1
    dt_start = dt.datetime(orders.get_value(0, 'X.1'),orders.get_value(0, 'X.2'),orders.get_value(0, 'X.3'))
    dt_end = dt.datetime(orders.get_value(df_lastrow, 'X.1'),orders.get_value(df_lastrow, 'X.2'),orders.get_value(df_lastrow, 'X.3') + 1 )    
    #d_data = readData(dt_start,dt_end,ls_symbols)
    #Initialize daily timestamp: closing prices, so timestamp should be hours=16 (STL)
    dt_timeofday = dt.timedelta(hours=16)
    
    #Get a list of trading days between the start and end dates (QSTK)
    ldt_timestamps = du.getNYSEdays(dt_start, dt_end, dt_timeofday)

    #Create an object of the QSTK-dataaccess class with Yahoo as the source (QSTK)
    c_dataobj = da.DataAccess('Yahoo', cachestalltime=0)
        
    #Keys to be read from the data
    ls_keys = ['open', 'high', 'low', 'close', 'volume', 'actual_close']
    
    #Read the data and map it to ls_keys via dict() (i.e. Hash Table structure)
    df_data = c_dataobj.get_data(ldt_timestamps, ls_symbols, ls_keys)
    d_data = dict(zip(ls_keys, ldf_data))
    
    ls_symbols.append("_CASH")
    trades = pd.Dataframe(index=list(ldt_timestamps[0]),columns=list(ls_symbols))
    current_cash = cash
    trades["_CASH"][ldt_timestamps[0]] = current_cash
    current_stocks = dict()
    for symb in ls_symbols:
        current_stocks[symb] = 0
        trades[symb][ldt_timestamps[0]] = 0
        
    for row in orders.iterrows():
        row_data = row[1]
        current_date = dt.datetime(row_data['X.1'],row_data['X.2'],row_data['X.3'],16)
        symb = row_data['X.4']
        stock_value = d_data['close'][symb][current_date]
        stock_amount = row_data['X.6']
        if row_data['X.5'] == "Buy":
            current_cash = current_cash - (stock_value*stock_amount)
            trades["_CASH"][current_date] = current_cash
            current_stocks[symb] = current_stocks[symb] + stock_amount
            trades[symb][current_date] = current_stocks[symb]
        else:
            current_cash = current_cash + (stock_value*stock_amount)
            trades["_CASH"][current_date] = current_cash
            current_stocks[symb] = current_stocks[symb] - stock_amount
            trades[symb][current_date] = current_stocks[symb]
        
    
    #trades.fillna(method='ffill',inplace=True)
    #trades.fillna(method='bfill',inplace=False)
    trades.fillna(0)
    #alt_cash = current_cash
    #alt_cash = trades.cumsum()
    value_data = pd.Dataframe(index=list(ldt_timestamps),columns=list("V"))
    value_data = value_data.fillna(0)
    value_data = value_data.cumsum(axis=0)
    for day in ldt_timestamps:
        value = 0
        for sym in ls_symbols:
            if sym == "_CASH":
                value = value + trades[sym][day]
            else:
                value = calue + trades[sym][day]*d_data['close'][sym][day]
        value_data["V"][day] = value
    
    fileout = open(values_file,"w")
    for row in value_data.iterrows():
        file_out.writelines(str(row[0].strftime('%Y,%m,%d')) + ", " + str(row[1]["V"].round()) + "\n" )
    
    fileout.close()
    


def main():
    
    if len(sys.argv) != 4:
        print "Invalid arguments for marketsim.py. It should be of the following syntax: marketsim.py initial_cash orders_file.csv values_file.csv"
        sys.exit(0)
        
    initial_cash = int (sys.argv[1])
    ordersFile = sys.argv[2]
    valuesFile = sys.argv[3]
    
    marketsim(initial_cash,ordersFile,valuesFile)
    
    
if __name__ == "__main__":
    main()
    
    