#!/usr/bin/env python
#rsamfile2ascii.py
#output rsam data from one file as ascii

import os
import sys
from obspy.core import read, Trace, Stream

if (len(sys.argv) != 3):
  sys.exit("syntax rsamfile2ascii.py rsamfile rsamout")
else:
  rsamfile = sys.argv[1]
  rsamout = sys.argv[2]

if not os.path.isfile(rsamfile):
  print ("rsamfile %s not found" % rsamfile)
  sys.exit

#read input data file
st = read(rsamfile)
tr = st[0]

#output ascii
st.write(rsamout, format='TSPAIR')
