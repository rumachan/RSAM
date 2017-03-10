#!/usr/bin/env python
#rsam_day.py
#from one day rsam files make a year file with one value per day

import sys
import os
import numpy as np
import datetime as dt
from obspy.core import read, Trace, Stream

#input arguments
if (len(sys.argv) < 6) | (len(sys.argv) > 8):
  sys.exit("syntax rsam_day.py site(DRZ.10-EHZ.CH) rsam_dir date(yyyymmdd) out_dir filter(lp,hp,bp,none) [f1 f2]")
else:
  site = sys.argv[1]
  rsam_dir = sys.argv[2]
  date = sys.argv[3]
  out_dir = sys.argv[4]
if len(sys.argv) == 6:  #filter = none
  filtype = sys.argv[5]
elif len(sys.argv) == 7:  #filter = lp or hp, one frequency given
  filtype = sys.argv[5]
  f = float(sys.argv[6])
elif len(sys.argv) == 8:  #filter = bp, two frequencies given
  filtype = sys.argv[5]
  f1 = float(sys.argv[6])
  f2 = float(sys.argv[7])

#initialise data array for rsam values
year = np.zeros(366)
day = np.zeros(1)

#get data file name and location
site_dir = str.split(site, '.')[0] + '.' + str.split(site, '.')[2]      #DRZ.CH
dd = dt.datetime.strptime(date, '%Y%m%d')       #into correct format
yd = dd.strftime("%Y.%j")
y = dd.strftime("%Y")
if filtype == 'none':
  file = yd + '.' + site + '.rsam'
  yfile = y + '.' + site + '.rsam'
elif (filtype == 'lp') | (filtype == 'hp'):
  strf = '%.2f' %f      #string version with 2 decimal places
  file = yd + '.' + site + '.' + filtype + '_' + strf + '.rsam'
  yfile = y + '.' + site + '.' + filtype + '_' + strf + '.rsam'
elif filtype == 'bp':
  strf1 = '%.2f' %f1    #string version with 2 decimal places
  strf2 = '%.2f' %f2    #string version with 2 decimal places
  file = yd + '.' + site + '.' + filtype + '_' + strf1 + '-' + strf2 + '.rsam'
  yfile = y + '.' + site + '.' + filtype + '_' + strf1 + '-' + strf2 + '.rsam'
rsamfile = os.path.join(rsam_dir, site_dir, file)
yrsamfile = os.path.join(rsam_dir, site_dir, yfile)

#if rsamfile exists calculate day value
if os.path.isfile(rsamfile):
  #read input data file
  st = read(rsamfile)
  st.merge(fill_value = 'interpolate')    #in case stream has more than one trace
  tr = st[0]
  day[0] = tr.data.mean()	#mean value for the day
else:
  #file does not exist, assign a value of -1 as day value
  day[0] = -1

if not os.path.isfile(yrsamfile):
  #start new year file 
  station = tr.stats.station      #DRZ
  network = tr.stats.network      #CH
  location = tr.stats.location    #10
  channel = tr.stats.channel      #EHZ
  starttime = tr.stats.starttime  #2005-10-06T07:21:59.849998Z
  delta = 86400                   #one day interval
  npts = 1		          #single value, mean
  #write file
  stats = {'network': network, 'station': station, 'location': location,
         'channel': channel, 'npts': npts, 'delta': delta,
         'mseed': {'dataquality': 'D'}, 'starttime': starttime}
  st = Stream([Trace(data=day, header=stats)])
  st.write(yrsamfile, format='MSEED', reclen=256)
else:
  #append to existing file
  yr = read(yrsamfile)[0]
  year = yr.data
  year = np.append(year, day[0])
  station = yr.stats.station      #DRZ
  network = yr.stats.network      #CH
  location = yr.stats.location    #10
  channel = yr.stats.channel      #EHZ
  starttime = yr.stats.starttime  #2005-10-06T07:21:59.849998Z
  delta = 86400                   #one day interval
  npts = len(year)    
  #write file
  stats = {'network': network, 'station': station, 'location': location,
         'channel': channel, 'npts': npts, 'delta': delta,
         'mseed': {'dataquality': 'D'}, 'starttime': starttime}
  st = Stream([Trace(data=year, header=stats)])
  st.write(yrsamfile, format='MSEED', reclen=256)

