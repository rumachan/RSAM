#!/usr/bin/env python
# rsam_data.py
# output rsam data from one file as ascii

import datetime as dt
import os
import sys
from obspy.core import read, Trace, Stream

# input arguments
if (len(sys.argv) < 5) | (len(sys.argv) > 7):
    sys.exit(
        "syntax rsam_data.py site(DRZ.10-EHZ.CH) rsam_dir date(yyyymmdd) filter(lp,hp,bp,none) [f1 f2]")
else:
    site = sys.argv[1]
    rsam_dir = sys.argv[2]
    date = sys.argv[3]
if len(sys.argv) == 5:  # filter = none
    filtype = sys.argv[4]
elif len(sys.argv) == 6:  # filter = lp or hp, one frequency given
    filtype = sys.argv[4]
    f = float(sys.argv[5])
elif len(sys.argv) == 7:  # filter = bp, two frequencies given
    filtype = sys.argv[4]
    f1 = float(sys.argv[5])
    f2 = float(sys.argv[6])


# get data rsam file name
site_dir = str.split(site, '.')[0] + '.' + str.split(site, '.')[2]  # DRZ.CH
dd = dt.datetime.strptime(date, '%Y%m%d')  # into correct format

if filtype == 'none':
    # 2011.091.DRZ.10-EHZ.CH.rsam
    rsam_name = dd.strftime("%Y.%j") + '.' + site + '.rsam'
elif (filtype == 'lp') | (filtype == 'hp'):
    strf = '%.2f' % f  # string version with 2 decimal places
    # 2011.091.DRZ.10-EHZ.CH.freq_2.0-10.0.rsam
    rsam_name = dd.strftime(
        "%Y.%j") + '.' + site + '.' + filtype + '_' + strf + '.rsam'
elif filtype == 'bp':
    strf1 = '%.2f' % f1  # string version with 2 decimal places
    strf2 = '%.2f' % f2  # string version with 2 decimal places
    # 2011.091.DRZ.10-EHZ.CH.freq_2.0-10.0.rsam
    rsam_name = dd.strftime("%Y.%j") + '.' + site + \
        '.' + filtype + '_' + strf1 + '-' + strf2 + '.rsam'

# rsam_dir/DRZ.CH/2011.091.DRZ.10-EHZ.CH.rsam
rsamfile = os.path.join(rsam_dir, site_dir, rsam_name)
# print rsamfile

# check if rsamfile exists
if not os.path.isfile(rsamfile):
    print "rsamfile %s not found" % rsamfile
    sys.exit

# read input data file
st = read(rsamfile)
tr = st[0]

# mean value
#mean = tr.data.mean()
# print mean

# output ascii
st.write('rsam.ascii', format='TSPAIR')
