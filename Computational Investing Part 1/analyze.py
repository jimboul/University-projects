#imports
# QSTK Imports
import QSTK.qstkutil.qsdateutil as du
import QSTK.qstkutil.tsutil as tsu
import QSTK.qstkutil.DataAccess as da

# Third Party Imports
import datetime as dt
import matplotlib.pyplot as plt
import pandas as pd
import numpy as np
import time
import sys

def analyze(values_file,benchmark):
    
    # PART A
    
    # Portfolio statistics from the given file
    
    value_data = pd.read_csv(values_file,header=None)
    port_val = value_data['X.4'].values
    port_normalized_val = port_val / port_val[0]
    #port_normalized_value = port_normalized_val.copy().sum(axis=1)
    port_rets = port_val.copy() # if the commented line above holds then this line turns into: port_rets = port_normalized_value.copy() (!!!)
    tsu.returnize0(port_rets)
    port_daily_rets = np.mean(port_rets)
    port_vol = np.std(port_rets)
    port_sharpe_ratio = np.sqrt(252) * port_daily_rets / port_vol
    
    #Faster implementation of cumulative returns instead of recursive method
    port_cum_rets = port_rets[len(port_rets) - 1] / port_rets
    
    # PART B
    
    # Benchmark statistics
    
    df_lastrow = len(value_data) - 1
    dt_start = dt.datetime( value_data.get_value(0, 'X.1'), value_data.get_value(0, 'X.2'), value_data.get_value(0, 'X.3'))
    dt_end = dt.datetime( value_data.get_value(df_lastrow, 'X.1'), value_data.get_value(df_lastrow, 'X.2'), value_data.get_value(df_lastrow, 'X.3') + 1 )    
    
    #Initialize daily timestamp: closing prices, so timestamp should be hours=16 (STL)
    dt_timeofday = dt.timedelta(hours=16)
    
    #Get a list of trading days between the start and end dates (QSTK)
    ldt_timestamps = du.getNYSEdays(dt_start, dt_end, dt_timeofday)
    
    #Create an object of the QSTK-dataaccess class with Yahoo as the source (QSTK)
    c_dataobj = da.DataAccess('Yahoo', cachestalltime=0)
    
    #Keys to be read from the data
    ls_keys = ['open', 'high', 'low', 'close', 'volume', 'actual_close']
    
    #The only symbol we need is the benchmark
    ls_symbols = [benchmark]
    
    #Read the data and map it to ls_keys via dict() (i.e. Hash Table structure)
    ldf_data = c_dataobj.get_data(ldt_timestamps, ls_symbols, ls_keys)
    d_data = dict(zip(ls_keys, ldf_data))
    
    #Get numpy ndarray of close prices (numPy)
    na_price = d_data['close'].values
    
    #Normalize prices to start at 1 (if we do not do this, then portfolio value
    #must be calculated by weight*Budget/startPriceOfStock)
    na_normalized_price = na_price / na_price[0,:] 
    
    #row-wise sum
    na_benchmark_value = na_normalized_price.copy().sum(axis=1)
    
    #Calculate daily returns on portfolio
    na_benchmark_rets = na_benchmark_value.copy()
    tsu.returnize0(na_benchmark_rets)
    
    #Calculate volatility (stdev) of daily returns of portfolio
    f_benchmark_volatility = np.std(na_benchmark_rets) 
    
    #Calculate average daily returns of portfolio
    f_benchmark_avgret = np.mean(na_benchmark_rets)
    
    #Calculate portfolio sharpe ratio (avg portfolio return / portfolio stdev) * sqrt(252)
    f_benchmark_sharpe = (f_benchmark_avgret / f_benchmark_volatility) * np.sqrt(252)
    
    ##Calculate cumulative daily return
    ##using recursive function
    #def cumret(t, lf_returns):
        ##base-case
        #if t==0:
            #return (1 + lf_returns[0])
        ##continuation
        #return (cumret(t-1, lf_returns) * (1 + lf_returns[t]))
    #f_portf_cumrets = cumret(na_portf_rets.size - 1, na_portf_rets)
    
    # Faster implementation of cumulative returns
    f_benchmark_cumrets = na_benchmark_rets[len(na_benchmark_rets) - 1] / na_benchmark_rets
    
    # PART C
    
    # Plot the results(statistics)
        
    plt.clf()
    plt.plot(dt_timeofday, f_benchmark_cumrets)  #Benchmark
    plt.plot(dt_timeofday, port_cum_rets) #Portfolio
    plt.axhline(y=0, color='r')
    plt.legend([benchmark, 'Portfolio'])
    plt.ylabel('Daily Value')
    plt.xlabel('Date')
    plt.savefig('Analysis(Market Simulation).pdf', format='pdf')     
    
    
    # PART D
    
    # Show the results(statistics) in contrast
        
    print "The final value of the portfolio using", values_file, "file is ", dt_end.year, ",", dt_end.month, ",", dt_end.day, ",", port_val[-1], "\n"
        
    #Data range
    print "Details of the Performance of the portfolio: \n"
    print "Data Range: ", str(dt_start), " to ", str(dt_end), "\n"
        
    #Sharpe ratio
    print "Sharpe Ratio of Fund:", port_sharpe_ratio
    print "Sharpe Ratio of ", benchmark , ":", f_benchmark_sharpe, "\n"
        
    #Volatility
    print "Standard Deviation of Fund:", port_vol
    print "Standard Deviation of", benchmark, ":", f_benchmark_volatility, "\n"
        
    #Daily returns
    print "Average Daily Return of Fund:", port_daily_rets
    print "Average Daily Return of", benchmark, ":", f_benchmark_avgret , "\n" 
        
    #Cumulative returns
    print "Total Return of Fund: ", port_cum_rets
    print "Total Return of", benchmark, ":", f_benchmark_cumrets, "\n"
    
def main():
    
    if len(sys.argv) != 4:
        print "Invalid arguments to analyze.py, 2 required."
        print "Example input: analyze.py values.csv \$SPX"
        sys.exit(0)
    
    values_file = str(sys.argv[2])
    benchmark = str(sys.argv[3])
    
    analyze(values_file, benchmark) 
    

if __name__ == "__main__":
    main()