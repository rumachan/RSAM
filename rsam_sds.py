#!/usr/bin/env python
#rsam_sds.py
#process one day of SDS format mseed data
#time for rsam value is start of ten minute interval

#file length is (approximately) one day, can be a few seconds over or under so
#file does not contain exactly 144 x 10 minute segments

import numpy as np
import sys
from subprocess import call
import os
import obspy
from obspy.core import read, Trace, Stream, UTCDateTime
from obspy.clients.fdsn import Client
import datetime as dt
import urllib2

#location of geonet response files
respdir = 'ftp://ftp.geonet.org.nz/seed/RESPONSE'
cwb_bin = '/usr/local/bin/GeoNetCWBQuery-4.2.0-bin.jar'

#input arguments
if (len(sys.argv) < 7) | (len(sys.argv) > 9):
  sys.exit("syntax rsam.py stream(DRZ.10-EHZ.CH) data_dir date(yyyymmdd) out_dir response filter(lp,hp,bp,none) [f1 f2]")
else:
  stream = sys.argv[1]
  base_dir = sys.argv[2]
  date = sys.argv[3]
  out_dir = sys.argv[4]
  resp = sys.argv[5]	#correct response y/n
if len(sys.argv) == 7:	#filter = none
  filtype = sys.argv[6]	
elif len(sys.argv) == 8:  #filter = lp or hp, one frequency given
  filtype = sys.argv[6]	
  f = float(sys.argv[7])
elif len(sys.argv) == 9:  #filter = bp, two frequencies given
  filtype = sys.argv[6]	
  f1 = float(sys.argv[7])
  f2 = float(sys.argv[8])

#initialise data array for rsam values
#one extra element, just in case
data = np.zeros(145)

#get data file name and location
net = str.split(stream, '.')[2]	#NZ
site = str.split(stream, '.')[0]	#DRZ
tmp = str.split(stream, '.')[1]	#10-EHZ
loc = str.split(tmp, '-')[0]	#EHZ
cmp = str.split(tmp, '-')[1]	#EHZ
dd = dt.datetime.strptime(date, '%Y%m%d')	#into correct format
data_dir = '/tmp'
name = net + '.' + site + '.' + loc + '.' + cmp + '.' + 'D' + '.' + dd.strftime("%Y.%j")	#NZ.WIZ.10.HHZ.D.2013.121
datafile = os.path.join(data_dir, name)	#/geonet/seismic/sds/2013/NZ/WIZ/HHZ.D/NZ.WIZ.10.HHZ.D.2013.121
if net == 'NZ':
    c = Client(base_url='http://beta-service-nrt.geonet.org.nz')
    start = UTCDateTime(dd)
    end = start + 86400
    try:
        s = c.get_waveforms(net,site,loc,cmp,start,end)
    except obspy.io.mseed.ObsPyMSEEDFilesizeTooSmallError:
	sys.stderr.write("No data found for %s\n"%('.'.join((net, site, loc, cmp))))
	sys.exit(0)
    s.write(datafile,'MSEED')
    if False:
        # For NZ stations use CWB until FDSN is stable
        NSCL = '{0:.<2s}{1:.<5s}{2:.<3s}{3:.<2s}'.format(net,site,cmp,loc)
        cwb_cmd = ['java','-jar',cwb_bin, '-t','ms','-d','1d','-b',dd.strftime("%Y/%m/%d %H:%M:%S"),'-s',nscl,'-o',datafile]
        call(cwb_cmd)
elif net == 'IU':
    # For IU use IRIS FDSNws
    c = Client('IRIS')
    start = UTCDateTime(dd)
    end = start + 86400
    s = c.get_waveforms(net,site,loc,cmp,start,end)
    s.write(datafile,'MSEED')
else:
    raise Exception("Don't know how to request data for network {:s}".format(net))

#check if data file exists
if not os.path.isfile(datafile):
  sys.stderr.write("datafile %s not found\n" % datafile)
  sys.exit(0)

#read input data file
st = read(datafile)
st.merge(fill_value = 'interpolate')    #in case stream has more than one trace
tr = st[0]

#data file details
station = tr.stats.station	#DRZ
network = tr.stats.network	#CH
location = tr.stats.location	#10
channel = tr.stats.channel	#EHZ
starttime = tr.stats.starttime	#2005-10-06T07:21:59.849998Z

#get response information?
if resp == 'resp':
  #response file name
  respfile = os.path.join(respdir, station + '.' + network, 'RESP' + '.' + network + '.' + station + '.' + location + '.' + channel)
  #get response file, store locally as file called respfile
  response = urllib2.urlopen(respfile)
  file = 'respfile'
  fh = open(file, "w")
  fh.write(response.read())
  fh.close()
  #response info
  seedresp = {'filename': 'respfile', 'date': starttime, 'units': 'VEL'}
  # define a filter band to prevent amplifying noise during the deconvolution
  #wide values 'typical' short-period rsam
  fl1 = 0.005
  fl2 = 0.006
  fl3 = 40.0
  fl4 = 45.0

#get rsam output file name
if filtype == 'none':
  rsam_name = dd.strftime("%Y.%j") + '.' + stream + '.rsam'	#2011.091.DRZ.10-EHZ.CH.rsam
elif (filtype == 'lp') | (filtype == 'hp'):
  strf = '%.2f' %f	#string version with 2 decimal places
  rsam_name = dd.strftime("%Y.%j") + '.' + stream + '.' + filtype + '_' + strf + '.rsam'	#2011.091.DRZ.10-EHZ.CH.freq_2.0-10.0.rsam
elif filtype == 'bp':
  strf1 = '%.2f' %f1	#string version with 2 decimal places
  strf2 = '%.2f' %f2	#string version with 2 decimal places
  rsam_name = dd.strftime("%Y.%j") + '.' + stream + '.' + filtype + '_' + strf1 + '-' + strf2 + '.rsam'	#2011.091.DRZ.10-EHZ.CH.freq_2.0-10.0.rsam
rsampath = os.path.join(out_dir, site + '.' + net)	#out_dir/DRZ.CH
rsamfile = os.path.join(out_dir, site + '.' + net, rsam_name)	#out_dir/DRZ.CH/2011.091.DRZ.10-EHZ.CH.rsam
#print rsamfile

#make rsam folder if required
if not os.path.exists(rsampath):
  os.makedirs(rsampath)

t = tr.stats.starttime
index = 0
#loop through data in 600sec (10 min) blocks
while t < tr.stats.endtime:
  tr_10m = tr.slice(t, t + 600)

  duration = tr_10m.stats.npts * tr_10m.stats.delta
  #print index, duration
  if duration >= 500:
    if duration < 600:
      tr_10m = tr.slice(tr.stats.endtime - 600, tr.stats.endtime) 
    #correct response?
    if resp == 'resp':
      tr_10m.simulate(paz_remove=None, pre_filt=(fl1, fl2, fl3, fl4), seedresp=seedresp)

    #detrend and filter
    tr_10m.detrend(type='constant')
    if filtype == 'lp':
      #print 'lowpass'
      tr_10m.filter('lowpass', freq=f, corners=4, zerophase=False)
    elif filtype == 'hp':
      #print 'highpass'
      tr_10m.filter('highpass', freq=f, corners=4, zerophase=False)
    elif filtype == 'bp':
      #print 'bandpass'
      tr_10m.filter('bandpass', freqmin=f1, freqmax=f2, corners=4, zerophase=False)

    absolute = np.absolute(tr_10m.data)	#absolute value
    tr_10m.data = absolute	#assign back to trace
    mean = tr_10m.data.mean()
    if resp == 'resp':
      mean = mean / 1e-9	#convert to nanometres so dealing with whole numbers
    data[index] = mean
    index += 1
    #end if 
  t += 600
#end loop through data in 600sec (10 min) blocks

#resize data to remove any unused elements
data = np.resize(data, index)

#write mseed format file
#mseed header attributes
delta = 600	#10 min
stats = {'network': network, 'station': station, 'location': location,
         'channel': channel, 'npts': len(data), 'delta': delta,
         'mseed': {'dataquality': 'D'}, 'starttime': starttime}
st = Stream([Trace(data=data, header=stats)])
st.write(rsamfile, format='MSEED', reclen=256)
