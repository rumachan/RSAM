#!/usr/bin/env python
# rsam.py
# process one day of data GeoNet format mseed data
# time for rsam value is start of ten minute interval

# file length is (approximately) one day, can be a few seconds over or under so
# file does not contain exactly 144 x 10 minute segments

import numpy as np
import sys
import os
from obspy.core import read, Trace, Stream
from obspy.signal import cosTaper
import datetime as dt
import urllib

# location of geonet response files
respdir = 'ftp://ftp.geonet.org.nz/seed/RESPONSE'

# input arguments
if (len(sys.argv) < 7) | (len(sys.argv) > 9):
    sys.exit(
        "syntax rsam.py site(DRZ.10-EHZ.CH) data_dir date(yyyymmdd) out_dir response filter(lp,hp,bp,none) [f1 f2]")
else:
    site = sys.argv[1]
    base_dir = sys.argv[2]
    date = sys.argv[3]
    out_dir = sys.argv[4]
    resp = sys.argv[5]  # correct response y/n
if len(sys.argv) == 7:  # filter = none
    filtype = sys.argv[6]
elif len(sys.argv) == 8:  # filter = lp or hp, one frequency given
    filtype = sys.argv[6]
    f = float(sys.argv[7])
elif len(sys.argv) == 9:  # filter = bp, two frequencies given
    filtype = sys.argv[6]
    f1 = float(sys.argv[7])
    f2 = float(sys.argv[8])

# initialise data array for rsam values
# one extra element, just in case
data = np.zeros(145)

# get data file name and location
site_dir = str.split(site, '.')[0] + '.' + str.split(site, '.')[2]  # DRZ.CH
dd = dt.datetime.strptime(date, '%Y%m%d')  # into correct format
# /geonet/seismic/mseed/2011/2011.091/DRZ.CH
data_dir = os.path.join(base_dir, dd.strftime("%Y/%Y.%j"), site_dir)
name = dd.strftime("%Y.%j") + '.' + site + '.D'  # 2011.091.DRZ.10-EHZ.CH.D
# /geonet/seismic/mseed/2011/2011.091/DRZ.CH/2011.091.DRZ.10-EHZ.CH.D
datafile = os.path.join(data_dir, name)

# check if data file exists
if not os.path.isfile(datafile):
    print "datafile %s not found" % datafile
    sys.exit

# read input data file
st = read(datafile)
st.merge(fill_value='interpolate')  # in case stream has more than one trace
tr = st[0]

# data file details
station = tr.stats.station  # DRZ
network = tr.stats.network  # CH
location = tr.stats.location  # 10
channel = tr.stats.channel  # EHZ
starttime = tr.stats.starttime  # 2005-10-06T07:21:59.849998Z

# get response information?
if resp == 'resp':
    # response file name
    respfile = os.path.join(respdir, station + '.' + network, 'RESP' +
                            '.' + network + '.' + station + '.' + location + '.' + channel)
    # get response file, store locally as file called response
    urllib.urlretrieve(respfile, 'respfile')
    # response info
    seedresp = {'filename': 'respfile', 'date': starttime, 'units': 'VEL'}
    # define a filter band to prevent amplifying noise during the deconvolution
    # wide values 'typical' short-period rsam
    fl1 = 0.005
    fl2 = 0.006
    fl3 = 40.0
    fl4 = 45.0

# get rsam output file name
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
rsampath = os.path.join(out_dir, site_dir)  # out_dir/DRZ.CH
# out_dir/DRZ.CH/2011.091.DRZ.10-EHZ.CH.rsam
rsamfile = os.path.join(out_dir, site_dir, rsam_name)
# print rsamfile

# make rsam folder if required
if not os.path.exists(rsampath):
    os.makedirs(rsampath)

t = tr.stats.starttime
index = 0
# loop through data in 600sec (10 min) blocks
while t < tr.stats.endtime:
    tr_10m = tr.slice(t, t + 600)

    duration = tr_10m.stats.npts * tr_10m.stats.delta
    # print index, duration
    if duration >= 500:
        if duration < 600:
            tr_10m = tr.slice(tr.stats.endtime - 600, tr.stats.endtime)
        # correct response?
        if resp == 'resp':
            tr_10m.simulate(
                paz_remove=None, pre_filt=(fl1, fl2, fl3, fl4), seedresp=seedresp)

        #detrend and filter
        tr_10m.detrend(type='constant')
        if filtype == 'lp':
            # print 'lowpass'
            tr_10m.filter('lowpass', freq=f, corners=4, zerophase=False)
        elif filtype == 'hp':
            # print 'highpass'
            tr_10m.filter('highpass', freq=f, corners=4, zerophase=False)
        elif filtype == 'bp':
            # print 'bandpass'
            tr_10m.filter(
                'bandpass', freqmin=f1, freqmax=f2, corners=4, zerophase=False)
# win_cos = cosTaper(tr.stats.npts, 0.0001) #cosine taper 0.05%
# filt = tr.data*win_cos	#filtered data
# absolute = np.absolute(filt)	#absolute value
# tr.data = absolute	#assign back to trace

        absolute = np.absolute(tr_10m.data)  # absolute value
        tr_10m.data = absolute  # assign back to trace
        mean = tr_10m.data.mean()
        if resp == 'resp':
            # convert to nanometres so dealing with whole numbers
            mean = mean / 1e-9
        data[index] = mean
        index += 1
        # end if
    t += 600
# end loop through data in 600sec (10 min) blocks

# resize data to remove any unused elements
data = np.resize(data, index)

# write mseed format file
# mseed header attributes
delta = 600  # 10 min
stats = {'network': network, 'station': station, 'location': location,
         'channel': channel, 'npts': len(data), 'delta': delta,
         'mseed': {'dataquality': 'D'}, 'starttime': starttime}
st = Stream([Trace(data=data, header=stats)])
st.write(rsamfile, format='MSEED', reclen=256)
