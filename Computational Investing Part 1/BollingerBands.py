
import pandas as pd
import numpy as np
import math
import copy
import QSTK.qstkutil.qsdateutil as du
import datetime as dt
import QSTK.qstkutil.DataAccess as da
import QSTK.qstkutil.tsutil as tsu
import QSTK.qstkstudy.EventProfiler as ep
import matplotlib.pyplot as plt


def readData(dt_start, dt_end, ls_symbols):
    #Create datetime objects for Start and End dates (STL)
    #dt_start = dt.datetime(li_startDate[0], li_startDate[1], li_startDate[2]);
    #dt_end = dt.datetime(li_endDate[0], li_endDate[1], li_endDate[2]);

    #Initialize daily timestamp: closing prices, so timestamp should be hours=16 (STL)
    dt_timeofday = dt.timedelta(hours=16);

    #Get a list of trading days between the start and end dates (QSTK)
    ldt_timestamps = du.getNYSEdays(dt_start, dt_end, dt_timeofday);

    #Create an object of the QSTK-dataaccess class with Yahoo as the source (QSTK)
    c_dataobj = da.DataAccess('Yahoo', cachestalltime=0);

    #Keys to be read from the data
    ls_keys = ['open', 'high', 'low', 'close', 'volume', 'actual_close'];

    #Read the data and map it to ls_keys via dict() (i.e. Hash Table structure)
    ldf_data = c_dataobj.get_data(ldt_timestamps, ls_symbols, ls_keys);
    d_data = dict(zip(ls_keys, ldf_data));
    
    for s_key in ls_keys:
        d_data[s_key] = d_data[s_key].fillna(method='ffill')
        d_data[s_key] = d_data[s_key].fillna(method='bfill')
        d_data[s_key] = d_data[s_key].fillna(1.0)    

    return [d_data, dt_start, dt_end, dt_timeofday, ldt_timestamps];


def main():
    
    dt_start = dt.datetime(2010, 1, 1)
    dt_end = dt.datetime(2010, 12, 31)
    ldt_timestamps = du.getNYSEdays(dt_start, dt_end, dt.timedelta(hours=16))
    ls_symbols = ['MSFT']
    all_data = readData(dt_start,dt_end,ls_symbols)
    d_data = all_data[0]
    
    #for s_key in ls_keys:
        #d_data[s_key] = d_data[s_key].fillna(method='ffill')
        #d_data[s_key] = d_data[s_key].fillna(method='bfill')
        #d_data[s_key] = d_data[s_key].fillna(1.0)
    
    na_price = d_data['close'].values
    
    dt_rolling_mean = pd.rolling_mean(d_data['close'], window = 20)
    dt_rolling_std = pd.rolling_std(d_data['close'], window = 20)
    bollinger_bands_value = (na_price - dt_rolling_mean) / dt_rolling_std
    upper_bound = dt_rolling_mean + dt_rolling_std
    lower_bound = dt_rolling_mean - dt_rolling_std
    
    plt.clf()
    plt.plot(all_data[4],na_price)
    plt.plot(all_data[4],bollinger_bands_value)
    plt.plot(all_data[4],dt_rolling_mean)
    plt.plot(all_data[4],upper_bound)
    plt.plot(all_data[4],lower_bound)
    plt.axhline(y=0,color='r')
    plt.ylabel('Daily Value')
    plt.xlabel('Date')
    plt.show()
    
    print "Start Date: ", dt_start
    print "End Date: ", dt_end
    print "Symbols: ", ls_symbols
    print "Daily actual close prices: ", na_price
    print "Bollinger Bands value: ", bollinger_bands_value.to_string()
    

if __name__ == "__main__":
    main()