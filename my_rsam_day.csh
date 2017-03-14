#!/bin/csh
#my_rsam_day.csh

#run by crontab to make a daily file from 10 min files

set yesterday = `date -u -d 'yesterday' +%Y%m%d`

#DRZ.10-EHZ.NZ
rsam_day.py DRZ.10-EHZ.NZ ./workdir $yesterday ./workdir bp 1 4

#MAVZ.10-HHZ.NZ
rsam_day.py MAVZ.10-HHZ.NZ ./workdir $yesterday ./workdir bp 1 4

#WIZ.10-HHZ.NZ
rsam_day.py WIZ.10-HHZ.NZ ./workdir $yesterday ./workdir bp 2 5

#WSRZ.10-HHZ.NZ
rsam_day.py WSRZ.10-HHZ.NZ ./workdir $yesterday ./workdir bp 2 5

#RAR.10-BHZ.IU
rsam_day.py RAR.10-BHZ.IU ./workdir $yesterday ./workdir bp 1.5 6
