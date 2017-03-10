#!/bin/csh
#my_rsam_day.csh

#run by crontab to make a daily file from 10 min files

set yesterday = `date -u -d 'yesterday' +%Y%m%d`

#DRZ.10-EHZ.NZ
/home/sherburn/scripts/rsam_day.py DRZ.10-EHZ.NZ /home/sherburn/data1/rsam_data $yesterday /home/sherburn/data1/rsam_data bp 1 4

#MAVZ.10-HHZ.NZ
/home/sherburn/scripts/rsam_day.py MAVZ.10-HHZ.NZ /home/sherburn/data1/rsam_data $yesterday /home/sherburn/data1/rsam_data bp 1 4

#WIZ.10-HHZ.NZ
/home/sherburn/scripts/rsam_day.py WIZ.10-HHZ.NZ /home/sherburn/data1/rsam_data $yesterday /home/sherburn/data1/rsam_data bp 2 5

#WSRZ.10-HHZ.NZ
/home/sherburn/scripts/rsam_day.py WSRZ.10-HHZ.NZ /home/sherburn/data1/rsam_data $yesterday /home/sherburn/data1/rsam_data bp 2 5

#RAR.10-BHZ.IU
/home/sherburn/scripts/rsam_day.py RAR.10-BHZ.IU /home/sherburn/data1/rsam_data $yesterday /home/sherburn/data1/rsam_data bp 1.5 6
