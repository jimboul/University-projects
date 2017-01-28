
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


def find_events(ls_symbols, d_data):
    
    #df_close = d_data['actual_close']
    df_close = d_data['close']
    ts_market = df_close['SPY']
	
    spy_na_price = ts_market.values
    dt_rolling_mean = pd.rolling_mean(ts_market, window = 20)
    dt_rolling_std = pd.rolling_std(ts_market, window = 20)
    spy_bb_value = (spy_na_price - dt_rolling_mean) / dt_rolling_std
    spy_upper_bound = dt_rolling_mean + dt_rolling_std
    spy_lower_bound = dt_rolling_mean - dt_rolling_std

    print "Finding Events"

    # Creating an empty dataframe
    df_events = copy.deepcopy(df_close)
    df_events = df_events * np.NAN

    # Time stamps for the event range
    ldt_timestamps = df_close.index
    
    # Assessment to find when an error is occurred
    for s_sym in ls_symbols:
	na_price = df_close[s_sym].values
    	dt_rolling_mean = pd.rolling_mean(df_close, window = 20)
    	dt_rolling_std = pd.rolling_std(df_close, window = 20)
    	bollinger_bands_value = (na_price - dt_rolling_mean) / dt_rolling_std
	upper_bound = dt_rolling_mean + dt_rolling_std
    	lower_bound = dt_rolling_mean - dt_rolling_std
        for i in range(1, len(ldt_timestamps)):
            # Calculating the returns for this timestamp
            f_symbollinger_today = bollinger_bands_value[s_sym].ix[ldt_timestamps[i]]
            f_symbollinger_yest = bollinger_bands_value[s_sym].ix[ldt_timestamps[i - 1]]
            f_marketbollinger_today = spy_bb_value.ix[ldt_timestamps[i]]
            f_marketbollinger_yest = spy_bb_value.ix[ldt_timestamps[i - 1]]
            #f_symreturn_today = (f_symbollinger_today / f_symbollinger_yest) - 1
            #f_marketreturn_today = (f_marketbollinger_today / f_marketbollinger_yest) - 1

            # The constraints when an event is occurred
            if f_symbollinger_yest >= -2.0 and f_symbollinger_today <= -2.0:
                df_events[s_sym].ix[ldt_timestamps[i]] = 1

    return df_events


if __name__ == '__main__':
    
    dt_start = dt.datetime(2008, 1, 1)
    dt_end = dt.datetime(2009, 12, 31)
    ldt_timestamps = du.getNYSEdays(dt_start, dt_end, dt.timedelta(hours=16))

    dataobj = da.DataAccess('Yahoo')
    ls_symbols = dataobj.get_symbols_from_list('sp5002012')
    ls_symbols.append('SPY')

    ls_keys = ['open', 'high', 'low', 'close', 'volume', 'actual_close']
    ldf_data = dataobj.get_data(ldt_timestamps, ls_symbols, ls_keys)
    d_data = dict(zip(ls_keys, ldf_data))

    for s_key in ls_keys:
        d_data[s_key] = d_data[s_key].fillna(method='ffill')
        d_data[s_key] = d_data[s_key].fillna(method='bfill')
        d_data[s_key] = d_data[s_key].fillna(1.0)
	
    df_events = find_events(ls_symbols, d_data)
    print "Creating Study"
    ep.eventprofiler(df_events, d_data, i_lookback=20, i_lookforward=20,
                s_filename='event_bollinger.pdf', b_market_neutral=True, b_errorbars=True,
                s_market_sym='SPY')
