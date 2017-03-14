#!/usr/bin/env python
# rsam_plot.py
# plot rsam data for one channel and filter type

import matplotlib
matplotlib.use('Agg')

import matplotlib.pyplot as plt
import datetime as dt
from matplotlib.dates import date2num
from matplotlib.dates import num2date
import matplotlib.dates as mdates
import matplotlib.ticker as mticker
from obspy.core import read, Trace, Stream
import sys
import os
import numpy as np
import scipy as sp
import datetime

# start here
if (len(sys.argv) < 7) | (len(sys.argv) > 9):
    sys.exit(
        "syntax rsam_plot.py site(DRZ.10-EHZ.CH) rsam_dir date1(yyyymmdd) date2(yyyymmdd) plot_dir filter(lp,hp,bp,none) [f1 f2]")
else:
    site = sys.argv[1]
    rsam_dir = sys.argv[2]
    date1 = sys.argv[3]
    date2 = sys.argv[4]
    plot_dir = sys.argv[5]
    plot_file = os.path.join(plot_dir, 'rsam_plot.png')
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

# format dates as datetime variables
d1 = dt.datetime.strptime(date1, '%Y%m%d')
yd1 = date2num(d1)
d2 = dt.datetime.strptime(date2, '%Y%m%d')
yd2 = date2num(d2)
yd2 = yd2 + 1  # so date range is inclusive
dates = num2date(np.arange(yd1, yd2, 1))

st = Stream()  # create empty stream
for date in dates:
    # get rsam file name
    yd = date.strftime("%Y.%j")
    if filtype == 'none':
        rsamfile = os.path.join(rsam_dir, site_dir, yd + '.' + site + '.rsam')
    elif (filtype == 'lp') | (filtype == 'hp'):
        strf = '%.2f' % f  # string version with 2 decimal places
        rsamfile = os.path.join(
            rsam_dir, site_dir, yd + '.' + site + '.' + filtype + '_' + strf + '.rsam')
    elif filtype == 'bp':
        strf1 = '%.2f' % f1  # string version with 2 decimal places
        strf2 = '%.2f' % f2  # string version with 2 decimal places
        rsamfile = os.path.join(
            rsam_dir, site_dir, yd + '.' + site + '.' + filtype + '_' + strf1 + '-' + strf2 + '.rsam')

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
#t = np.arange(start, end, tr.stats.delta/86400)
t = sp.linspace(start, end, tr.stats.npts)

# plot
#date and time
now = datetime.datetime.now()

if filtype == 'none':
    title = 'RSAM: ' + site + ', date: ' + date1 + '-' + date2 + \
        ' UT, filter: ' + filtype + ', plotted at: ' + \
            now.strftime("%Y-%m-%d %H:%M")
elif (filtype == 'lp') | (filtype == 'hp'):
    title = 'RSAM: ' + site + ', date: ' + date1 + '-' + date2 + ' UT, filter: ' + \
        filtype + ' ' + strf + ' Hz' + ', plotted at: ' + \
            now.strftime("%Y-%m-%d %H:%M")
elif filtype == 'bp':
    title = 'RSAM: ' + site + ', date: ' + date1 + '-' + date2 + ' UT, filter: ' + filtype + \
        ' ' + strf1 + ' - ' + strf2 + ' Hz' + \
            ', plotted at: ' + now.strftime("%Y-%m-%d %H:%M")
fig = plt.figure(figsize=(15, 5))

maxy = 1.1 * tr.data.max()
plt.ylim(ymin=0, ymax=maxy)

plt.title(title)
plt.ylabel('Ground Velocity (nm/s)')
plt.plot_date(t, tr.data, linestyle='-', marker='None', color='red')
plt.savefig(plot_file, dpi=200)
# plt.show()
