#!/usr/bin/env python
# rsam_plot_day.py
# plot rsam data for one channel and filter type
# uses files containing a single value for each day, rather than 10 min values

import matplotlib
matplotlib.use('Agg')

import matplotlib.pyplot as plt
import datetime as dt
from matplotlib.dates import date2num
from matplotlib.dates import num2date
from obspy.core import read, Trace, Stream
import sys
import os
import numpy as np
from matplotlib.dates import YearLocator, MonthLocator, DayLocator, DateFormatter
import scipy as sp

# start here
if (len(sys.argv) < 7) | (len(sys.argv) > 9):
    sys.exit(
        "syntax rsam_plot_day.py site(DRZ.10-EHZ.CH) rsam_dir year1(yyyy) year2(yyyy) plot_dir filter(lp,hp,bp,none) [f1 f2]")
else:
    site = sys.argv[1]
    rsam_dir = sys.argv[2]
    year1 = int(sys.argv[3])
    year2 = int(sys.argv[4])
    plot_dir = sys.argv[5]
    plot_file = os.path.join(plot_dir, 'rsam_plot_day.png')
if len(sys.argv) == 7:  # filter = none
    filtype = sys.argv[6]
elif len(sys.argv) == 8:  # filter = lp or hp, one frequency given
    filtype = sys.argv[6]
    f = float(sys.argv[7])
elif len(sys.argv) == 9:  # filter = bp, two frequencies given
    filtype = sys.argv[6]
    f1 = float(sys.argv[7])
    f2 = float(sys.argv[8])

# site dir like DRZ.CH
site_dir = str.split(site, '.')[0] + '.' + str.split(site, '.')[2]

# make list of years
year2ori = year2
year2 = year2 + 1  # so year range is inclusive
y1 = str(year1)
y2 = str(year2ori)
years = np.arange(year1,  year2, 1)

st = Stream()  # create empty stream
for year in years:
    # get rsam file name
    y = str(year)
    if filtype == 'none':
        rsamfile = os.path.join(rsam_dir, site_dir, y + '.' + site + '.rsam')
    elif (filtype == 'lp') | (filtype == 'hp'):
        strf = '%.2f' % f  # string version with 2 decimal places
        rsamfile = os.path.join(
            rsam_dir, site_dir, y + '.' + site + '.' + filtype + '_' + strf + '.rsam')
    elif filtype == 'bp':
        strf1 = '%.2f' % f1  # string version with 2 decimal places
        strf2 = '%.2f' % f2  # string version with 2 decimal places
        rsamfile = os.path.join(
            rsam_dir, site_dir, y + '.' + site + '.' + filtype + '_' + strf1 + '-' + strf2 + '.rsam')

    # process rsamfile
    if os.path.isfile(rsamfile):
        st += read(rsamfile)

# merge to single stream
st.merge(fill_value='interpolate')
tr = st[0]

# plot
start = date2num(tr.stats.starttime.datetime)  # as decimal years
end = date2num(tr.stats.endtime.datetime)

# time values
t = sp.linspace(start, end, tr.stats.npts)

# plot
#date and time
now = dt.datetime.now()

# final value and time
lastval = str(int(tr.data[len(tr) - 1]))
lasttim = tr.stats.endtime.strftime("%F")

if filtype == 'none':
    #title = 'RSAM: ' + site + ', date: ' + y1 + '-' + y2 + ' UT, filter: ' + filtype + ', plotted at: ' + now.strftime("%Y-%m-%d %H:%M")
    title = 'RSAM: ' + site + ', date: ' + y1 + '-' + y2 + ' UT, filter: ' + \
        filtype + ', last value: ' + lastval + ' at ' + lasttim
elif (filtype == 'lp') | (filtype == 'hp'):
    #title = 'RSAM: ' + site + ', date: ' + y1 + '-' + y2 + ' UT, filter: ' + filtype + ' ' + strf + ' Hz' + ', plotted at: ' + now.strftime("%Y-%m-%d %H:%M")
    title = 'RSAM: ' + site + ', date: ' + y1 + '-' + y2 + ' UT, filter: ' + \
        filtype + ' ' + strf + ' Hz' + \
            ', last value: ' + lastval + ' at ' + lasttim
elif filtype == 'bp':
    #title = 'RSAM: ' + site + ', date: ' + y1 + '-' + y2 + ' UT, filter: ' + filtype + ' ' + strf1 + ' - ' + strf2 + ' Hz' + ', plotted at: ' + now.strftime("%Y-%m-%d %H:%M")
    title = 'RSAM: ' + site + ', date: ' + y1 + '-' + y2 + ' UT, filter: ' + filtype + \
        ' ' + strf1 + ' - ' + strf2 + ' Hz' + \
            ', last value: ' + lastval + ' at ' + lasttim

fig = plt.figure(figsize=(15, 5))
ax = fig.add_subplot(111)

minormonths = MonthLocator(interval=1)
ax.xaxis.set_minor_locator(minormonths)
ax.grid(True)

maxy = 1.1 * tr.data.max()
plt.ylim(ymin=0, ymax=maxy)

plt.title(title)
plt.ylabel('Ground Velocity (nm/s)')
plt.plot_date(t, tr.data, linestyle='-', marker='None', color='red')
plt.savefig(plot_file, dpi=200)
# plt.show()
